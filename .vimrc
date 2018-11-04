"pubstart
"https://github.com/parenparen/
"
"Copyright 2014 Derek Mueller
"Released under the MIT license
"http://opensource.org/licenses/MIT
"pubend

call plug#begin('~/.vim/plugged')
Plug 'elmcast/elm-vim'
call plug#end()

let g:elm_format_autosave = 1

" vundle setup stuff...
set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'itchyny/vim-haskell-indent'
call vundle#end()            " required
filetype plugin indent on    " required

:set noswapfile

execute pathogen#infect()

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 3
let g:netrw_winsize = 25

"
" functions
"

:function! CopyCurrJSClassName ()
:   execute "normal! ma?^function\rf lyw'a"
:endfunction

"pubstart

:function! CopyFnToClipboard ()

"save original location
:   execute "normal! m'" 

:   let l:ln1 = line ('.')
:   let l:ln2 = search ('function')

"detect whether cursor is inside a function or on the first line of a
"function definition
:   if (l:ln1 ==# l:ln2) 
        "set mark on current line, move to end of 
        "function, end copy
:       execute "normal! maf{%\"+y'a"
:   else
        "move to beginning of function, set mark, move to end of 
        "function, end copy
:       execute "normal! `'?function\rmaf{%\"+y'a" 
:   endif
:
:endfunction

:function! CommentFn ()

"save original location
:   execute "normal! m'" 

:   let l:ln1 = line ('.')
:   let l:ln2 = search ('function')

"detect whether cursor is inside a function or on the first line of a
"function definition
:   if (l:ln1 ==# l:ln2) 
       "start comment on current line and move to end of function
:       execute "normal! I/*\ef{%A*/\e"
:   else
        "move to beginning of function, start comment, move to end of 
        "function, end comment 
:       execute "normal! `'?function\rI/*\ef{%A*/\e" 
:   endif
:
:endfunction

"like CommentFn except comment start and end are removed
:function! UncommentFn ()
:   execute "normal! m'" 
:   let l:ln1 = line ('.')
:   let l:ln2 = search ('function')
:   if (l:ln1 ==# l:ln2) 
:       execute "normal! 0xxf{%$xx"
:   else
:       execute "normal! `'?function\r0xxf{%$xx" 
:   endif
:
:endfunction

" comment out lines between marks set by motion command
:function! CommentAll (...)
:   let l:ft = &filetype
:   if l:ft ==# 'vim'
:       '[,'] s/^/"/
:   elseif l:ft ==# 'haskell'
:       '[,'] s/^/--/
:   elseif l:ft ==# 'purescript'
:       '[,'] s/^/--/
:   elseif l:ft ==# 'matlab'
:       '[,'] s/^/%/
:   elseif l:ft =~# 'python\|perl\|sh\|bash\|ruby'
:       '[,'] s/^/#/
:   elseif l:ft =~# 'html\|xml'
"       save original marks
:       execute "normal! '[ma" 
:       execute "normal! ']mb"
:       'a s/^/<!--/
:       'b s/$/-->/
:   else
:       '[,'] s/^/\/\/
:   endif
:endfunction

:function! UncommentAll (...)
:   let l:ft = &filetype
:   if l:ft ==# 'vim'
:       '[,'] s/"//
:   elseif l:ft =~# 'python\|perl\|ruby'
:       '[,'] s/#//
:   elseif l:ft ==# 'purescript'
:       '[,'] s/--//
:   elseif l:ft ==# 'haskell'
:       '[,'] s/--//
:   elseif l:ft =~# 'html\|xml'
"       save original marks
:       execute "normal! '[ma" 
:       execute "normal! ']mb"
:       'a s/^<!--//
:       'b s/-->$//
:   else
:       '[,'] s/^\/\//
:   endif
:endfunction

"pubend


:let mapleader = ","
:let maplocalleader = ","

"
" macros 
"

let @r=':% s/^\(\s\+\)console\./\1DEBUG \&\& console\./g'
let @f='/^\(\s*\)\?console\.'


"
" coursera math symbol mappings 
"
":inoremap #m <c-k>m*
":nnoremap #m i<c-k>m*<esc>
":inoremap #t <c-k>h*
":nnoremap #t i<c-k>h*<esc>
":inoremap #T <c-k>H*
":nnoremap #T i<c-k>H*<esc>
":inoremap #d <c-k>d*
":inoremap #D <c-k>D*
":nnoremap #d i<c-k>d*<esc>
":nnoremap #D i<c-k>D*<esc>
":inoremap #e <c-k>e*
":nnoremap #e i<c-k>e*<esc>
":inoremap #s <c-k>S*
":nnoremap #s i<c-k>S*<esc>
":inoremap #a <c-k>a*
":nnoremap #a i<c-k>a*<esc>



