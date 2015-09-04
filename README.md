{% raw %}
# LFE Reference Guide


## Introduction

This Gitbook (available [here](http://lfe.gitbooks.io/reference-guide/))
is a conversion of Robert Virding's
[LFE User Guide](https://github.com/rvirding/lfe/blob/develop/doc/user_guide.txt).


## Formatting Note

You will see code blocks in this book surrounded by double curly braces,
``{{ ... }}``. This typographic convention is used to denote *optional* 
syntax.

## Building it yourself

The conversion from Markdown into HTML pages etc. is done via the
[gitbook-cli](https://github.com/GitbookIO/gitbook-cli) npm package.

### Requirements

The `Makefile` has a `setup` target that tries to install the two
needed node.js packages.  This works on Unbuntu and hopefully on other
Unix-like systems.

You will also need Node.js installed.

### Viewing the book

Once that is all set up, run `make build` to convert the book into
HTML pages (they will be output in the `_book` subdirectory) or `make
run` to start a server showing the converted pages (this will
automatically update as you edit the files).

{% endraw %}
