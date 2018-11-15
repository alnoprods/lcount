-- # ==================================================================
-- #    Copyright (C) 2018 Alexandre Nouvel - http://alnoprods.net
-- #
-- #    This program is free software: you can redistribute it and/or modify
-- #    it under the terms of the GNU Affero General Public License as published
-- #    by the Free Software Foundation, either version 3 of the License, or
-- #    (at your option) any later version.
-- #
-- #    This program is distributed in the hope that it will be useful,
-- #    but WITHOUT ANY WARRANTY; without even the implied warranty of
-- #    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- #    GNU Affero General Public License for more details.
-- #
-- #    You should have received a copy of the GNU Affero General Public License
-- #    along with this program.  If not, see <http://www.gnu.org/licenses/>.
-- # ==================================================================

    -- single line comment #1 with leading spaces
DROP TABLE IF EXISTS someTable;
CREATE TABLE someTable (
	-- single line comment #2 with leading tab
    field1 INT,
    field2 VARCHAR(255)
);

INSERT INTO someTable VALUE (1, "someText");

  ##
	##  -- This block is counted as 8 comment lines.
  ##
  ##  Total lines:         36
  ##  Total empty lines:    3
  ##  Total comment lines: 26 (single: 26, multi: 0)
  ##  Total code lines:     7
  ##
DROP TABLE someTable;