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
let mapleader = ' '
let maplocalleader = ','
set mouse=a

" ヤンクしたときに自動的にクリップボードに送る
set clipboard&
set clipboard^=unnamed,unnamedplus

" インデント設定
filetype plugin indent on
set expandtab
set tabstop=4
set shiftwidth=0
set softtabstop=0
set smarttab
set smartindent
autocmd FileType yaml      setlocal expandtab   tabstop=2 shiftwidth=0
autocmd FileType lua       setlocal expandtab   tabstop=2 shiftwidth=0
autocmd FileType php       setlocal expandtab   tabstop=4 shiftwidth=0
autocmd FileType tex       setlocal noexpandtab tabstop=4 shiftwidth=0
autocmd FileType sbt       setlocal expandtab   tabstop=2 shiftwidth=0
autocmd FileType gitconfig setlocal noexpandtab tabstop=4 shiftwidth=0

set nospell
" set spelllang=en,cjk
set nrformats-=octal

set ignorecase
set smartcase " 大文字が含まれているときにはcase sensitive

" --- Appearance
syntax enable " シンタックスハイライトの有効化
set termguicolors
set showcmd " 入力中のコマンドをステータスに表示する
set updatetime=500
set number " 行番号を表示
set noincsearch " 検索時にインクリメンタルサーチをしない
set hlsearch " 検索時にハイライト
set visualbell " ビープ音を可視化
set showmatch " 括弧入力時の対応する括弧を表示
set matchtime=1
set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:% " 不可視文字を可視化
set backspace=indent,eol,start
set nowrap " 行を折り返さない
set laststatus=2 " ステータスラインを常に表示
set wildmode=list:longest " コマンドラインの補完
set wildmenu
set foldmethod=indent
set foldlevel=99
" set foldlevelstart=-1
" set foldcolumn=3
" au BufWinEnter * let &foldlevel = max(map(range(1, line('$')), 'foldlevel(v:val)'))
augroup MyAutoCmd
    " リロードしたときの重複登録を避けるためにクリアしておく
    autocmd!
    " 前回のカーソルの位置から再開
    au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
    " カーソルのある行をウィンドウ中央にする
    au BufWinEnter * exe "normal zz"
augroup END

" --- Key Mapping
" inoremap jk <ESC>
nnoremap j  gj
nnoremap k  gk
nnoremap gj j
nnoremap gk k
vnoremap j  gj
vnoremap k  gk
vnoremap gj j
vnoremap gk k
nnoremap <silent> J  :bp<CR>
nnoremap <silent> K  :bn<CR>
nnoremap <silent> X  :bd<CR>
" nnoremap <silent> J  :tabp<CR>
" nnoremap <silent> K  :tabn<CR>
" nnoremap <silent> X  :tabc<CR>
" nnoremap <silent> gJ :tabmove -1<CR>
" nnoremap <silent> gK :tabmove +1<CR>
nnoremap <silent> gT :enew<CR>
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

" ----- Quick Memo
" let s:memo_path = expand('~/.local/share/memo.md') " 保存先
"
" function! s:toggle_memo() abort
"     " 既に開いていた場合はメモを閉じる
"     if expand('%') ==# s:memo_path
"         write
"         bdelete
"         return
"     endif
"
"     execute 'edit' s:memo_path
"     setlocal bufhidden=wipe noswapfile
"     call append(line("$"), "--------------------------------" )
"     call append(line("$"), strftime("%Y-%m-%d %H:%M:%S"))
"     call append(line("$"), "")
"     call cursor(line("$"), 1) " カーソルをファイル末尾に移動
"
"     augroup MemoAuGroup
"       autocmd!
"       " 自動保存設定
"       autocmd InsertLeave,TextChanged,BufLeave <buffer> silent update
"     augroup END
" endfunction
"
" コマンド
" command! Memo call s:toggle_memo()
" マッピング
" nnoremap mo <Cmd>Memo<CR>

