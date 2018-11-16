# Counter of code and comment lines.

## What is it for?
This program counts lines of code and comments of all the files 
in a given directory, provided there is a definition of the 
comment markers for the languages used in the directory files.

## How does it work?
It takes into account single comment lines and multi-line comments.
If a line contains both an instruction and a comment, the comment
will be ignored.

Empty lines are counted separately.

The definitions that allow the detection of comments are 
read from separate files which names follow this pattern:
```
lcount-def.<langage-extension>.sh
```

Files with an extension that doesn't match any lcount-def.*
extensions are ignored.

The program explores recursively the given directory, but
doesn't follow symbolic links.

Results are printed on the standard output in a CSV compatible
format (using `;` as field separator) with the following fields:
* `TYPE`: the file extension
* `FILE`: the file name, with its relative path
* `TOTAL`: total number of lines in the file (including empty lines)
* `EMPTY`: total number of empty lines in the file
* `COMMENTS` : total number of comment lines in the file
* `CODE`: total number of code lines in the file

## How to use it?
Download and put it in any directory of a Unix/Linux system 
(including Cygwin). Add this directory to your `PATH` variable.

Use the command:
```
lcount.sh <directory-to-analyse>
```

It is usually more convenient to redirect the output do a CSV file:
```
lcount.sh <directory-to-analyse> > <result-file>.csv
```

The CSV file can be opened by any spreadsheet processor to compute
the rate of comment over code per file, etc.

## What if a language definition is missing?
Just add a file with the regular expressions needed to define
single and multiple line comment markers.

In this file you'll have to define one of the following 
shell variables, or both of them if necessary:
* `SLC`: single line comment marker -- a regular expression
that matches the start of a single line comment in the code. For
example, it should be something like `/^\\s*#/` for `C` language,
which means: a `#` that follows any sequence of blank separators
(i.e. whitespaces or tabs) from the beginning of the line.
* `MLC`: multiple line comment marker -- a regular expression
that matches the beginning and the ending of a multi-line comment.
For example, for `C` language it is `/\\/\\*/,/\\*\\//`, which
means that it starts with the sequence `/*` and ends with the
sequence `*/`.

## Improvements, ideas...
* Don't hesitate to submit new language definition files :)
* Options to configure the program could be helpful
