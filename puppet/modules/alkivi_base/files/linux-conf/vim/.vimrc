set showcmd
set ruler
set backspace=2
set nocompatible
set autoindent
"set cindent
set history=50
set vb t_vb=
set noerrorbells
set hlsearch
set number
set term=xterm
set tabstop=4       " numbers of spaces of tab character
set shiftwidth=4    " numbers of spaces to (auto)indent
set softtabstop=4
set expandtab
"set mouse=a

syntax on           " syntax highlighing
if &t_Co > 1
syntax enable
endif

filetype plugin indent on
filetype on

colorscheme elflord
"colorscheme peachpuff
"colorscheme anotherdark
"colorscheme slate

" Press F4 to toggle highlighting on/off, and show current value.
noremap <F4> :set hlsearch! hlsearch?<CR>
noremap <F5> :set number! number?<CR>

au VimResized,TermResponse,GUIEnter,FocusGained,VimEnter,WinEnter,BufFilePost,BufReadPost,BufNewFile * silent !screen -X title `basename "%"  2> /dev/null || echo 'VIM'` > /dev/null

au BufWritePost {*.pm,*.pl,*.inc,*.cgi} !perl -c %
au BufWritePost {*.xsl} !xsltproc % > /dev/null
au BufWritePost {*.py} !python -c "import py_compile; py_compile.compile('%', '/dev/null')" 
au BufWritePost {*.pp} !puppet parser validate  %

"For align
set nocp

"set foldmethod=indent

