/*
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
 */

// single line comment #1
public class Toto {
  // single line comment #2 with leading spaces
	// single line comment #3 with leading tab
  /** counted as a 1 line multi-line comment. */
  public final static String CONST_STR; // ignored comment

  /**
   * Multi line comment (counted as 3 comment lines).
   */
  public String sampleMethod() {
     String useless = "useless";
	
     return "Hello"; 
  }
  
  /*
    This block is counted as 6 comment lines (the empty line below is not counted).

    Total lines:         38
    Total comment lines: 31 (single: 3, multi: 28)
    Total code lines:     7
  */
}
