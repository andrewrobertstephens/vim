if has('win32')
  set clipboard=unnamed
  set guifont=Lucida_Console:h12
  set go+=a
  let $VIMHOME = "$HOME/vimfiles"
else
  let $VIMHOME = "$HOME/.vim"
endif

" ===============================================
" backup files
" ===============================================

set nobackup
set writebackup

" ===============================================
" colors
" ===============================================

colorscheme molokai
set background=dark
set colorcolumn=79
set termguicolors

" ===============================================
" completion
" ===============================================

set completeopt=longest,menuone
set iskeyword+=-
set omnifunc=syntaxcomplete#Complete

" ===============================================
" display
" ===============================================

set linebreak
set number
set t_vb=
set nowrap

" ===============================================
" editing
" ===============================================

filetype plugin indent on
syntax on
set autoindent
set backspace=indent,eol,start
set expandtab
set scrolloff=0
set shiftwidth=2
set smartindent
set smarttab
set softtabstop=2
set tabstop=2

" ===============================================
" file stuff
" ===============================================

set autoread
set autowrite
set encoding=UTF-8
"set hidden
set ffs=unix,dos

" ===============================================
" gui stuff
" ===============================================

augroup gui_augroup
  autocmd GUIEnter * set visualbell t_vb=
augroup END

if has('gui_running')
  set columns=80
  set lines=24
endif

" ===============================================
" lua stuff
" ===============================================


function LuaSettings()
  set makeprg=love\ .
  set dictionary-=$VIMHOME/love-dictionary/love.dict 
  set dictionary+=$VIMHOME/love-dictionary/love.dict
  set iskeyword+=.
endfunction

augroup lua_augroup
  autocmd!
  autocmd FileType lua call LuaSettings()
augroup END

let g:lovedocs_color = 'guifg=#ff60e2 ctermfg=206'
let g:lovedocs_colors = 'guifg=#ff60e2 ctermfg=206'

" ===============================================
" mapping
" ===============================================

" misc mappings
nnoremap <BS> :noh<CR>
nnoremap <Tab> <C-W><C-W>
"nnoremap <Tab> :buffer<Space><Tab>
nnoremap Q <Nop>
nnoremap dd "_dd

" ctrl maps (normal)
nnoremap <C-A> :call Indent()<CR>
"nnoremap <C-B> :buffer<Space><Tab>
nnoremap <C-B> :ls<cr>:b<space>
nnoremap <C-C> :close<CR>
nnoremap <C-D> :bd<CR>
nnoremap <C-E> :e $MYVIMRC<CR>
nnoremap <C-F> :bro ol<CR>
nnoremap <C-G> :vimgrep // *<Left><Left><Left>
nnoremap <C-H> :e $HTDOCS<CR>
"<C-I> - Tab
"<C-J> -
"<C-K> -
"nnoremap <C-L> :b#<CR>
"<C-M> - Enter
nnoremap <C-N> :bn<CR>
"<C-O> - Back (help)
nnoremap <C-P> :bp<CR>
"<C-Q> - <C-V>
"<C-R> - Redo
nnoremap <C-S> :%s///g<Left><Left><Left>
"<C-T> - Tags
nnoremap <C-U> :source $MYVIMRC<CR>
"<C-V> - Visual block
"<C-W> - Window navigation
"<C-X> - Omnicompletion leader 
"<C-Y> - Scroll up one line
"<C-Z> - Minimize window (?)
nnoremap <C-Z> <Nop>
nnoremap <C-Up> <C-W>+
nnoremap <C-Down> <C-W>-
nnoremap <C-Left> <C-W><
nnoremap <C-Right> <C-W>>

" ctrl maps (insert)
inoremap <C-K> <C-X><C-K>
inoremap <C-F> <C-X><C-F>
inoremap <C-L> <C-X><C-L>
inoremap <C-O> <C-X><C-O>

