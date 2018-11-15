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

# single line comment #1
export VAR="anyValue"
  # single line comment #2 with leading spaces
	# single line comment #3 with leading tab

usage()
{
    echo "Some hints"
}

if [ $VAR -ne "someValue" ]; then
    usage "Hello world!"
  ##
	##  This block is counted as 8 comment lines.
  ##
  ##  Total lines:         40
  ##  Total empty lines:    4
  ##  Total comment lines: 28 (single: 28, multi: 0)
  ##  Total code lines:     8
  ##
fi