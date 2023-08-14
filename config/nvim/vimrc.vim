set rtp +=~/.config/nvim

" -------------------------------------------------------------------------------------------------
" Plugins
" -------------------------------------------------------------------------------------------------

call plug#begin("~/.vim/plugged")
  Plug 'Exafunction/codeium.vim'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'Yggdroot/indentLine'
  Plug 'airblade/vim-gitgutter'
  Plug 'arcticicestudio/nord-vim', { 'branch': 'main' }
  Plug 'dense-analysis/ale'
  Plug 'easymotion/vim-easymotion'
  Plug 'edkolev/tmuxline.vim'
  Plug 'fatih/vim-go'
  Plug 'itchyny/lightline.vim'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/goyo.vim'
  Plug 'junegunn/limelight.vim'
  Plug 'lifepillar/vim-solarized8'
  Plug 'luochen1990/rainbow'
  Plug 'majutsushi/tagbar'
  Plug 'mfussenegger/nvim-jdtls'
  Plug 'mhinz/vim-startify'
  Plug 'neovim/nvim-lspconfig'
  Plug 'preservim/nerdtree'
  Plug 'preservim/tagbar'
  Plug 'projekt0n/github-nvim-theme'
  Plug 'rainglow/vim'
  Plug 'rust-lang/rust.vim'
  Plug 'ryanoasis/vim-devicons'
  Plug 'severin-lemaignan/vim-minimap'
  Plug 'sheerun/vim-polyglot'
  Plug 'tomasr/molokai'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-surround'
  Plug 'voldikss/vim-floaterm'
call plug#end()

" -------------------------------------------------------------------------------------------------
" Settings
" -------------------------------------------------------------------------------------------------

colorscheme nord
syntax on
set number
set mouse=a
set noshowmode
set laststatus=2
set showtabline=2
set cmdheight=1
set cmdwinheight=5
set cursorline
syntax enable
filetype plugin indent on

" -------------------------------------------------------------------------------------------------
" Key Bindings
" -------------------------------------------------------------------------------------------------

nmap <Leader># :TagbarToggle<CR>

let g:undotree_WindowLayout = 2
nnoremap U :UndotreeToggle<CR>

noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>
set splitbelow
set splitright
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

noremap  <leader>t  :FloatermToggle<CR>i
noremap! <leader>t  <Esc>:FloatermToggle<CR>i
tnoremap <leader>t  <C-\><C-n>:FloatermToggle<CR>

" -------------------------------------------------------------------------------------------------
" tmuxline
" -------------------------------------------------------------------------------------------------
let g:tmuxline_powerline_separators = 0
let g:tmuxline_separators = {
    \ 'left' : '',
    \ 'left_alt': '',
    \ 'right' : '',
    \ 'right_alt' : '',
    \ 'space' : ' '}
let g:tmuxline_preset = {
      \'a'    : '#I #W',
      \'x'    : '%Y-%m-%d',
      \'y'    : '%H:%M',
      \'z'    : '#H'}

" -------------------------------------------------------------------------------------------------
" lightline
" -------------------------------------------------------------------------------------------------

let g:lightline = {
      \ 'colorscheme': 'nord',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly' ] ],
      \   'right': [ [ 'lineinfo', 'gitbranch', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \   'filename': 'LightlineFilename',
      \   'mode':'LightlineMode'
      \ },
      \ }

function! LightlineFilename()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let modified = &modified ? ' +' : ''
  return filename . modified
endfunction

function! LightlineMode()
    let fname = expand('%:t')
    return fname =~# '^__Tagbar__' ? 'Tagbar' :
          \ fname ==# 'ControlP' ? 'CtrlP' :
          \ fname ==# '__Gundo__' ? 'Gundo' :
          \ fname ==# '__Gundo_Preview__' ? 'Gundo Preview' :
          \ fname =~# 'NERD_tree' ? 'NERDTree' :
          \ &ft ==# 'unite' ? 'Unite' :
          \ &ft ==# 'vimfiler' ? 'VimFiler' :
          \ &ft ==# 'vimshell' ? 'VimShell' :
          \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

" -------------------------------------------------------------------------------------------------
" FZF
" -------------------------------------------------------------------------------------------------

let $FZF_DEFAULT_OPTS = '--color fg:#D8DEE9,bg:#2E3440,hl:#A3BE8C,fg+:#D8DEE9,bg+:#434C5E,hl+:#A3BE8C,pointer:#BF616A,info:#4C566A,spinner:#4C566A,header:#4C566A,prompt:#81A1C1,marker:#EBCB8B'
let FZF_DEFAULT_COMMAND='fd --type f'
let FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
let g:fzf_tags_command = 'ctags -R'
let g:fzf_commands_expect = 'alt-enter,ctrl-x'
let g:fzf_layout = { 'window': 'call FloatingFZF()' }

function! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')

  let height = float2nr(25)
  let width = float2nr(80)
  let horizontal = float2nr((&columns - width) / 2)
  let vertical = 3

  let opts = {
        \ 'relative': 'editor',
        \ 'row': vertical,
        \ 'col': horizontal,
        \ 'width': width,
        \ 'height': height,
        \ 'style': 'minimal'
        \ }

  call nvim_open_win(buf, v:true, opts)
endfunction

autocmd! FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
  nnoremap <C-p> :FZF<CR>

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}

" -------------------------------------------------------------------------------------------------
" limelight / Goyo
" -------------------------------------------------------------------------------------------------

" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'

" Default: 0.5
let g:limelight_default_coefficient = 0.7

" Number of preceding/following paragraphs to include (default: 0)
let g:limelight_paragraph_span = 1

" Beginning/end of paragraph
"   When there's no empty line between the paragraphs
"   and each paragraph starts with indentation
let g:limelight_bop = '^\s'
let g:limelight_eop = '\ze\n^\s'

" Highlighting priority (default: 10)
"   Set it to -1 not to overrule hlsearch
let g:limelight_priority = -1

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" -------------------------------------------------------------------------------------------------
" NERDTree
" -------------------------------------------------------------------------------------------------

let NERDTreeQuitOnOpen = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = ['^build$', '^vendor$']
let g:NERDTreeStatusline = ''
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <silent> <C-k><C-b> :NERDTreeFocus<CR>
nnoremap <silent> <Leader>v :NERDTreeFind<CR>
nmap <leader>nf :NERDTreeFind<CR>

" -------------------------------------------------------------------------------------------------
" Terminal
" -------------------------------------------------------------------------------------------------

if exists('$SHELL')
  set shell=$SHELL
else
  set shell=/usr/local/bin/zsh
endif
set splitright
set splitbelow
tnoremap <Esc> <C-\><C-n>
function! OpenTerminal()
  split term://bash
  resize 10
endfunction
nnoremap <c-n> :call OpenTerminal()<CR>

" -------------------------------------------------------------------------------------------------
" rust
" -------------------------------------------------------------------------------------------------

let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" --------
" terminal
" --------

let g:floaterm_width = 100
let g:floaterm_winblend = 0