" --- Plugins
" vim-plug https://github.com/junegunn/vim-plug
" Usage:
"   :PlugInstall
"   :PlugUpdate
"   :PlugDiff
"   :PlugClean
call plug#begin()
    " https://github.com/tpope/vim-commentary
    Plug 'tpope/vim-commentary'

    " https://github.com/tpope/vim-surround
    Plug 'tpope/vim-surround'

    " https://github.com/jiangmiao/auto-pairs
    Plug 'jiangmiao/auto-pairs'

    " https://github.com/michaeljsmith/vim-indent-object
    Plug 'michaeljsmith/vim-indent-object'

    " https://github.com/google/vim-searchindex
    Plug 'google/vim-searchindex'

    " https://github.com/junegunn/vim-easy-align
    Plug 'junegunn/vim-easy-align'

    " https://github.com/machakann/vim-highlightedyank
    Plug 'machakann/vim-highlightedyank'

    " https://github.com/michaeljsmith/vim-indent-object
    Plug 'michaeljsmith/vim-indent-object'

    " https://github.com/ap/vim-buftabline
    Plug 'ap/vim-buftabline'

    " https://github.com/junegunn/fzf.vim
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    " https://github.com/junegunn/seoul256.vim
    Plug 'junegunn/seoul256.vim'

    " https://github.com/ryanoasis/vim-devicons
    Plug 'ryanoasis/vim-devicons'

    " https://github.com/preservim/vim-indent-guides
    Plug 'nathanaelkane/vim-indent-guides'

    " https://github.com/luochen1990/rainbow
    Plug 'luochen1990/rainbow'

    " https://github.com/ctrlpvim/ctrlp.vim
    Plug 'ctrlpvim/ctrlp.vim'
    " Plug 'mattn/ctrlp-matchfuzzy'
    Plug 'mattn/ctrlp-matchfuzzy'
call plug#end()

" ----- jiangmiao/auto-pairs
let g:AutoPairsFlyMode = 0
let g:AutoPairsMapBS   = 1
let g:AutoPairsMapCh   = 1

" ----- google/vim-searchindex
let g:searchindex_line_limit = 1000000

" ----- junegunn/vim-easy-align
vmap <Enter> <Plug>(EasyAlign)

" ----- vim-highlightedyank
let g:highlightedyank_highlight_duration = 500

" ----- fzf.vim
let g:fzf_action = {
    \ 'enter':  'tab split',
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit'
    \ }
let g:fzf_layout = {
    \ 'window': { 'width': 0.9, 'height': 0.8 }
    \ }
" let g:fzf_layout = { 'down': '~40%' }
let g:fzf_preview_window = ['down:70%']
command! -bang -nargs=* Rg
    \ call fzf#vim#grep('rg --hidden --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
    \ fzf#vim#with_preview(), <bang>0)

" ----- seoul256.vim
" seoul256 (dark):
"   Range:   233 (darkest) ~ 239 (lightest)
"   Default: 237
let g:seoul256_background = 233
silent! colorscheme seoul256

" ----- vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level           = 1
let g:indent_guides_guide_size            = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'tagbar', 'unite']

" ----- luochen1990/rainbow
let g:rainbow_active = 1

" ----- ctrlp.vim
" Usage:
"   :Rg
"   :Colors
"   :Files
let g:ctrlp_map                 = '<c-p>'
let g:ctrlp_cmd                 = 'CtrlP'
let g:ctrlp_show_hidden         = 1
let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_lazy_update         = 10
let g:ctrlp_match_func          = {'match': 'ctrlp_matchfuzzy#matcher'}
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/](\.(git|hg|svn|idea)|out|tags|branches|node_modules|vendor(|s)|\.venv|target|\.next)$',
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
    \ 'AcceptSelection("e")': ['<cr>', '<2-LeftMouse>'],
    \ 'AcceptSelection("h")': ['<c-h>'],
    \ 'AcceptSelection("v")': ['<c-v>', '<RightMouse>'],
    \ 'AcceptSelection("t")': ['<c-t>'],
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

