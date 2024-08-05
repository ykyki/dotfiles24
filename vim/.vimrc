filetype plugin indent on

if &compatible
    set nocompatible
endif

set encoding=utf-8
set fileencodings=utf-8,cp932,euc-jp,default,latin1,ucs-bom

set nobackup " バックアップファイルを作らない
set noswapfile " スワップファイルを作らない
set autoread " 編集中のファイルが変更されたら自動で読み直す
set hidden " バッファが編集中でもその他のファイルを開けるように
set confirm " 保存されていないファイルがあるときは終了前に保存確認

set showcmd " 入力中のコマンドをステータスに表示する
let mapleader = ' '
let maplocalleader = ','
set updatetime=500
set mouse=a

set termguicolors

augroup MyAutoCmd
    " リロードしたときの重複登録を避けるためにクリアしておく
    autocmd!
    " 前回のカーソルの位置から再開
    au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
    " カーソルのある行をウィンドウ中央にする
    au BufWinEnter * exe "normal zz"
augroup END

" ヤンクしたときに自動的にクリップボードに送る
set clipboard&
set clipboard^=unnamed,unnamedplus

" インデント設定
set expandtab
set tabstop=4
set shiftwidth=0
set softtabstop=0
set smarttab
set smartindent " インデントはスマートインデント
" autocmd FileType php setlocal noexpandtab tabstop=4 shiftwidth=0
autocmd FileType yaml      setlocal expandtab   tabstop=2 shiftwidth=0
autocmd FileType lua       setlocal expandtab   tabstop=2 shiftwidth=0
autocmd FileType php       setlocal expandtab   tabstop=4 shiftwidth=0
autocmd FileType tex       setlocal noexpandtab tabstop=4 shiftwidth=0
autocmd FileType sbt       setlocal expandtab   tabstop=2 shiftwidth=0
autocmd FileType gitconfig setlocal noexpandtab tabstop=4 shiftwidth=0

set visualbell " ビープ音を可視化
set showmatch " 括弧入力時の対応する括弧を表示
set matchtime=1
set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:% " 不可視文字を可視化
set nowrap " 行を折り返さない

set laststatus=2 " ステータスラインを常に表示
set wildmode=list:longest " コマンドラインの補完
set wildmenu
" set virtualedit=onemore " 行末の1文字先までカーソルを移動できるように

set nospell
" set spelllang=en,cjk

set backspace=indent,eol,start

set foldmethod=indent
set foldlevel=99
" set foldlevelstart=-1
" set foldcolumn=3
" au BufWinEnter * let &foldlevel = max(map(range(1, line('$')), 'foldlevel(v:val)'))

" キーバインド
inoremap jk <ESC>
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" nnoremap <silent> J :bp<CR>
" nnoremap <silent> K :bn<CR>
nnoremap <silent> bp :bp<CR>
nnoremap <silent> bn :bn<CR>
nnoremap <silent> X :bd<CR>
nnoremap <silent> J :tabp<CR>
nnoremap <silent> K :tabn<CR>
" nnoremap <silent> X :tabc<CR>
nnoremap <silent> gJ :tabmove -1<CR>
nnoremap <silent> gK :tabmove +1<CR>
nnoremap <silent> gT :tab sp<CR>

nnoremap Y y$
nnoremap <C-w>- :sp<CR>
nnoremap <C-w>\ :vs<CR>

vnoremap < <gv
vnoremap > >gv

nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
nnoremap Q  <Nop>

noremap [plugin] <Nop>
nmap <Leader> [plugin]
vmap <Leader> [plugin]

nnoremap [plugin]z :setlocal wrap!<CR>

let g:python3_host_prog = expand('~/.asdf/shims/python')
let g:python_host_prog = g:python3_host_prog

" --- レイアウトに関する設定 ---
syntax enable " シンタックスハイライトの有効化

set number " 行番号を表示

" " 行番号を相対表示
" set relativenumber
" set number relativenumber
" augroup numbertoggle
"       autocmd!
"       autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
"       autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
" augroup END

augroup vimrc-auto-cursorline
    autocmd!
    autocmd CursorMoved,CursorMovedI * call s:auto_cursorline('CursorMoved')
    autocmd CursorHold,CursorHoldI * call s:auto_cursorline('CursorHold')
    autocmd WinEnter * call s:auto_cursorline('WinEnter')
    autocmd WinLeave * call s:auto_cursorline('WinLeave')

    let s:cursorline_lock = 0
    function! s:auto_cursorline(event)
        if a:event ==# 'WinEnter'
            setlocal cursorline
            let s:cursorline_lock = 2
        elseif a:event ==# 'WinLeave'
            setlocal nocursorline
        elseif a:event ==# 'CursorMoved'
            if s:cursorline_lock
                if 1 < s:cursorline_lock
                    let s:cursorline_lock = 1
                else
                    setlocal nocursorline
                    let s:cursorline_lock = 0
                endif
            endif
        elseif a:event ==# 'CursorHold'
            setlocal cursorline
            let s:cursorline_lock = 1
        endif
    endfunction
