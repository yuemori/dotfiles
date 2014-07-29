"""""""""""""""""""""""""""
"    NeoBunldle config    "
"""""""""""""""""""""""""""
set nocompatible
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif

call neobundle#rc(expand('~/.vim/bundle'))
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/neocomplcache'
" vimで非同期処理をする（プラグインによってはこれが必要になる）
NeoBundle 'Shougo/vimproc'
" Unite
NeoBundle 'Shougo/unite.vim'
" Uniteでfile_mruを使う
NeoBundle 'Shougo/neomru.vim'
" Uniteでcakeを使える
NeoBundle 'oppara/vim-unite-cake'
" Uniteでrailsを使える
NeoBundle 'basyura/unite-rails'
" Uniteでfiletypeを使える
NeoBundle 'osyo-manga/unite-filetype'
" Uniteでcolorschemeをプレビューできる
NeoBundle 'ujihisa/unite-colorscheme'
" スニペット
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'honza/vim-snippets'
" :NERDTreeでツリー表示してくれる
NeoBundle 'scrooloose/nerdtree'
" Rails用プラグイン
NeoBundle 'tpope/vim-rails'
" 括弧などの自動保管
NeoBundle 'Townk/vim-autoclose'
" vim版emmet
NeoBundle 'mattn/emmet-vim'
" テキストオブジェクトの操作拡張
NeoBundle 'surround.vim'
" endを保管してくれる
NeoBundle 'endwise.vim'
" Ctrl+-二回押しでコメントアウトする
NeoBundle 'tomtom/tcomment_vim'
" GitをVimから使えるようにする
NeoBundle 'tpope/vim-fugitive'
" インデントの深さを視覚化する
NeoBundle 'nathanaelkane/vim-indent-guides'
" vimfiler
NeoBundle 'Shougo/vimfiler'
" vimshell
NeoBundle 'Shougo/vimshell'
" タブページの増減とかに使う
NeoBundle 'kana/vim-submode'
" Sass記法のシンタックスハイライト
NeoBundle 'Sass'
" Twigのシンタックスハイライト
NeoBundle 'evidens/vim-twig'
" Rubyのコーディングルールへの準拠チェック
NeoBundle 'rubocop'
" 色んなファイルのSyntaxエラーをチェック
NeoBundle 'scrooloose/syntastic'
NeoBundle 'jQuery'
NeoBundle 'JavaScript-syntax'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'othree/html5.vim'
NeoBundle 'hail2u/vim-css3-syntax'
" 以下カラースキーマのプラグイン
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'tomasr/molokai'
NeoBundleCheck

""""""""""""""""
" システム設定
""""""""""""""""
" クリップボードをvim以外と共有
set clipboard+=unnamed,unnamedplus
" ビープを鳴らさない
set vb t_vb=
" バックスペースでなんでも消せるように
set backspace=indent,eol,start
" プラグインの利用を有効化
filetype plugin indent on
" F10でpasteモードをトグルする
set pastetoggle=<F10>
" insertモードで自動的にIMEがオンになるのを防ぐ
set iminsert=0
"マウスを有効にする
if has('mouse')
  set mouse=a
endif
" matchitを有効化
if !exists('loaded_matchit')
  runtime macros/matchit.vim
endif
""""""""""""""""
" ファイル関連
""""""""""""""""
" バックアップファイルは使わない
set nobackup
" スワップファイルは使わない
set noswapfile
" アンドゥファイルは使わない
set noundofile
" 保存されていないファイルがあっても別のファイルを開けるようにする
set hidden
set confirm " 保存されていないファイルがあるときは終了前に確認
set autoread " 外部でファイルに変更がある場合は読み直す

