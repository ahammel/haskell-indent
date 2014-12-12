Haskell Indentation
==========================

I'm fond of the indentation mode from raichoo's [Haskell-Vim][haskell-vim], but
I wanted to use a different syntax highlighter.

## Installation

I recommend using [Pathogen][] for installation. Simply clone
this repo into your `~/.vim/bundle` directory and you are ready to go.

    cd ~/.vim/bundle
    git clone https://github.com/raichoo/haskell-vim.git

### Manual Installation

Copy content into your `~/.vim` directory.

Be sure that the following lines are in your
`.vimrc`


    syntax on
    filetype on
    filetype plugin indent on

## Configuration

To configure indentation in `haskell-vim` you can use the following variables to change indentation depth, just add the according line to your `.vimrc`.

* `let g:haskell_indent_if = 3`

        if bool
        >>>then ...
        >>>else ...

* `let g:haskell_indent_case = 5`

        case xs of
        >>>>>[]     -> ...
        >>>>>(y:ys) -> ...

* `let g:haskell_indent_let = 4`

        let x = 0 in
        >>>>x

* `let g:haskell_indent_where = 6`

        where f :: Int -> Int
        >>>>>>f x = x

* `let g:haskell_indent_do = 3`

        do x <- a
        >>>y <- b

* `let g:haskell_indent_in = 1`

        let x = 1
        >in x


[Pathogen]: https://github.com/tpope/vim-pathogen
[idris-vim]: https://github.com/idris-hackers/idris-vim
[haskell-vim]: https://github.com/raichoo/haskell-vim
