# Contributing

simple-markdown extends Vim 9.1's bundled Markdown runtime. Keep additions small,
use the bundled syntax groups and leave syntax, indentation, filetype detection
and folding defaults to Vim. Existing public options retain `g:vim_markdown_*`
names for compatibility.

Use four-space indentation, `l:` prefixes for local variables and `abort` on new
functions. Buffer-local settings, mappings and commands must extend
`b:undo_ftplugin`.

Update both [README.md](README.md) and the hand-written
[help file](doc/simple-markdown.txt) when behaviour changes. Keep SPDX notices
and REUSE.toml accurate.

Run `make test` with Vim 9.1. The Vader and Tabular test dependencies live under
`build/`. Add regression tests for behaviour changes, using the bundled runtime
plus the add-on. Include a small reproducer when reporting an issue.