""""""""""""""
"  表示設定
""""""""""""""
" :introの画面を出さないようにする
set shortmess+=I
" vimを使ってくれてありがとう
set notitle 
" 構文にあわせて文字色を変化
syntax on
" ハイライトオン
syntax enable
" ルーラーを表示
set ruler
" 不可視文字を表示する
set list
" ウィンドウのタイトルバーにファイルのパス情報などを表示
set title
" コマンドラインモードで<Tab>キーによるファイル名補完を有効にする
set wildmenu
" 行番号を表示
set number
" 対応する括弧やプレースを表示する
set showmatch
" 前の行のインデントを継続
set autoindent
" 改行時に入力された行の末尾に合わせて次の行のインデントを調整
set smartindent
" ヒストリの保存数
set history=50
" カーソルキーで行末／行頭の移動可能に設定
set whichwrap=b,s,[,],<,>
" □や○の文字があってもカーソル位置がずれないようにする
set ambiwidth=double
" バックスペースでインデントや改行を削除できるようにする
set backspace=indent,eol,start
" Windwosでディレクトリパスのセパレーターにスラッシュを利用可能に
set shellslash
" コマンドをステータス行に表示
set showcmd
" 行末の半角スペースを表示する
set listchars=trail:~
" 表示行数（縦）
"set lines=40
" 表示行数（横）
"set columns=100
" 折り返し表示
set wrap
" カーソル行の背景色を変える
set cursorline
" カーソル位置のカラムの背景色を変える
set cursorcolumn

""""""""""""""""""""""
" 移動関連
""""""""""""""""""""""
" 上下8行の視界を確保
set scrolloff=8
" 左右スクロール時の視界を確保
set sidescrolloff=16
" 左右スクロールは一文字づつ行う
set sidescroll=1

"------------------"
" カラースキーマ
"------------------"
colorscheme desert

"""""""""""""""""""
"  文字コード設定   
""""""""""""""""""""
set encoding=utf-8
set fileencodings=utf-8
set fileformats=unix,dos

" Windowsで下部のメニューが文字化けするのでその対策
set termencoding=cp932
" Windowsでgvimのメニューが文字化けするのでその対策
source $VIMRUNTIME/delmenu.vim
set langmenu=ja_jp.utf-8
source $VIMRUNTIME/menu.vim

"""""""""""""""""""""
"  tabstopの設定
"""""""""""""""""""""
set tabstop=2
set shiftwidth=2
set softtabstop=0
set showtabline=2
" タブ入力を空白に置換
set expandtab

""""""""""""""""""""
"  検索
""""""""""""""""""""
" 検索ワードの最初の文字を入力した時点で検索を開始
set incsearch
" 検索結果をハイライト表示
set hlsearch
" 検索で大文字小文字を区別しない
set ignorecase
" 検索で大文字小文字両方が入力されたら区別して検索
set smartcase
" 検索時にファイルの最後まで行ったら最初に戻る
set wrapscan
" 検索のときgオプションをデフォルトで有効にする
set gdefault

