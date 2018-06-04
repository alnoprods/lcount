Counter of code and comment lines.

Takes into account single comment lines and multi-line comments.
If a line contains both an instruction and a comment, the comment
will ignored.

Empty lines are ignored.

The symbol definitions that allow the detection of comments are
read from separate files which names follow the pattern:
   lcount-def.<langage>.sh
Files with an extension that doesn't match any lcount-def.*
extensions are ignored.

Explores recursively the given directory, but doesn't follow
symbolic links.
