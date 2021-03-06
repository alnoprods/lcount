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
# Php source code file.
# ==================================================================

# Single line comment markers: starts with // or #
export SLC="/^\\s*(\\/\\/|#)/"

# Multi line comment markers: starts with /* and ends with */
MLC_START="^\\s*\\/\\*"
MLC_STOP="\\*\\/"
export MLC="/$MLC_START/,/$MLC_STOP/"