"""""""""""""""
" fugitive.vim
"""""""""""""""
set statusline+=%{fugitive#statusline()}
" git statusを表示
nnoremap <Space>gs :<C-u>Gstatus<CR>
" 現在開いているソースをgit add
nnoremap <Space>ga :<C-u>Gwrite<CR>
" git commit
nnoremap <Space>gc :<C-u>Gcommit<CR>
" 現在のソースの変更点をvimdiffで表示
nnoremap <Space>gd :<C-u>Gdiff<CR>
" git blame
nnoremap <Space>gb :<C-u>Gblame<CR>

"""""""""""""""""""
" vim-indent-guides
"""""""""""""""""""
let g:indent_guides_enable_on_vim_startup = 1

"""""""""""""""""""
" vim-emmet
"""""""""""""""""""
let g:user_emmet_mode = 'iv'
let g:user_emmet_leader_key = '<C-Y>'
let g:user_emmet_settings = {
      \ 'lang' : 'ja',
      \ 'html' : {
      \   'filters' : 'html',
      \ },
      \ 'css' : {
      \   'filters' : 'fc',
      \ },
      \ 'php' : {
      \   'extends' : 'html',
      \   'filters' : 'html',
      \ },
      \}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  キーマッピング設定
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" exモードの無効化
nnoremap Q <Nop>
" pasteモードのキーマッピング
nnoremap <F10> :set paste!<CR>:set paste?<CR>
" インサートモードでjjをEscにマッピング
inoremap <silent> jj <ESC>
" インサートモードを抜けると自動的にIMをオフにする
noremap <silent> <ESC> <ESC>:set iminsert=0<CR>
" Ctrl+Spaceでキーワード補完を展開
inoremap <C-space> <C-p>
" ノーマルモードで行頭に移動
nnoremap <Space>h ^
" ノーマルモードで行末に移動
nnoremap <Space>l $
" 単語検索
nnoremap <Space>/ *
" インサートモードで行頭に移動
inoremap <silent> <C-i> <ESC><I>
" インサートモードで行末に移動
inoremap <silent> <C-a> <ESC><A>

" 以下、タブ切り替え用のキーマッピング
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sn gt
nnoremap sp gT
nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap so <C-w>_<C-w>|
nnoremap sO <C-w>=
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap sT :<C-u>Unite tab<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>
nnoremap sb :<C-u>Unite buffer_tab -buffer-name=file<CR>
nnoremap sB :<C-u>Unite buffer -buffer-name=file<CR>

call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')
call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')
call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')
call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')
call submode#map('bufmove', 'n', '', '>', '<C-w>>')
call submode#map('bufmove', 'n', '', '<', '<C-w><')
call submode#map('bufmove', 'n', '', '+', '<C-w>+')
call submode#map('bufmove', 'n', '', '-', '<C-w>-')

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  プラグイン関連設定"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"---------------------
" neosnippet
"---------------------
let g:neosnippet#enable_snipmate_compatibility=1
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

"---------------------
"  unite.vim {{{
"---------------------
" 入力モードで開始する
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable=1
" ファイル履歴を200まで保存
let g:unite_source_file_mru_limit=200
" file_mruの表示フォーマット
let g:unite_source_file_mru_filename_format = ''
" bookmarkをホームディレクトリに保存
let g:unite_source_bookmark_directory = $HOME.'/.unite/bookmark'

" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
" " ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

"" キーマッピング
" バッファ一覧
nnoremap <Space>ub :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <Space>uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <Space>ur :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <Space>um :<C-u>Unite file_mru<CR>
" ヤンク履歴一覧
nnoremap <Space>uy :<C-u>Unite history/yank<CR>
" 常用セット
nnoremap <Space>uu :<C-u>Unite file_mru buffer<CR>

" }}}

"---------------------
" vimfiler{{{
"---------------------

" vimデフォルトのエクスプローラをvimfilerで置き換える
let g:vimfiler_asdefault_explorer=1
" セーフモードを無効にした状態で起動
let g:vimfiler_safe_mode_by_default=0
" 現在開いているバッファのディレクトリを開く
nnoremap <Space>fe :<C-u>VimFilerBufferDir -quit<CR>
" 現在開いているバッファをIDE風に開く
nnoremap <Space>fi :<C-u>VimFilerBufferDir -split -simple -winwidth=35 -no-quit<CR>

" デフォルトのキーマッピングを変更
augroup vimrc
  autocmd FileType vimfiler call s:vimfiler_my_settings()
augroup END
function! s:vimfiler_my_settings()
  nmap <buffer> q <Plug>(vimfiler_exit)
  nmap <buffer> Q <Plug>(vimfiler_hide)
endfunction

" }}}

"---------------------
" vimshell
"---------------------
nnoremap <Space>vs :VimShell<CR>

"---------------------
" 全角スペースの表示
"---------------------
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme * call ZenkakuSpace()
        autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
    augroup END
    call ZenkakuSpace()
endif

"------------------
" syntasticの設定
"------------------
let g:syntastic_enable_signs = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_mode_map = {'mode': 'active', 'active_file_types': [], 'passive_filetypes': ['html']}
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_javascript_checkers = ['jshint']

"------------------
" html5.vim{{{
"------------------
let g:html5_event_handler_attributes_complete = 1
let g:html5_rdfa_attributes_complete = 1
let g:html5_microdata_attributes_complete = 1
let g:html5_aria_attributes_complete = 1

"}}}

"------------------
" 透過設定
"------------------
function! s:toggle_transparence()
    if &transparency == 180
        set transparency=0
    else
        set transparency=180
    endif
endfunction
nnoremap <silent> <Space>oT :<C-u>call <SID>toggle_transparence()<CR>

"-----------------
" syntax関連
"-----------------
" erbファイルでhtmlスニペットを有効にする
autocmd BufNewFile,BufRead *.erb set filetype=eruby.html
" phpファイルでhtmlスニペットを有効にする
autocmd BufNewFile,BufRead *.php set filetype=php.html
" ctpファイルをphpとして関連付ける
autocmd BufNewFile,BufRead *.ctp set filetype=php.html
" twigファイルを認識させる
autocmd BufNewFile,BufRead *.twig set filetype=twig.html
