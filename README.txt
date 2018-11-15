Counter of code and comment lines.

Takes into account single comment lines and multi-line comments.
If a line contains both an instruction and a comment, the comment
will be ignored.

Empty lines are ignored.

The symbol definitions that allow the detection of comments are
read from separate files which names follow the pattern:
   lcount-def.<langage-extension>.sh
Files with an extension that doesn't match any lcount-def.*
extensions are ignored.

Explores recursively the given directory, but doesn't follow
symbolic links.

Results are printed on the standard output in a CSV compatible
format (using ";" as field separator) with the following fields:
* TYPE: the file extension
* FILE: the file name, with its relative path
* TOTAL: total number of lines in the file (including empty lines)
* EMPTY: total number of empty lines in the file
* COMMENTS : total number of comment lines in the file
* CODE: total number of code lines in the file
