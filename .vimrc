set number
set relativenumber
set tabstop=2
set smarttab
set expandtab
set shiftwidth=2
set backspace=2
set mouse=a
set nobackup
set noswapfile
set colorcolumn=80
set visualbell t_vb=
set t_Co=256
set mousehide
set guicursor=i:block-Cursor
set termencoding=utf-8
set fileencodings=utf8,p1251
set wrap linebreak nolist
set cursorline
set cursorlineopt=number
set cursorcolumn
set wildmenu
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.orig
syntax on
filetype plugin indent on
set nocompatible
let g:mapleader=','
set listchars=tab:>·,extends:>,precedes:<
set list
"----------------------SEARCHING-----------------------------------------------
set hlsearch
set incsearch
"----------------------VIM-PLUG------------------------------------------------
call plug#begin('~/.vim/plugged')
Plug 'ryanoasis/vim-devicons'
Plug 'yasukotelin/shirotelin'
Plug 'sheerun/vim-polyglot'
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'rafi/awesome-vim-colorschemes'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'NLKNguyen/papercolor-theme'
Plug 'ntpeters/vim-better-whitespace'
Plug 'airblade/vim-gitgutter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rhysd/vim-healthcheck'
Plug 'kien/ctrlp.vim'
Plug 'rhysd/vim-clang-format'
Plug 'vim-scripts/asm2d-vim'
Plug 'iamcco/diagnostic-languageserver'
Plug 'tpope/vim-fugitive'
call plug#end()
"-----------------------NERDTREE-----------------------------------------------
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
"-----------------------COLORSCHEME--------------------------------------------
set background=light
let g:airline_theme='dracula'
"let g:gruvbox_contrast_dark='hard'
"let g:gruvbox_italic=1
"let g:gruvbox_termcolors=16
colorscheme shirotelin
"---------------------VIM-AIRLINE----------------------------------------------
let g:airline_section_z =  "\ue0a1:%l/%L Col:%c"

autocmd filetype cpp map <F5> :w <CR>: !g++ -std=c++17 % && ./a.out<CR>
autocmd filetype c map <F5> :w <CR>: !gcc -std=c17 % && ./a.out<CR>
"-------------------LANGUAGE-SERVER--------------------------------------------
let g:coc_global_extensions = [
      \'coc-jedi',
      \'coc-diagnostic',
      \'coc-sh',
      \'coc-json',
      \'coc-clang-format-style-options',
      \'coc-clangd',
      \]
" It's intended to use Bear with clangd. (The command is: bear -- redo/make)
" use <tab> for trigger completion and navigate to the next complete item
function! CheckBackspace() abort
  let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
            \ CheckBackspace() ? "\<Tab>" :
                  \ coc#refresh()

inoremap <silent><expr> <S-Tab>
      \ coc#pum#visible() ? coc#pum#prev(1) :
            \ CheckBackspace() ? "\<S-Tab>" :
                  \ coc#refresh()

inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)


"-----------------VIM-CREATE-AND-MOVE-SPLITS----------------------------------

map <silent> <C-h> :call WinMove('h')<CR>
map <silent> <C-j> :call WinMove('j')<CR>
map <silent> <C-k> :call WinMove('k')<CR>
map <silent> <C-l> :call WinMove('l')<CR>

function! WinMove(key)
  let t:curwin = winnr()
  exec "wincmd ".a:key
  if (t:curwin == winnr())
    if (match(a:key,'[jk]'))
      wincmd v
    else
      wincmd s
    endif
    exec "wincmd ".a:key
  endif
endfunction
"-----------------------------CLANG-FORMAT-------------------------------------
" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
" autocmd FileType c,cpp,objc ClangFormatAutoEnable
" " Toggle auto formatting:
" nmap <Leader>C :ClangFormatAutoToggle<CR>

autocmd FileType py nnoremap <buffer><Leader>cf :<C-u>black<CR>
autocmd FileType py vnoremap <buffer><Leader>cf :black<CR>

"-----------------------------LANGUAGE-HIGHLIGHT-------------------------------
let g:python_highlight_all = 1
