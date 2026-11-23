" SPDX-FileCopyrightText: © 2022 Caleb Maclennan <caleb@alerque.com>
" SPDX-FileCopyrightText: © 2009 Benjamin D. Williams <benw@plasticboy.com>
" SPDX-License-Identifier: MIT

" Region definitions from Vim 9.1's Markdown syntax, maintained by Tim Pope.
if !has('conceal') || !get(g:, 'markdown_syntax_conceal', 1)
    finish
endif

syn clear markdownLinkText markdownLink markdownCode markdownCodeBlock
syn region markdownCodeBlock start="^\n\( \{4,}\|\t\)" end="^\ze \{,3}\S.*$" keepend
syn region markdownLinkText matchgroup=markdownLinkTextDelimiter start="!\=\[\%(\_[^][]*\%(\[\_[^][]*\]\_[^][]*\)*]\%( \=[[(]\)\)\@=" end="\]\%( \=[[(]\)\@=" nextgroup=markdownLink,markdownId skipwhite contains=@markdownInline,markdownLineStart concealends
syn region markdownLink matchgroup=markdownLinkDelimiter start="(" end=")" contains=markdownUrl keepend contained conceal
syn region markdownCode matchgroup=markdownCodeDelimiter start="`" end="`" keepend contains=markdownLineStart concealends
syn region markdownCode matchgroup=markdownCodeDelimiter start="`` \=" end=" \=``" keepend contains=markdownLineStart concealends
syn region markdownCodeBlock matchgroup=markdownCodeDelimiter start="^\s*\z(`\{3,\}\).*$" end="^\s*\z1\ze\s*$" keepend concealends
syn region markdownCodeBlock matchgroup=markdownCodeDelimiter start="^\s*\z(\~\{3,\}\).*$" end="^\s*\z1\ze\s*$" keepend concealends

" Language regions must follow the generic fences to keep their higher priority.
" Reuse Vim's definitions and already included language clusters.
let s:concealends = ' concealends'
let s:done_include = {}
for s:type in g:markdown_fenced_languages
    if has_key(s:done_include, matchstr(s:type,'[^.]*'))
        continue
    endif
    exe 'syn region markdownHighlight_'.substitute(matchstr(s:type,'[^=]*$'),'\..*','','').' matchgroup=markdownCodeDelimiter start="^\s*\z(`\{3,\}\)\s*\%({.\{-}\.\)\='.matchstr(s:type,'[^=]*').'}\=\S\@!.*$" end="^\s*\z1\ze\s*$" keepend contains=@markdownHighlight_'.tr(matchstr(s:type,'[^=]*$'),'.','_') . s:concealends
    exe 'syn region markdownHighlight_'.substitute(matchstr(s:type,'[^=]*$'),'\..*','','').' matchgroup=markdownCodeDelimiter start="^\s*\z(\~\{3,\}\)\s*\%({.\{-}\.\)\='.matchstr(s:type,'[^=]*').'}\=\S\@!.*$" end="^\s*\z1\ze\s*$" keepend contains=@markdownHighlight_'.tr(matchstr(s:type,'[^=]*$'),'.','_') . s:concealends
    let s:done_include[matchstr(s:type,'[^.]*')] = 1
endfor
unlet! s:type
unlet! s:done_include
unlet s:concealends