augroup END

call plug#begin()
    " https://github.com/tpope/vim-sensible
    Plug 'tpope/vim-sensible'

    " https://github.com/tpope/vim-commentary
    Plug 'tpope/vim-commentary'

    " https://github.com/tpope/vim-surround
    Plug 'tpope/vim-surround'

    " https://github.com/machakann/vim-highlightedyank
    Plug 'machakann/vim-highlightedyank'

    " https://github.com/michaeljsmith/vim-indent-object
    Plug 'michaeljsmith/vim-indent-object'

    " https://github.com/junegunn/seoul256.vim
    Plug 'junegunn/seoul256.vim'

    " https://github.com/ryanoasis/vim-devicons
    Plug 'ryanoasis/vim-devicons'

    " https://github.com/preservim/vim-indent-guides
    Plug 'nathanaelkane/vim-indent-guides'

    " https://github.com/ctrlpvim/ctrlp.vim
    Plug 'ctrlpvim/ctrlp.vim'
call plug#end()

" ----- vim-highlightedyank
let g:highlightedyank_highlight_duration = 500

" ----- seoul256.vim
" seoul256 (dark):
"   Range:   233 (darkest) ~ 239 (lightest)
"   Default: 237
let g:seoul256_background = 233
silent! colorscheme seoul256

" ----- vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'tagbar', 'unite']


" ----- ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_tabpage_position  = 'ac'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_switch_buffer     = 'et'
let g:ctrlp_show_hidden = 1
let g:ctrlp_max_depth = 15
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_lazy_update = 10
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/](\.(git|hg|svn|idea)|out|tags|branches|node_modules|vendor(|s)|venv|target|\.next)$',
    \ 'file': '\v\.(exe|bat|bin|so|dll|jpg|png|pdf|dvi|aux|blg|log|thm|idx|synctex.gz|fls|out|fdb_latexmk|nav|snm|sta|ilg|ind|DS_Store|gitkeep|class)$',
\ }
let g:ctrlp_prompt_mappings = {
    \ 'PrtBS()':              ['<bs>', '<c-]>'],
    \ 'PrtDelete()':          ['<del>'],
    \ 'PrtDeleteWord()':      ['<c-w>'],
    \ 'PrtClear()':           ['<c-u>'],
    \ 'PrtSelectMove("j")':   ['<c-n>', '<down>'],
    \ 'PrtSelectMove("k")':   ['<c-p>', '<up>'],
    \ 'PrtSelectMove("t")':   ['<Home>', '<kHome>'],
    \ 'PrtSelectMove("b")':   ['<End>', '<kEnd>'],
    \ 'PrtSelectMove("u")':   ['<PageUp>', '<kPageUp>'],
    \ 'PrtSelectMove("d")':   ['<PageDown>', '<kPageDown>'],
    \ 'PrtHistory(-1)':       ['<c-k>'],
    \ 'PrtHistory(1)':        ['<c-j>'],
    \ 'AcceptSelection("e")': ['<c-t>', '<2-LeftMouse>'],
    \ 'AcceptSelection("h")': ['<c-h>'],
    \ 'AcceptSelection("v")': ['<c-v>', '<RightMouse>'],
    \ 'AcceptSelection("t")': ['<cr>'],
    \ 'ToggleFocus()':        ['<s-tab>'],
    \ 'ToggleRegex()':        ['<c-s>'],
    \ 'ToggleByFname()':      ['<c-d>'],
    \ 'ToggleType(1)':        ['<c-f>', '<c-up>'],
    \ 'ToggleType(-1)':       ['<c-b>', '<c-down>'],
    \ 'PrtExpandDir()':       ['<tab>'],
    \ 'PrtInsert("c")':       ['<MiddleMouse>', '<insert>'],
    \ 'PrtInsert()':          ['<c-\>'],
    \ 'PrtCurStart()':        ['<c-a>'],
    \ 'PrtCurEnd()':          ['<c-e>'],
    \ 'PrtCurLeft()':         ['<left>', '<c-^>'],
    \ 'PrtCurRight()':        ['<c-l>', '<right>'],
    \ 'PrtClearCache()':      ['<F5>', '<c-r>'],
    \ 'PrtDeleteEnt()':       ['<F7>'],
    \ 'CreateNewFile()':      ['<c-y>'],
    \ 'MarkToOpen()':         ['<c-z>'],
    \ 'OpenMulti()':          [],
    \ 'PrtExit()':            ['<esc>', '<c-c>', '<c-g>'],
\ }
