# simple-markdown

simple-markdown adds navigation and editing tools to Vim 9.1's bundled Markdown support. It is trimmed from [preservim/vim-markdown](https://github.com/preservim/vim-markdown), with credit to its authors and contributors. Vim supplies filetype detection, syntax highlighting, fenced-language highlighting, YAML frontmatter, indentation defaults and optional heading folding. This plugin loads afterwards, uses the same syntax groups, and adds the tools below.

## Installation

With [vim-plug](https://github.com/junegunn/vim-plug):

```vim
Plug 'pknull/simple-markdown'
" Optional, for :TableFormat:
Plug 'godlygeek/tabular'
```

Enable Vim's filetype plugins and syntax. Folding and embedded languages use Vim's own options:

```vim
filetype plugin indent on
syntax enable
let g:markdown_folding = 1
let g:markdown_fenced_languages = ['sh', 'python', 'bash=sh']
```

Set these options before opening Markdown files. The fold wrapper excludes code blocks and YAML frontmatter from heading folds while keeping Vim's fold text.

## Additions

- `][` / `[]`: next / previous sibling heading; `]u`: parent heading; `]h`: current heading. Vim keeps its `]]` / `[[` mappings. All movements also have `<Plug>Markdown_MoveTo…` mappings; see `:help simple-markdown-mappings`.
- `ge`: edit the linked local file, decoding percent-encoded filenames once. By default, `#anchor` follows a heading, including punctuation-tolerant GitHub-style anchors and setext headings. An anchor-only link stays in the current file.
- `gx`: open the link with netrw. Link detection works on labels, delimiters, URLs, images, automatic links and reference-definition URLs; bare HTTP(S) URLs and syntax-off buffers also work. Links must fit on one line.
- `:Toc`, `:Tocv`, `:Toch`, `:Toct`: show the headings in a location list, respectively in a vertical split (the default), vertical split, horizontal split or tab. `:InsertToc [depth]` and `:InsertNToc [depth]` insert a linked list below the cursor, using bullets or numbered level-two headings. Level-one headings are omitted; an optional maximum depth must be at least 2.
- `:HeaderDecrease`, `:HeaderIncrease`, `:SetexToAtx`: change heading levels or convert setext headings to ATX. Each accepts a range and defaults to the whole file. `:TableFormat` formats the table under the cursor and requires Tabular.
- Blockquotes and list bullets continue on Enter. The plugin sets no indent expression.
- Link brackets and targets, inline-code delimiters and fence lines conceal when Vim's `g:markdown_syntax_conceal` is enabled (the default). Optional link titles remain visible. Embedded language highlighting stays intact. Set `conceallevel=2` to hide concealed text; Vim's `concealcursor` controls visibility on the cursor line.
- Wikilinks conceal as `[[Folder/Page|Label]]` → `Label` and `[[Page]]` → `Page`. Follow them with `ge`, including `#Heading` anchors. Targets are literal filenames, with `.md` tried when omitted: first relative to this note, then relative to the nearest `.obsidian` vault or Git root, then a unique matching name or path suffix inside that root. Missing or ambiguous targets report an error without creating a file. Code and escaped links remain literal.

## Options

Kept options retain their original names. Set them before opening a buffer.

| Option | Default | Effect |
| --- | --- | --- |
| `g:vim_markdown_no_default_key_mappings` | `0` | Set to `1` to use only the add-on's `<Plug>` mappings; Vim's mappings remain. |
| `g:vim_markdown_auto_insert_bullets` | `1` | Set to `0` to continue only blockquotes. |
| `g:vim_markdown_toc_autofit` | `0` | Set to `1` to fit a vertical TOC to its contents, up to half the screen. |
| `g:vim_markdown_borderless_table` | `0` | Set to `1` to add borders when formatting borderless tables. |
| `g:vim_markdown_edit_url_in` | `'current'` | Use `'current'`, `'tab'`, `'vsplit'` or `'hsplit'` for `ge`. |
| `g:vim_markdown_autowrite` | `0` | Set to `1` to write the current buffer before `ge` follows a link. |
| `g:vim_markdown_no_extensions_in_markdown` | `0` | Set to `1` to append an extension when `ge` opens a linked file. |
| `g:vim_markdown_auto_extension_ext` | `'md'` | Extension to append, without a dot, when the preceding option is enabled. |
| `g:vim_markdown_follow_anchor` | `1` | Set to `0` to disable anchor handling in `ge`. |
| `g:vim_markdown_anchorexpr` | unset | Expression using `v:anchor` to produce a Vim search pattern, overriding the built-in heading match. For example, `'v:anchor'` restores plain pattern searching. |

See `:help simple-markdown` for details. Run `make test` for the Vader suite.
