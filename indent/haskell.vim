" indentation for haskell
"
" Based on idris indentation
"
" author: raichoo (raichoo@googlemail.com)
" date: Jun 17 2014
"
" Modify g:haskell_indent_if and g:haskell_indent_case to
" change indentation for `if'(default 3) and `case'(default 5).
" Example (in .vimrc):
" > let g:haskell_indent_if = 2

if exists('b:did_indent')
  finish
endif

let b:did_indent = 1

if !exists('g:haskell_indent_if')
  " if bool
  " >>>then ...
  " >>>else ...
  let g:haskell_indent_if = 3
endif

if !exists('g:haskell_indent_case')
  " case xs of
  " >>>>>[]      => ...
  " >>>>>(y::ys) => ...
  let g:haskell_indent_case = 5
endif

if !exists('g:haskell_indent_let')
  " let x : Nat = O in
  " >>>>x
  let g:haskell_indent_let = 4
endif

if !exists('g:haskell_indent_where')
  " where f : Nat -> Nat
  " >>>>>>f x = x
  let g:haskell_indent_where = 6
endif

if !exists('g:haskell_indent_do')
  " do x <- a
  " >>>y <- b
  let g:haskell_indent_do = 3
endif

setlocal indentexpr=GethaskellIndent()
setlocal indentkeys=!^F,o,O,}

function! GethaskellIndent()
  let prevline = getline(v:lnum - 1)

  if prevline =~ '\s\+(\s*.\+\s\+:\s\+.\+\s*)\s\+->\s*$'
    return match(prevline, '(')
  elseif prevline =~ '\s\+{\s*.\+\s\+:\s\+.\+\s*}\s\+->\s*$'
    return match(prevline, '{')
  endif

  if prevline =~ '[!#$%&*+./<>?@\\^|~-]\s*$'
    let s = match(prevline, '=')
    if s > 0
      return s + 2
    endif

    let s = match(prevline, ':')
    if s > 0
      return s + 3
    else
      return match(prevline, '\S')
    endif
  endif

  if prevline =~ '[{([][^})\]]\+$'
    return match(prevline, '[{([]')
  endif

  if prevline =~ '\<let\>\s\+.\+\<in\>\s*$'
    return match(prevline, 'let') + g:haskell_indent_let
  endif

  if prevline !~ '\<else\>'
    let s = match(prevline, '\<if\>.*\&.*\zs\<then\>')
    if s > 0
      return s
    endif

    let s = match(prevline, '\<if\>')
    if s > 0
      return s + g:haskell_indent_if
    endif
  endif

  if prevline =~ '\(\<where\>\|\<do\>\|=\|[{([]\)\s*$'
    return match(prevline, '\S') + &shiftwidth
  endif

  if prevline =~ '\<where\>\s\+\S\+.*$'
    return match(prevline, '\<where\>') + g:haskell_indent_where
  endif

  if prevline =~ '\<do\>\s\+\S\+.*$'
    return match(prevline, '\<do\>') + g:haskell_indent_do
  endif

  if prevline =~ '^\s*\<data\>\s\+[^=]\+\s\+=\s\+\S\+.*$'
    return match(prevline, '=')
  endif

  if prevline =~ '\<case\>\s\+.\+\<of\>\s*$'
    return match(prevline, 'case') + g:haskell_indent_case
  endif

  if prevline =~ '^\s*\<\data\>\s\+\S\+\s*$'
    return match(prevline, '\<data\>') + &shiftwidth
  endif

  let line = getline(v:lnum)

  if (line =~ '^\s*}\s*' && prevline !~ '^\s*;')
    return match(prevline, '\S') - &shiftwidth
  endif

  return match(prevline, '\S')
endfunction