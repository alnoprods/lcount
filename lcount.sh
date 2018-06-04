#!/bin/sh

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
# will ignored.
#
# Empty lines are ignored.
#
# The symbol definitions that allow the detection of comments are
# read from separate files which names follow the pattern:
#    lcount-def.<langage>.sh
# Files with an extension that doesn't match any lcount-def.*
# extensions are ignored.
#
# Explores recursively the given directory, but doesn't follow
# symbolic links.
# ==================================================================

# Error codes
ERR_INVALID_PARAM_NUMBER=1
ERR_INVALID_PARAM_TYPE=2

# Usage info about the current script
usage()
{
	MSG=$1
	echo "Usage:" $(basename $0) "<dir>";
	echo "$MSG";
}

# Checking the parameters
check_params()
{
	# Requires one parameter
	if [ $# -ne 1 ]; then
		usage "Requires exactly one parameter (which should be a directory)";
		exit $ERR_INVALID_PARAM_NUMBER;
	fi

	# Check the parameter type
	export DIR=$1
	if [ ! -d $DIR ]; then
		usage "Requires a directory as its only parameter ('$DIR' is not a valid directory)";
		exit $ERR_INVALID_PARAM_TYPE;
	fi
}

# Processing a single file
process_file()
{
	FILE=$1
	
	# Default marker is a non-effective marker (detecting an empty line)
	DEFAULT="/^$/"
	
	# Get the file extension
	EXT=${FILE##*.}
	
	# Get the comment defs for this extension (if existing)
	DEFS=$(echo lcount-def.$EXT.sh)
	if [ -f $DEFS ]; then
		# Default value is an empty line detector
		SLC=$DEFAULT
		MLC=$DEFAULT
		
		# Load the defs ($SLC, $MLC)
		. $(dirname $0)/$DEFS;
		
		# Count all the non-empty lines
		awk 'NF > 0' $FILE | awk 'BEGIN { }
'$SLC' { ++SLC }
'$MLC' { ++MLC }
END {
printf("'$EXT'; '$FILE'; %4d; %4d; %4d\n", NR, SLC + MLC, NR - SLC - MLC);
} '
	fi
}	

# ==================================================================
# Main program
# ==================================================================
check_params $*
echo "TYPE; FILE; TOTAL; COMMENTS; CODE";
for FILENAME in $(find $DIR -type f); do
	process_file $FILENAME;
done


