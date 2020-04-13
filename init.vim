"                        _
"  _ __ ___  _   ___   _(_)_ __ ___  _ __ ___
" | '_ ` _ \| | | \ \ / / | '_ ` _ \| '__/ __|
" | | | | | | |_| |\ V /| | | | | | | | | (__
" |_| |_| |_|\__, | \_/ |_|_| |_| |_|_|  \___|
"            |___/

" universal setting
set nocompatible
let mapleader=" "
syntax on
filetype on
filetype indent on


set backspace=indent,eol,start
set encoding=utf-8
set nu
set relativenumber
set scrolloff=5
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set timeoutlen=1000 ttimeoutlen=0
set foldmethod=manual

" shortcut key setting
" Open the vimrc file anytime
map <LEADER>rc :tabnew ~/.config/nvim/init.vim<CR>

" command operation
map S :w<CR>
map Q :q<CR>
map R :source $MYVIMRC<CR>

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" window split
map s <nop>
map sk :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
map sj :set splitbelow<CR>:split<CR>
map sh :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
map sl :set splitright<CR>:vsplit<CR>

map <LEADER>h <c-w>h
map <LEADER>j <c-w>j
map <LEADER>k <c-w>k
map <LEADER>l <c-w>l
map <LEADER><UP>	:res +5<CR>
map <LEADER><DOWN>	:res -5<CR>
map <LEADER><LEFT>	:vertical resize-5<CR>
map <LEADER><RIGHT>	:vertical resize+5<CR>

" auto complete
" inoremap ( ()<ESC>i
" inoremap { {}<ESC>i
" inoremap [ []<ESC>i

" cursor move
noremap J 5j
noremap K 5k
" noremap g <NOP>
noremap ga ^
noremap ge g_

tnoremap <Esc> <C-\><C-n>

map tt <LEADER>c<SPACE>
map tn :tabn<CR>
map tp :tabp<CR>
map tm :set splitbelow<CR>:split term://fish<CR>:res -5<CR>i

noremap r :call CompileRunGcc()<CR>

" run command in terminal
func! RunInTerminal(cmd)
  exec "set splitbelow"
  if exists("w:args")
    exec "split term://" . a:cmd . w:args
  else
  exec "split term://" . a:cmd
  endif
  exec "res -5"
  normal i
endfunc

" run the current file
func! CompileRunGcc()
  exec "w"
  if &filetype == 'html'
    silent! exec "!chromium % &"
  elseif &filetype == 'markdown'
    exec "MarkdownPreview"
  elseif &filetype == 'javascript'
    exec "!node % &"
  elseif &filetype == 'java'
    call RunInTerminal("javac % && java " . expand('%:t:r'))
  elseif &filetype == 'lua'
    call RunInTerminal("nodemcu-tool upload % && nodemcu-tool terminal --run % ")
  elseif &filetype == 'python'
    call RunInTerminal("python3 % ")
  elseif &filetype == 'cpp'
    call RunInTerminal("g++ % -o " . expand('%:t:r') . " && ./" . expand('%:t:r'))
  endif
endfunc

call plug#begin('~/.config/nvim/plugged')

" universal tools
Plug 'scrooloose/nerdcommenter'
" Plug 'frazrepo/vim-rainbow'
Plug 'scrooloose/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'connorholyday/vim-snazzy'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'
Plug 'Konfekt/FastFold'

" auto complete tools
autocmd BufEnter * call ncm2#enable_for_buffer()
" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect
" NOTE: you need to install completion sources to get completions. Check
" our wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-cssomni'
Plug 'ncm2/ncm2-tern', {'do': 'npm install'}
Plug 'ncm2/ncm2-jedi'
" let g:ncm2_pyclang#library_path = '/usr/lib/libLLVM-9.so'
" Plug 'ncm2/ncm2-pyclang'

" markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install_sync() }, 'for' :['markdown', 'vim-plug'] } |
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle' }

" html
Plug 'mattn/emmet-vim'
Plug 'vim-scripts/loremipsum'
Plug 'hail2u/vim-css3-syntax'

call plug#end()


let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

let g:user_emmet_leader_key='<C-Z>'


set laststatus=2

" rainbow config
let g:rainbow_active = 1

" NerdCommenter Config
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDToggleCheckAllLines = 1
let g:NERDTrimTrailingWhitespace = 1

map <TAB> :NERDTreeToggle<CR>

" markdown preview
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ''
let g:mkdp_browser = 'chromium'
let g:mkdp_echo_preview_url = 0
let g:mkdp_browserfunc = ''
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1
    \ }
let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = ''
let g:mkdp_page_title = '「${name}」'

" vim table mode
nmap <LEADER>tm :TableModeToggle<CR> 
let g:table_mode_corner='|'

let g:SnazzyTransparent = 1
colorscheme snazzy

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" auto-pairs
" let g:AutoPairsShortcutFastWrap = '<C-a>'

" set lazyredraw
" set regexpengine=1
