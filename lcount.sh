#!/bin/bash

# ==================================================================
#    Copyright (C) 2018 Alexandre Nouvel - http://alnoprods.net
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Affero General Public License as published
#    by the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Affero General Public License for more details.
#
#    You should have received a copy of the GNU Affero General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
# ==================================================================

# ==================================================================
# Counter of code and comment lines.
# 
# Takes into account single comment lines and multi-line comments.
# If a line contains both an instruction and a comment, the comment
# will be ignored.
# 
# Empty lines are ignored.
# 
# The symbol definitions that allow the detection of comments are
# read from separate files which names follow the pattern:
#    lcount-def.<langage-extension>.sh
# Files with an extension that doesn't match any lcount-def.*
# extensions are ignored.
# 
# Explores recursively the given directory, but doesn't follow
# symbolic links.
# 
# Results are printed on the standard output in a CSV compatible
# format (using ";" as field separator) with the following fields:
# * TYPE: the file extension
# * FILE: the file name, with its relative path
# * TOTAL: total number of lines in the file (including empty lines)
# * EMPTY: total number of empty lines in the file
# * COMMENTS : total number of comment lines in the file
# * CODE: total number of code lines in the file
# ==================================================================

# Error codes
ERR_INVALID_PARAM_NUMBER=1
ERR_INVALID_PARAM_TYPE=2

# ==================================================================
# Displays usage info about the current script.
# @param $1 the message to display
usage()
{
    MSG="$1"
    echo "Usage:" $(basename $0) "<dir>";
    echo "$MSG";
}

# ==================================================================
# Checks the parameters
# @param $1 the directory to analyse
check_params()
{
    # Requires one parameter
    if [ $# -ne 1 ]; then
        usage "Requires exactly one parameter (which must be a valid directory)";
        exit $ERR_INVALID_PARAM_NUMBER;
    fi

    # Check the parameter type
    export DIR="$1"
    if [ ! -d "$DIR" ]; then
        usage "Requires a directory as its only parameter ('$DIR' is not a valid directory)";
        exit $ERR_INVALID_PARAM_TYPE;
    fi
}

# ==================================================================
# Processes a single file.
# @param $1 the path and name of the file to process
process_file()
{
    FILE="$1"

    # Default marker is a non-effective marker (detecting an empty line)
    DEFAULT="/^$/"

    # Regexp to detect empty lines (including spaces/tabs)
    EMPTY_LINE="^\\s*$"

    # Get the file extension
    EXT=${FILE##*.}

    # Get the comment defs for this extension (if existing)
    DEFS=$(dirname $0)/$(echo lcount-def.$EXT.sh)
    if [ -f $DEFS ]; then
        # Default value is an empty line detector
	SLC=$DEFAULT
	MLC=$DEFAULT

        # Load the defs ($SLC, $MLC)
        . $DEFS;

        # Count all the empty lines
        EMPTY=$(grep -c "$EMPTY_LINE" "$FILE")

        # Count all the non-empty lines
        grep -v "$EMPTY_LINE" "$FILE" | awk '
            BEGIN {}

            '$SLC' {
               # We have a single line comment
               ++SLC
            }

            '$MLC' {
               # We have a multiple line comment
               ++MLC
               if ($0 ~ '$SLC') {
                  # Single line comment patterns that appear into multiple line comments should not be counted
                  --SLC
               }
            }

            END {
               # Output computed data
               printf("'$EXT'; '$FILE'; %4d; %4d; %4d; %4d\n", NR + '$EMPTY', '$EMPTY', SLC + MLC, NR - SLC - MLC);
            } '
        fi
}

# ==================================================================
# Main program
# ==================================================================
# Check the parameters
check_params $*

# Print a headline
echo "TYPE; FILE; TOTAL; EMPTY; COMMENTS; CODE";

# Set the internal field separator to newline only, so that the for loop
#   will correctly break the data returned by find
IFS=$'\n'

# Process each file in the given directory
for FILENAME in $(find "$DIR" -type f); do
    process_file "$FILENAME"
done