"
"operator mappings 
"

:onoremap in( :<c-u>normal! f(vi(<cr>
:onoremap il( :<c-u>normal! F(vi(<cr>
:onoremap an( :<c-u>normal! f(va(<cr>
:onoremap al( :<c-u>normal! F(va(<cr>
:onoremap in[ :<c-u>normal! f[vi[<cr>
:onoremap il[ :<c-u>normal! F[vi[<cr>
:onoremap in{ :<c-u>normal! f{vi{<cr>
:onoremap il{ :<c-u>normal! F{vi{<cr>
:onoremap in` :<c-u>normal! f`vi`<cr>
:onoremap il` :<c-u>normal! F`vi`<cr>
:onoremap in' :<c-u>normal! f'vi'<cr>
:onoremap il' :<c-u>normal! F'vi'<cr>
:onoremap in" :<c-u>normal! f"vi"<cr>
:onoremap il" :<c-u>normal! F"vi"<cr>

"in next email 
:onoremap in@ :<c-u>execute "normal! /\\w\\+@\\w\\+\.com\r:nohlsearch\rv/com\rll"<cr>


"
" refactoring 
"

"move end of line comment to previous line
:nnoremap <leader>rc $F/hd$kp



"
"Insert mode mappings 
"

"init c-style comment
:inoremap @<leader>/ /*<cr><cr>*/<esc>ki
:inoremap @<leader>w while (
:inoremap @<leader>f for (

"pubstart
:nnoremap <leader>oc :set opfunc=CommentAll<CR>g@
:nnoremap <leader>ouc :set opfunc=UncommentAll<CR>g@
"pubend

"save file
:nnoremap ww :w<cr>
"quit
:nnoremap QQ :q<cr>

"switch to normal mode
:inoremap jk <esc>
:inoremap kj <esc>



"
"Normal mode mappings 
"

"pubstart

"toggle true/false
:nnoremap <leader>t :execute "normal! viwy" <cr> :if getreg("\"") ==# 'true' <cr> execute "normal! viwcfalse\e" <cr> elseif getreg("\"") ==# 'false' <cr> execute "normal! viwctrue\e" <cr> endif <cr> :execute "normal! viwb\e" <cr>

"pubend

"copy all
:nnoremap <leader>Ca mbggmaG"+y'a'b

:nnoremap <leader>gfn :.!echo %<cr>

:nnoremap <leader>gct :.!date<cr>

:nnoremap <leader>@n i/* parenparen mod start */<esc>
:nnoremap <leader>@m i/* parenparen mod end */<esc>

"insert parenparen MIT license header
:nnoremap <leader>m i/*<cr>https://github.com/parenparen/<cr><cr>Copyright 2014 Derek Mueller<cr>Released under the MIT license<cr>http://opensource.org/licenses/MIT<cr>*/<cr><esc>

" edit vimrc
:nnoremap <leader>ev :split $MYVIMRC<cr>

" apply vimrc settings
:nnoremap <leader>sv :source $MYVIMRC<cr>

"go to 72nd character in line
:nnoremap <leader>7 <Home>72l
:nnoremap <leader>1 <Home>100l

"quote word
:nnoremap <leader>" hea"<esc>hbi"<esc>lel 
:nnoremap <leader>' hea'<esc>hbi'<esc>lel 

:nnoremap <leader>} I} <esc>A {<esc>
:nnoremap <leader>{ A {<esc>

"init c-style comment box
:nnoremap <leader>/b i/***********************************************************************<cr>*<cr>***********************************************************************/<esc>kA<space><esc>

"init c-style comment
":inoremap #<leader>/c /*<cr><cr>*/
:nnoremap <leader>/c i/*<cr><cr>*/<esc>k
:nnoremap <leader>/C i/* */<esc>hh

"comment line
:nnoremap <leader>/l I//<esc>
:nnoremap <leader>/L I/*<esc>A*/<esc>

"uncomment line
:nnoremap <leader>/dl ^xx
:nnoremap <leader>/dL ^xx$xx

"comment paragraph
:nnoremap <leader>/p {I/*<esc>}A*/<esc>

"uncomment paragraph
:nnoremap <leader>/dp {^}$xx

:nnoremap <leader>/*P iPreconditions:<cr><c-i>-<space><esc>
:nnoremap <leader>/*p iParameters:<cr><c-i> <esc>
:nnoremap <leader>/*r iReturns:<cr><c-i><esc>

"go to 72nd character in line
:nnoremap <leader>7 072l

"open newline
:nnoremap <cr> O<esc>j

"line motion
:nnoremap H ^
:nnoremap L $

"scrolling
:nnoremap <space> 3<C-E>
:nnoremap ; 3<C-Y>

"force filetype switch
:nnoremap <leader>fh :set ft=html<cr>
:nnoremap <leader>fH :set ft=haskell<cr>
:nnoremap <leader>fp :set ft=php<cr>
:nnoremap <leader>fj :set ft=javascript<cr>
:nnoremap <leader>fr :set ft=ruby<cr>
:nnoremap <leader>fJ :set ft=json<cr>
:nnoremap <leader>fg :set ft=gitcommit<cr>
:nnoremap <leader>ff :set ft=flashcards<cr>
:nnoremap <leader>fs :set ft=sh<cr>

:nnoremap <C-j> O<esc>j
:inoremap <C-j> <cr>
:cnoremap <C-j> <cr>

"refactoring
:nnoremap <leader>ba 0f(li<cr><c-i><esc>



"
" File type specific mappings
"

:augroup filetypeMatLab
:   autocmd!
:   autocmd FileType matlab :nnoremap <leader>/l I%<esc>
:   autocmd FileType matlab :nnoremap <buffer> <localleader>sv :source $MYVIMRC<cr>:set ft=matlab<cr>
:augroup END

"
"CSS 
"

:augroup filetypeCSS
:   autocmd!

"comment out current line
:   autocmd FileType css :nnoremap <buffer> <localleader>bl 0f{li<cr><c-i><esc>f}i<cr><esc>
:   autocmd FileType css setlocal lisp ai 
:   autocmd FileType css :nnoremap <buffer> <localleader>sv :source $MYVIMRC<cr>:set ft=css<cr>
:augroup END

"
"SCSS 
"

:augroup filetypeSCSS
:   autocmd!

"comment out current line
:   autocmd FileType scss :nnoremap <buffer> <localleader>sv :source $MYVIMRC<cr>:set ft=scss<cr>
:   autocmd FileType scss setlocal shiftwidth=2 tabstop=2
:augroup END

"
"pullup
"

autocmd BufNewFile,BufRead /home/derekm/programming/webProgramming/pullup/pullup/* set tabstop=2 shiftwidth=2

"
"flashcards
"
:augroup filetypeFlashcards
:   autocmd!

:   autocmd FileType flashcards :nnoremap <buffer> <localleader>q A<cr>q<cr><esc>
:   autocmd FileType flashcards :nnoremap <buffer> <localleader>a A<cr>a<cr><esc>
:   autocmd FileType flashcards :nnoremap <buffer> <localleader>sv :source $MYVIMRC<cr>:set ft=flashcards<cr>
:augroup END

"
"gitcommit
"
:augroup filetypeGITCOMMIT
:   autocmd!

:   autocmd FileType gitcommit :set textwidth=72
:   autocmd FileType gitcommit :nnoremap <buffer> <localleader>sv :source $MYVIMRC<cr>:set ft=gitcommit<cr>
:augroup END

"
"JSON
"
:augroup filetypeJSON
:   autocmd!

:   autocmd FileType json :nnoremap <buffer> <localleader>j :%!python -mjson.tool<cr>
:   autocmd FileType json :nnoremap <buffer> <localleader>sv :source $MYVIMRC<cr>:set ft=json<cr>
:augroup END

"
"Ruby
"
:augroup filetypeRuby
:   autocmd!

:   autocmd FileType ruby setlocal shiftwidth=2 tabstop=2
:   autocmd FileType ruby :nnoremap <buffer> <localleader>sv :source $MYVIMRC<cr>:set ft=ruby<cr>
:augroup END

"
"JS 
"
"pubstart
:augroup filetypeJS
:   autocmd!
:   autocmd FileType javascript :nnoremap <buffer> <localleader>fcf :call CommentFn ()<cr>
:   autocmd FileType javascript :nnoremap <buffer> <localleader>fCf :call CopyFnToClipboard ()<cr>
:   autocmd FileType javascript :nnoremap <buffer> <localleader>fuf :call UncommentFn ()<cr>
"pubend

:   autocmd FileType javascript :nnoremap <buffer> <localleader>cfp :call CopyCurrJSClassName ()<cr>Pr.lviwdAprototype.<esc>pA = function () {<cr><cr>};<esc>kkI<esc>
:   autocmd FileType javascript :nnoremap <buffer> <localleader>bp 072lF,li<cr><esc>
:   autocmd FileType javascript :inoremap <buffer> #<localleader>st var that = this;<esc>

:   autocmd FileType javascript :nnoremap <buffer> <localleader>bcu ^f/d$kph
:   autocmd FileType javascript :nnoremap <buffer> <localleader>bcl ^lr*A */<esc>l

:   autocmd FileType javascript :nnoremap <buffer> <localleader>/J i/**<cr> *<cr>*/<esc>k

"print yanked text
:   autocmd FileType javascript :nnoremap <buffer> <localleader>py iconsole.log('<esc>pA= ');<cr>console.log(<esc>pA);<esc>

"print yanked text, wrap in double quotes
:   autocmd FileType javascript :nnoremap <buffer> <localleader>pY iconsole.log("<esc>pA= ");<cr>console.log(<esc>pA);<esc>

"print word
:   autocmd FileType javascript :nnoremap <buffer> <localleader>pw bdwi<space>console.log('<esc>pA= ');<cr>console.log(<esc>pA);<esc>

"print letter
:   autocmd FileType javascript :nnoremap <buffer> <localleader>pl dwi<space>console.log('<esc>pA= ');<cr>console.log(<esc>pA);<esc>

"init node command line script
:   autocmd FileType javascript :nnoremap <buffer> <localleader>i i#!/usr/bin/node<cr><cr>var fs = require('fs');<cr>var fileName = process.argv[2];<cr><cr>fs.readFile (process.argv[2], 'utf8', function (err, data) {<cr><cr>});<esc>ki<space><space><space><space>

"insert function (
:   autocmd FileType javascript :nnoremap <buffer> @<localleader>f ifunction(<esc>

"insert console.log(
:   autocmd FileType javascript :inoremap <buffer> @a auxlib.log(
:   autocmd FileType javascript :inoremap <buffer> @c console.log(
:   autocmd FileType javascript :nnoremap <buffer> <localleader>@c iconsole.log(<esc>

"add default function variable
:   autocmd FileType javascript :nnoremap <buffer> <localleader>cd viwdi <esc>pli = typeof <esc>pli === 'undefined' ?  : <esc>pli;<esc>F:h

"create prototype skeleton  
:   autocmd FileType javascript :nnoremap <buffer> <localleader>cC viwdivar <esc>pA = (function () {<cr><cr>function <esc>pA () {<cr><c-i><cr><c-d>};<cr><cr>}) ();<cr><esc>
:   autocmd FileType javascript :nnoremap <buffer> <localleader>cCa ivar auxlib = require ('./auxlib');<cr>var = (function () {<cr><cr>function (argsDict) {<cr><c-i>var argsDict = typeof argsDict === 'undefined' ? {} : argsDict;<cr>var defaultPropsDict = {<cr>};<cr>auxlib.unpack.apply (this, [argsDict, defaultPropsDict]);<cr><c-d>};<cr><cr>}) ();<cr><esc>
    

"create prototype child signature
:   autocmd FileType javascript :nnoremap <buffer> <localleader>spS i = function (argsDict) {<cr><c-i><cr>argsDict = typeof argsDict === 'undefined' ? {} : argsDict;<cr>.call (this, argsDict);<cr>var defaultPropsDict = {<cr><cr>};<cr><cr>proto.unpack.apply (this, [argsDict, defaultPropsDict]);<cr><c-d>};<cr><cr>.prototype = Object.create (.prototype);<cr>

"create prototype child signature
:   autocmd FileType javascript :nnoremap <buffer> <localleader>sps i = function (argsDict) {<cr><c-i>argsDict = typeof argsDict === 'undefined' ? {} : argsDict;<cr><cr>var defaultPropsDict = {<cr><cr>};<cr><cr>proto.unpack.apply (this, [argsDict, defaultPropsDict]);<cr><c-d>};<esc>

"create prototype skeleton
:   autocmd FileType javascript :nnoremap <buffer> <localleader>spc i/*<cr>Public static methods<cr>*/<cr><cr>/*<cr>Private static methods<cr>*/<cr><cr>/*<cr>Public instance methods<cr>*/<cr><cr>/*<cr>Private instance methods<cr>*/<cr><esc>

:   autocmd FileType javascript :nnoremap <buffer> <localleader>st ivar that = this;<esc>
:   autocmd FileType javascript :inoremap <buffer> @<localleader>st var that = this;

:   autocmd FileType javascript :nmap <buffer> <localleader>cct ,gfnf.D,cCl

"comment out current line
:   autocmd FileType javascript :nnoremap <buffer> <localleader>c I//<esc>
:   autocmd FileType javascript :nnoremap <buffer> <localleader>sv :source $MYVIMRC<cr>:set ft=javascript<cr>
:   autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
:augroup END



"
"PHP 
"

:augroup filetypePHP
:   autocmd!
:   autocmd FileType php :inoremap @c console.log(
:   autocmd FileType php :nnoremap <buffer> <localleader>bf ^f(li<cr><space><space><space><space><esc>
:   autocmd FileType php :nnoremap <buffer> <localleader>bp 072lF,li<cr><esc>
:   autocmd FileType php :nnoremap <buffer> <localleader>ba 0f(li<cr><c-i><esc>
:   autocmd FileType php :nnoremap <buffer> <localleader>bc $hi<cr><c-d><esc>
:   autocmd FileType php :nnoremap <buffer> <localleader>sv :source $MYVIMRC<cr>:set ft=php<cr>
:   autocmd FileType php setlocal shiftwidth=2 tabstop=2 ai 
"pubstart
:augroup END
"pubend

"
" Haskell
"

:augroup filetypeHS
:   autocmd!
:   autocmd FileType haskell :nnoremap <buffer> <localleader>/l I--<esc>
:   autocmd FileType haskell :nnoremap <buffer> <localleader>sv :source $MYVIMRC<cr>:set ft=haskell<cr>
"pubstart
:augroup END
"pubend

"
" Purescript
"

:augroup filetypePURS
:   autocmd!
:   autocmd FileType purescript :nnoremap <buffer> <localleader>/l I--<esc>
:   autocmd FileType purescript :nnoremap <buffer> <localleader>sv :source $MYVIMRC<cr>:set ft=purescript<cr>
"pubstart
:augroup END
"pubend


"
"Python 
"

:augroup filetypePython
:   autocmd!

"comment out current line
:   autocmd FileType python :nnoremap <buffer> <localleader>c I#<esc>
:   autocmd FileType python setlocal 
:augroup END



"
"HTML 
"

:augroup filetypeHTML
:   autocmd!

:   autocmd FileType html :inoremap @c console.log (
:   autocmd FileType html :nnoremap <buffer> <localleader>Prp ?'\([^']*\(css\\|js\)\)'<cr>:% s//'\/\2\/\1'/g<cr>
:   autocmd FileType html :nnoremap <buffer> <localleader>/w I<!--<esc>A--><esc>
:   autocmd FileType html :nnoremap <buffer> <localleader>/dw ^4x$xxx
"html template
:   autocmd FileType html :nnoremap <buffer> <localleader>cht i<!DOCTYPE html><cr><html lang="en"><cr><head><cr><c-i><meta charset="utf-8" /><cr><c-i><title></title><cr><c-d></head><cr><body><cr></body><cr></html>

"comment out current line
:   autocmd FileType html :nnoremap <buffer> <localleader>C I<!--<esc>A--><esc>

"start comment
:   autocmd FileType html :nnoremap <buffer> <localleader>c I<!--<esc>

"end comment
:   autocmd FileType html :nnoremap <buffer> <localleader>e A--><esc>

"emdash
:   autocmd FileType html :iabbrev <buffer> --- &mdash;
:   autocmd FileType html :nnoremap <buffer> <localleader>sv :source $MYVIMRC<cr>:set ft=html<cr>
:   autocmd FileType html setlocal shiftwidth=2 tabstop=2 lisp
:augroup END

"
"sh
"

"
"Make 
"

:augroup filetypeMake
:   autocmd!
:   autocmd FileType make setlocal noexpandtab
:augroup END


:set iskeyword+=\$
:set number
:set ai
:set mouse=a
:set expandtab
:set ts=2
:set sw=2
:set vb
:set t_vb=
:set hlsearch
:set foldmethod=indent
:colorscheme default


" cucumber tables script

inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction




" modify selected text using combining diacritics
command! -range -nargs=0 Overline        call s:CombineSelection(<line1>, <line2>, '0305')
command! -range -nargs=0 Underline       call s:CombineSelection(<line1>, <line2>, '0332')
command! -range -nargs=0 DoubleUnderline call s:CombineSelection(<line1>, <line2>, '0333')
command! -range -nargs=0 Strikethrough   call s:CombineSelection(<line1>, <line2>, '0336')

command! -range -nargs=0 Unstrikethrough   call s:UncombineSelection(<line1>, <line2>, '0336')

function! s:CombineSelection(line1, line2, cp)
  execute 'let char = "\u'.a:cp.'"'
  execute a:line1.','.a:line2.'s/\%V[^[:cntrl:]]/&'.char.'/ge'
endfunction

vnoremap OO :Strikethrough<CR>