" function keys
nnoremap <F2> :e .<CR>
nnoremap <F5> :make<CR>
nnoremap <F7> :setlocal spell!<CR>
nnoremap <F8> :call FillLine('=')<CR>$
nnoremap <F11> :source $MYVIMRC<CR>
nnoremap <F12> :e $MYVIMRC<CR>

" ===============================================
" markdown
" ===============================================

augroup markdown_augroup
  autocmd!
  autocmd FileType markdown setlocal spell!
augroup END

" ===============================================
" matchit plugin
" ===============================================

runtime! macros/matchit.vim

" ===============================================
" misc options
" ===============================================

augroup misc_augroup
  autocmd!
  autocmd BufEnter * silent! lcd %:p:h
augroup END

set mouse=a
set noerrorbells
set shellslash
set splitbelow
set splitright
"set wildcharm=<Tab>
set wildmenu
"set wildmode=full
set t_vb=
set viminfo='25
set visualbell

" ===============================================
" php
" ===============================================

function PhpSettings()
  " php doesn't indent well in vim
  set filetype=html
  set syntax=php
endfunction

augroup php_augroup
  autocmd!
  autocmd FileType php call PhpSettings()
augroup END

" ===============================================
" python
" ===============================================

augroup python_augroup
  autocmd!
  autocmd FileType python set makeprg=!python\ %
augroup END

" ===============================================
" persistent undo
" ===============================================

set undodir=$HOME/.VIM_UNDO_FILES
set undolevels=5000
set undofile

" ===============================================
" quickfix
" ===============================================

augroup quickfix_augroup
  autocmd!
  autocmd QuickFixCmdPost [^l]* cwindow
  autocmd QuickFixCmdPost l*    lwindow
augroup END

" ===============================================
" search
" ===============================================

set hlsearch
set ignorecase
set incsearch
set smartcase

" ===============================================
" statusline
" ===============================================

" default colors
hi ModeNormalColor gui=bold guifg=black guibg=#0000ff
hi ModeInsertColor gui=bold guifg=black guibg=#00ff00
hi ModeReplaceColor gui=bold guifg=white guibg=#ff0000
hi ModeVisualColor gui=bold guifg=black guibg=#ffff00

" colors for molokai colorscheme
if g:colors_name == 'molokai'
  hi ModeNormalColor gui=bold guifg=black guibg=#66d9ef
  hi ModeInsertColor gui=bold guifg=black guibg=#a6e22e
  hi ModeReplaceColor gui=bold guifg=white guibg=#f92672
  hi ModeVisualColor gui=bold guifg=black guibg=#cc8000
endif

" show mode and change color
function! StatusLineMode()
  let m = mode()
  if m == 'n'
    hi link CustomColor ModeNormalColor
    return '  NORMAL '
  elseif m == 'i'
    hi link CustomColor ModeInsertColor
    return '  INSERT '
  elseif m == 'R'
    hi link CustomColor ModeReplaceColor
    return '  REPLACE '
  elseif m == 'v' || m == ''
    hi link CustomColor ModeVisualColor
    return '  VISUAL '
  end
  return ''
endfunction

" misc info
function StatusLineInfo()
  let output = ''
  if &spell
    let output .= &spelllang . ' | '
  endif
  let output .= &ff . ' | '
  let output .= &encoding . ' | '
  if &ft != ''
    let output .= &ft . ' | '
  end
  return output
endfunction

" show all the time
set laststatus=2

" build the statusline
set statusline=
set statusline+=%#CustomColor#
set statusline+=%{StatusLineMode()}
set statusline+=%#StatusLine#
set statusline+=\ %f
set statusline+=%m%r
set statusline+=%=
set statusline+=%{StatusLineInfo()}
set statusline+=%p%%
set statusline+=\ %#CustomColor#
set statusline+=\ %l:%c\ 

" ===============================================
" text (filetype)
" ===============================================

augroup text_augroup
  autocmd!
  autocmd FileType text setlocal spell!
augroup END

" ===============================================
" vimrc
" ===============================================

augroup vimrc_augroup
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

