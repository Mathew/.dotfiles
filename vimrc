" Set vim to use Bash as it's shell.
if &shell =~# 'fish$'
    set shell=sh
endif

set nocompatible              
syntax enable
colorscheme molokai

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Ack searching
Plugin 'mileszs/ack.vim'

" Fish Syntax Highlighter
Plugin 'dag/vim-fish'

" Coloured matching brackets
Plugin 'kien/rainbow_parentheses.vim'

" Flake8 Linting
Plugin 'nvie/vim-flake8'

" Git modifications.
Plugin 'airblade/vim-gitgutter'

" Moar Python Syntax Highlighting.
Plugin 'hdima/python-syntax'

" File/Buffer/other browser
Plugin 'Shougo/unite.vim'

" Vim/Tmux integration
Plugin 'tmux-plugins/vim-tmux'
Plugin 'christoomey/vim-tmux-navigator'

" Theme
Plugin 'tomasr/molokai'

" Clojure Plugins
Plugin 'vim-scripts/paredit.vim'
Plugin 'tpope/vim-fireplace'
Plugin 'tpope/vim-leiningen'
Plugin 'guns/vim-clojure-static'
Plugin 'guns/vim-clojure-highlight'

" Python
Plugin 'davidhalter/jedi-vim'
" Python cold folding
Plugin 'tmhedberg/SimpylFold'

" Supertab support
Plugin 'ervandew/supertab'

" Tagbar
Plugin 'majutsushi/tagbar'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"
"" Whitespace
set nowrap                      " don't wrap lines
set tabstop=4 shiftwidth=4 softtabstop=4
set expandtab                   " use spaces, not tabs (remove this if you mostly use tabs)
set backspace=indent,eol,start  " backspace through everything in insert mode

set relativenumber

let mapleader = ","

"" Window Management.
" Thou shalt match tmux.
set splitbelow
set splitright
" | to split vertically.
nnoremap <Leader>\| <C-w>v
" - to split horizontally.
nnoremap <Leader>- <C-w>s

"" Unite
nnoremap <Leader>p :Unite -start-insert file_rec<CR>
nnoremap <Leader>l :Unite buffer<CR>
nnoremap <Leader>b :Unite file<CR>

"" Jedi
let g:jedi#popup_select_first=1

"" Go away bells.
set visualbell
set t_vb =
set noeb

" Highlight the current line
set cursorline

" Vertical line at column 79
set colorcolumn=80

" folding
" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za
set foldlevel=99

" SimplyIFold config
let g:SimpylFold_fold_import = 0
let g:SimpylFold_fold_docstring = 0
autocmd BufWinEnter *.py setlocal foldexpr=SimpylFold(v:lnum) foldmethod=expr
autocmd BufWinLeave *.py setlocal foldexpr< foldmethod<
autocmd BufReadPost * :if line('$') > 50 | set foldlevel=1 | endif

" More Python syntax highlighting
let python_highlight_all=1

"" Flake 8
let g:flake8_show_in_gutter=1  " show
autocmd BufWritePost *.py call Flake8()

"" Cursor shapes for insert vs command mode:
" iTerm
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
" let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

"" Supertab
let g:SuperTabLongestHighlight=1

"" tagbar
nmap <Leader>t :TagbarOpenAutoClose<CR>


"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter
set showmatch                   " and show matches
" clear searches
nnoremap <Leader><Space> :noh<cr>

"" General config
set ruler
set encoding=utf-8
set scrolloff=4
set showmode
set lazyredraw
set wildmenu
set wildmode=longest,list
set ttyfast
set number
set laststatus=2
set mouse=a
" Use OS X clipboard
highlight Normal ctermfg=grey ctermbg=black
set clipboard=unnamed

set textwidth=79

"" Rainbow Parentheses
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['magenta',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" Save your backups to a less annoying place than the current directory.
" If you have .vim-backup in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/backup or . if all else fails.
if isdirectory($HOME . '/.vim/backup') == 0
  :silent !mkdir -p ~/.vim/backup >/dev/null 2>&1
  endif
  set backupdir-=.
  set backupdir+=.
  set backupdir-=~/
  set backupdir^=~/.vim/backup/
  set backupdir^=./.vim-backup/
  set backup

" Save your swp files to a less annoying place than the current directory.
" If you have .vim-swap in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/swap, ~/tmp or .
if isdirectory($HOME . '/.vim/swap') == 0
  :silent !mkdir -p ~/.vim/swap >/dev/null 2>&1
endif
set directory=./.vim-swap//
set directory+=~/.vim/swap//
set directory+=~/tmp//
set directory+=.

" viminfo stores the the state of your previous editing session
set viminfo+=n~/.vim/viminfo

if exists("+undofile")
  " undofile - This allows you to use undos after exiting and restarting
  " This, like swap and backups, uses .vim-undo first, then ~/.vim/undo
  " :help undo-persistence
  " This is only present in 7.3+
  if isdirectory($HOME . '/.vim/undo') == 0
    :silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
  endif
  set undodir=./.vim-undo//
  set undodir+=~/.vim/undo//
  set undofile
endif

" 256 colour mode.
let g:rehash256 = 1

" Strip trailing whitespace.
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

autocmd BufWritePre *.py,*.js,*.clj,*.cljs,*.php,*.md,*.html,*.rst,*.properties :call <SID>StripTrailingWhitespaces()

autocmd Filetype javascript setlocal ts=4 sw=4 sts=0 noexpandtab
autocmd Filetype html setlocal ts=4 sw=4 sts=0 noexpandtab
autocmd Filetype htmldjango setlocal ts=4 sw=4 sts=0 noexpandtab
autocmd Filetype handlebars setlocal ts=4 sw=4 sts=0 noexpandtab
autocmd Filetype php setlocal ts=4 sw=4 sts=0 noexpandtab
autocmd Filetype markdown setlocal ts=4 sw=4 sts=0 noexpandtab
autocmd Filetype properties setlocal ts=4 sw=4 sts=0 noexpandtab
autocmd Filetype java setlocal ts=4 sw=4 sts=0 noexpandtab

inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
