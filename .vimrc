" ### NeoBundle設定 {{{
if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))
" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }
" if_luaが有効ならneocompleteを使う
NeoBundle has('lua') ? 'Shougo/neocomplete' : 'Shougo/neocomplcache'
NeoBundle 'vim-scripts/L9'

" スニペット
NeoBundle 'shougo/neosnippet'
NeoBundle 'shougo/neosnippet-snippets'
NeoBundle 'honza/vim-snippets'

" 入力補助
NeoBundle 'kana/vim-smartchr'
NeoBundle 'kana/vim-smartinput'
NeoBundle 'rhysd/clever-f.vim'
NeoBundle 'leafcage/yankround.vim'
NeoBundle 'jiangmiao/simple-javascript-indenter'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'surround.vim'
" NeoBundle 'endwise.vim'
NeoBundle 'cohama/vim-smartinput-endwise'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'AndrewRadev/switch.vim'

" 機能拡張
NeoBundle 'kana/vim-submode'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/vimshell'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'majutsushi/tagbar'

" Unite系
NeoBundle 'shougo/unite.vim'
NeoBundle 'shougo/neomru.vim'
NeoBundle 'basyura/unite-rails'
NeoBundle 'osyo-manga/unite-filetype'
" NeoBundle 'oppara/vim-unite-cake'

" Git系
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'airblade/vim-gitgutter'

" シンタックスチェック
NeoBundle 'scrooloose/syntastic'
NeoBundle 'jQuery'
NeoBundle 'JavaScript-syntax'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'othree/html5.vim'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'othree/javascript-libraries-syntax.vim'

" カラースキーマ
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'tomasr/molokai'

" 表示変更
NeoBundle 'itchyny/lightline.vim'
" インデントの深さを視覚化する
NeoBundle 'nathanaelkane/vim-indent-guides'

" Ruby用
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'tpope/vim-rails'
NeoBundle 'Sass'

" PHP用
NeoBundle 'violetyk/cake.vim'
NeoBundle 'evidens/vim-twig'

call neobundle#end()

NeoBundleCheck
" }}}

" ### 初期化 {{{
if filereadable(expand('~/.vimrc.local'))
  execute 'source' expand('~/.vimrc.local')
endif
" augroup init (from tyru's vimrc)
augroup vimrc
  au!
augroup END

command!
      \ -bang -nargs=*
      \ MyAutocmd
      \ au<bang> vimrc <args>
" }}}

" ### 文字コードの自動認識 {{{
" byずんwiki
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" 改行コードの自動認識
set fileformats=unix,dos,mac
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif
" }}}

" ### 基本設定 {{{
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
" モードラインを有効にする
set modeline
" ３行目までをモードラインとして検索
set modelines=3
"マウスを有効にする
if has('mouse')
  set mouse=a
endif
" matchitを有効化
if !exists('loaded_matchit')
  runtime macros/matchit.vim
endif
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
" ファイル名の補完時にマッチするところまで自動補完
set wildmode=list:longest
set laststatus=2
set noshowmode

" }}}

" ### 表示設定 {{{
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
" 改行コードなどを表示変更
set listchars=tab:>-,trail:.,eol:$,extends:>,precedes:<,nbsp:%
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
" 上下8行の視界を確保
set scrolloff=8
" 左右スクロール時の視界を確保
set sidescrolloff=16
" 左右スクロールは一文字づつ行う
set sidescroll=1
" }}}

" ### カラースキーマ {{{
if stridx($TERM, "xterm-256color") >= 0
  let g:solarized_termcolors= 256
  let g:solarized_contrast = "high"
  let g:solarized_termtrans = 1
  colorscheme solarized
endif

" 256色モード
if stridx($TERM, "xterm-256color") >= 0
  set t_Co=256
else
  set t_Co=16
endif
" }}}

" ### tabstopの設定 {{{
set tabstop=2
set shiftwidth=2
set softtabstop=0
set showtabline=2
" タブ入力を空白に置換
set expandtab
" }}}

" ### 検索 {{{
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
" }}}

" ### キーマッピング設定 {{{
" exモードの無効化
nnoremap Q <Nop>
" pasteモードのキーマッピング
nnoremap <F10> :set paste!<CR>:set paste?<CR>
" インサートモードでjjとkkをEscにマッピング
inoremap <silent> jj <ESC>
inoremap <silent> kk <ESC>
" インサートモードを抜けると自動的にIMをオフにする
" noremap <silent> <ESC> <ESC>:set iminsert=0<CR>
" Ctrl+Spaceでキーワード補完を展開
" inoremap <C-space> <C-p>
" ノーマルモードで行頭に移動
nnoremap <Space>h ^
" ノーマルモードで行末に移動
nnoremap <Space>l $
" 単語検索
nnoremap <Space>/ *

"挿入モードのキーバインドをemacs風に
inoremap <C-a> <Home>
" inoremap <C-e> <End>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-n> <Down>
inoremap <C-p> <Up>
inoremap <C-h> <BS>
inoremap <C-d> <Del>
" inoremap <C-k> <C-o>D

" JとDで半ページ移動
nnoremap J <C-D>
nnoremap K <C-U>

" 編集中のファイルのディレクトリに移動
nnoremap ,d :execute ":lcd" . expand("%:p:h")<CR>

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
" }}}

" ### filetype {{{
" HTML/CSS用設定
au FileType html setlocal noexpandtab ts=2 sw=2 fenc=utf-8
au FileType css setlocal expandtab ts=4 sw=2 fenc=utf-8

" PHP用設定
" PHPファイル用タブストップ設定
au FileType php setlocal expandtab ts=4 sw=4 fenc=utf-8
" phpファイルでhtmlスニペットを有効にする
au BufNewFile,BufRead *.php set filetype=html.php
" ctpファイルをphpとして関連付ける
au BufNewFile,BufRead *.ctp set filetype=html.php
" twigファイルを認識させる
au BufNewFile,BufRead *.twig set filetype=html.twig

" javascript用設定
" JavaScriptファイル用タブストップ設定
" au FileType javascript setlocal expandtab ts=2 sw=2 fenc=utf-8
" jqueryファイルを認識させる
" au BufNewFile,BufRead *.jquery.js set filetype=javascript syntax=jquery

" coffeescript用設定
" coffeescriptファイルを認識させる
au FileType coffee setlocal expandtab ts=2 sts=2 sw=2 et
au BufNewFile,BufRead *.coffee set filetype=coffee

" Ruby用設定
" YAMLファイル用タブストップ設定
au FileType yaml setlocal expandtab ts=2 sw=2 fenc=utf-8
" erbファイルでhtmlスニペットを有効にする
au BufNewFile,BufRead *.erb set filetype=eruby.html

" markdown用設定
au BufNewFile,BufRead *.md set filetype=markdown

" }}}

" ### plugin configure {{{
" ### QuickRun {{{
" QuickRunの設定オブジェクトをつくる
let g:quickrun_config = {}
 
" すべてのファイルタイプで vimproc をつかってコマンドを実行する
let g:quickrun_config['_'] = {
      \ 'runner': 'vimproc',
      \       'runner/vimproc/updatetime' : 100
      \ }
" }}}

" ### fugitive.vim {{{
" set statusline+=%{fugitive#statusline()}
" git statusを表示
nnoremap <Space>gs :<C-u>Gstatus<CR>
" 現在開いているソースをgit add
nnoremap <Space>ga :<C-u>Gwrite<CR>
" git commit
nnoremap <Space>gc :<C-u>Gcommit<CR>
" 現在のソースの変更点をvimdiffで表示
nnoremap <Space>gd :<C-u>Gdiff<CR>
" git log
nnoremap <Space>gl :<C-u>Glog<CR>
" git blame
nnoremap <Space>gb :<C-u>Gblame<CR>
" }}}

" ### vim-indent-guides {{{
let g:indent_guides_enable_on_vim_startup = 1
" }}}

" ### vim-emmet {{{
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
" }}}

" ### smartchr {{{
function! s:EnableSmartchrBasic()
  inoremap <buffer><expr> + smartchr#one_of(' + ', '+', '++')
  inoremap <buffer><expr> & smartchr#one_of(' & ', ' && ', '&')
  inoremap <buffer><expr> , smartchr#one_of(', ', ',')
  inoremap <buffer><expr> <Bar> smartchr#one_of('<Bar>', ' <Bar><Bar> ', '<Bar><Bar>')
  inoremap <expr> . smartchr#one_of('.', '->', ' => ', '.')
  inoremap <buffer><expr> = search('\(&\<bar><bar>\<bar>+\<bar>-\<bar>/\<bar>>\<bar><\) \%#', 'bcn')? '<bs>= ' : search('\(\*\<bar>!\)\%#')? '= ' : smartchr#one_of('=', ' = ', ' == ', ' === ')
endfunction

function! s:EnableSmartchrHash()
  inoremap <buffer><expr> > smartchr#one_of('>', ' => ', '>')
endfunction

function! s:EnableSmartchrRegExp()
  inoremap <buffer><expr> ~ search('\(!\<bar>=\) \%#', 'bcn')? '<bs>~ ' : '~'
endfunction

function! s:EnableSmartchrHaml()
  call s:EnableSmartchrRubyHash()
  inoremap <buffer> [ []<Esc>i
  inoremap <buffer> { {}<Esc>i
endfunction

function! s:EnableSmartchrCoffeeFunction()
  inoremap <buffer><expr> > smartchr#one_of('>', ' ->', '>')
endfunction

MyAutocmd FileType c,cpp,php,python,javascript,ruby,coffee,vim call s:EnableSmartchrBasic()
" MyAutocmd FileType python,ruby,coffee,vim call s:EnableSmartchrRegExp()
MyAutocmd FileType ruby php call s:EnableSmartchrRubyHash()
" MyAutocmd FileType ruby,eruby setlocal tags+=~/rtags
MyAutocmd FileType haml call s:EnableSmartchrHaml()
MyAutocmd FileType coffee call s:EnableSmartchrCoffeeFunction()
" }}}

" ### neocomplete / neocomplcache {{{
" Rubyのオムニ補完を設定
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_inglobal = 1
let g:rubycomplete_rails = 1
if neobundle#is_installed('neocomplete')
  " ### neocomplete {{{
  " ### neocomplete config {{{
  " 起動時に有効にする
  let g:neocomplete#enable_at_startup = 1
  "スニペットファイルの置き場所
  let g:neocomplete#snippets_dir = $HOME . '/.vim/bundle/neosnippet/autoload/neosnippet/snippets'

  " キャッシュディレクトリの場所
  if has('win32')
    let g:neocomplete#temporary_dir = $HOME . '/.neocon'
  elseif has('macunix')
    let g:neocomplete#temporary_dir = '~/.neocon'
  else
    let g:neocomplete#temporary_dir = '/tmp/.neocon'
  endif

  " 区切りの補完を有効化
  let g:neocomplete#enable_underbar_completion = 1

  " シンタックス補完を無効に
  let g:neocomplete#plugin_disable = {
        \ 'syntax_complete' : 1,
        \ }

  "ファイルタイプの関連付け
  if !exists('g:neocomplete#same_filetype_lists')
    let g:neocomplete#same_filetype_lists = {}
  endif
  let g:neocomplete#same_filetype_lists['ctp'] = 'php'
  let g:neocomplete#same_filetype_lists['erb'] = 'ruby'
  let g:neocomplete#same_filetype_lists['twig'] = 'html'

  " }}}

  " neocomplete view {{{
  " ポップアップメニューで表示される候補の数。
  let g:neocomplete#max_list=5
  " 自動補完を行う入力数を設定
  let g:neocomplete#auto_completion_start_length = 3
  " let g:neocomplete#min_syntax_length = 4
  let g:neocomplete#enable_smart_case = 1
  let g:neocomplete#enable_ignore_case = 1
  let g:neocomplete#enable_camel_case_completion = 0
  let g:neocomplete#enable_underbar_completion = 0
  " 1番目の候補を自動選択
  let g:neocomplete#enable_auto_select = 1
  " }}}
  
  " neocomplete keybinding {{{
  "改行で補完ウィンドウを閉じる
  inoremap <expr><CR> neocomplete#smart_close_popup() . "\<CR>"
  "tabで補完候補の選択を行う
  inoremap <expr><TAB> pumvisible() ? "\<Down>" : "\<TAB>"
  inoremap <expr><S-TAB> pumvisible() ? "\<Up>" : "\<S-TAB>"

  "C-yで補完候補の確定
  inoremap <expr><C-y> neocomplete#close_popup()
  " 補完候補が表示されている場合は確定。そうでない場合は改行
  inoremap <expr><Enter>  pumvisible() ? "\<C-Y>" : "\<Enter>"
  inoremap <expr><CR> pumvisible() ? neocomplete#close_popup() : "<CR>"

  "C-eで補完のキャンセルし、ウィンドウを閉じる。ポップアップが開いていないときはEndキー
  inoremap <expr><C-e> pumvisible() ? neocomplete#cancel_popup() : "\<End>"
  "C-gで補完を元に戻す
  inoremap <expr><C-g> neocomplete#undo_completion()

  "C-pで上キー
  inoremap <C-p> <Up>
  "補完候補の共通文字列を補完する(シェル補完のような動作)
  inoremap <expr><C-l> neocomplete#complete_common_string()

  " }}}


  " neocomplete completion config {{{
  "カーソルより後のキーワードパターンを認識。
  "h|geとなっている状態(|はカーソル)で、hogeを補完したときに後ろのキーワードを認識してho|geと補完する機能。
  "修正するときにかなり便利。
  "g:neocomplete#next_keyword_patternsは分からないときはいじらないほうが良いです。
  if !exists('g:neocomplete#next_keyword_patterns')
    let g:neocomplete#next_keyword_patterns = {}
  endif

  " Enable heavy omni completion. ruby用
  if !exists('g:neocomplete#omni_patterns')
    let g:neocomplete#omni_patterns = {}
  endif
  let g:neocomplete#omni_patterns.ruby = '[^. *¥t]¥.¥w*¥|¥h¥w*::'
  au FileType ruby setlocal omnifunc=rubycomplete#Complete

  "補完するためのキーワードパターンを指定
  if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
  endif
  "日本語を補完候補として取得しないようにする
  let g:neocomplete#keyword_patterns['default'] = '\h\w*'
  "twigはhtmlと同じに
  let g:neocomplete#keyword_patterns['twig'] = '</\?\%([[:alnum:]_:-]\+\s*\)\?\%(/\?>\)\?\|&\h\%(\w*;\)\?\|\h[[:alnum:]_-]*="\%([^"]*"\?\)\?\|\h[[:alnum:]_:-]*'

  "関数を補完するための区切り文字パターン
  if !exists('g:neocomplete#delimiter_patterns')
    let g:neocomplete#delimiter_patterns = {}
  endif
  let g:neocomplete#delimiter_patterns['php'] = ['->', '::', '\']
  let g:neocomplete#delimiter_patterns['ruby'] = ['.', '::']

  "ディクショナリ補完
  "ファイルタイプごとの辞書ファイルの場所
  let g:neocomplete#dictionary_filetype_lists = {
        \ 'default' : '',
        \ 'php' : $HOME . '/.vim/dictionary/php.dict',
        \ 'ctp' : $HOME . '/.vim/dictionary/php.dict',
        \ }

  " }}}

  " }}}
elseif neobundle#is_installed('neocomplcache')
  " ### neocomplcache {{{
  " 起動時に有効にする
  let g:neocomplcache_enable_at_startup = 1

  " ポップアップメニューで表示される候補の数。
  let g:neocomplcache_max_list=20

  " 自動補完を行う入力数を設定
  let g:neocomplcache_auto_completion_start_length = 2

  " シンタックスを最長４に設定
  let g:neocomplcache_min_syntax_length = 4
  let g:neocomplcache_enable_smart_case = 1
  let g:neocomplcache_enable_ignore_case = 1
  let g:neocomplcache_enable_camel_case_completion = 0
  let g:neocomplcache_enable_underbar_completion = 0

  "キャッシュディレクトリの場所
  "RamDiskをキャッシュディレクトリに設定
  if has('win32')
    let g:neocomplcache_temporary_dir = 'E:/.neocon'
  elseif has('macunix')
    let g:neocomplcache_temporary_dir = '~/.neocon'
  else
    let g:neocomplcache_temporary_dir = '/tmp/.neocon'
  endif

  "カーソルより後のキーワードパターンを認識。
  "h|geとなっている状態(|はカーソル)で、hogeを補完したときに後ろのキーワードを認識してho|geと補完する機能。
  "修正するときにかなり便利。
  "g:neocomplcache_next_keyword_patternsは分からないときはいじらないほうが良いです。
  if !exists('g:neocomplcache_next_keyword_patterns')
    let g:neocomplcache_next_keyword_patterns = {}
  endif

  "スニペットファイルの置き場所
  "let g:neocomplcache_snippets_dir = $HOME.'/.vim/snippets'
  let g:neocomplcache_snippets_dir = $HOME . '/.vim/bundle/neosnippet/autoload/neosnippet/snippets'
  " snippetsファイルのキーバインド（Tab)
  imap <silent> <Tab> <Plu>(neocomplcache_snippets_expand)
  smap <silent> <Tab> <Plu>(neocomplcache_snippets_expand)

  "改行で補完ウィンドウを閉じる
  inoremap <expr><CR> neocomplcache#smart_close_popup() . "\<CR>"
  "tabで補完候補の選択を行う
  inoremap <expr><TAB> pumvisible() ? "\<Down>" : "\<TAB>"
  inoremap <expr><S-TAB> pumvisible() ? "\<Up>" : "\<S-TAB>"

  " 区切りの補完を有効化
  let g:neocomplcache_enable_underbar_completion = 1
  "C-yで補完候補の確定
  inoremap <expr><C-y> neocomplcache#close_popup()
  inoremap <expr><Enter>  pumvisible() ? "\<C-Y>" : "\<Enter>"

  " 補完候補が表示されている場合は確定。そうでない場合は改行
  inoremap pumvisible() ? neocomplcache#close_popup() : "¥"

  "C-eで補完のキャンセルし、ウィンドウを閉じる。ポップアップが開いていないときはEndキー
  inoremap <expr><C-e> pumvisible() ? neocomplcache#cancel_popup() : "\<End>"
  "C-gで補完を元に戻す
  inoremap <expr><C-g> neocomplcache#undo_completion()
  "vim標準のキーワード補完を置き換える
  inoremap <expr><C-n> neocomplcache#manual_keyword_complete()
  "C-pで上キー
  inoremap <C-p> <Up>
  "補完候補の共通文字列を補完する(シェル補完のような動作)
  inoremap <expr><C-l> neocomplcache#complete_common_string()
  "スニペットを展開する。スニペットが関係しないところでは行末まで削除
  "imap <expr><C-k> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : "\<C-o>D"
  "smap <expr><C-k> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : "\<C-o>D"
  " imap <expr><C-k> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<C-o>D"
  " smap <expr><C-k> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<C-o>D"

  " Enable heavy omni completion. ruby用
  if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
  endif
  let g:neocomplcache_omni_patterns.ruby = '[^. *¥t]¥.¥w*¥|¥h¥w*::'
  au FileType ruby setlocal omnifunc=rubycomplete#Complete

  " シンタックス補完を無効に
  let g:neocomplcache_plugin_disable = {
        \ 'syntax_complete' : 1,
        \ }

  "補完するためのキーワードパターンを指定
  if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
  endif
  "日本語を補完候補として取得しないようにする
  let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
  "twigはhtmlと同じに
  let g:neocomplcache_keyword_patterns['twig'] = '</\?\%([[:alnum:]_:-]\+\s*\)\?\%(/\?>\)\?\|&\h\%(\w*;\)\?\|\h[[:alnum:]_-]*="\%([^"]*"\?\)\?\|\h[[:alnum:]_:-]*'

  "関数を補完するための区切り文字パターン
  if !exists('g:neocomplcache_delimiter_patterns')
    let g:neocomplcache_delimiter_patterns = {}
  endif
  let g:neocomplcache_delimiter_patterns['php'] = ['->', '::', '\']

  "ファイルタイプの関連付け
  if !exists('g:neocomplcache_same_filetype_lists')
    let g:neocomplcache_same_filetype_lists = {}
  endif
  let g:neocomplcache_same_filetype_lists['ctp'] = 'php'
  let g:neocomplcache_same_filetype_lists['twig'] = 'html'

  "ディクショナリ補完
  "ファイルタイプごとの辞書ファイルの場所
  let g:neocomplcache_dictionary_filetype_lists = {
        \ 'default' : '',
        \ 'php' : $HOME . '/.vim/dictionary/php.dict',
        \ 'ctp' : $HOME . '/.vim/dictionary/php.dict',
        \ }
  " }}}
endif

" 補完ウィンドウの設定
set completeopt=menuone

" }}}

" ### neosnippet {{{
let g:neosnippet#enable_snipmate_compatibility=1
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'

" Plugin key-mappings.
imap <silent><C-k> <Plug>(neosnippet_expand_or_jump)
smap <silent><C-k> <Plug>(neosnippet_expand_or_jump)
" xmap <C-k> <Plug>(neosnippet_expand_target)
" imap <C-k> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<C-o>D<C-o>l"
" smap <C-k> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<C-o>D<C-o>l"

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \: "\<TAB>"

" let s:bundle = neobundle#get('neosnippet')
" function! s:bundle.hooks.on_source(bundle)
"   " let g:neosnippet#snippets_directory = $HOME . '/.vim/snippets'
"
"   " enable ruby & rails snippet only rails file
"   function! s:RailsSnippet()
"     if exists("b:rails_root") && (&filetype == "ruby")
"       NeoSnippetSource ~/.vim/snippets/rails.snip
"     endif
"   endfunction
"
"   function! s:RSpecSnippet()
"     if (expand("%") =~ "_spec\.rb$") || (expand("%") =~ "^spec.*\.rb$")
"       NeoSnippetSource ~/.vim/snippets/rspec.snip
"     endif
"   endfunction
"
"   MyAutocmd BufEnter * call s:RailsSnippet()
"   MyAutocmd BufEnter * call s:RSpecSnippet()
" endfunction
" unlet s:bundle

MyAutocmd FileType css,scss setlocal omnifunc=csscomplete#CompleteCSS
MyAutocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
MyAutocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
MyAutocmd FileType python setlocal omnifunc=pythoncomplete#Complete
MyAutocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
MyAutocmd FileType sql setlocal omnifunc=sqlcomplete#Complete

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" }}}

" ### unite.vim {{{
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

" ### vimfiler{{{
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
  au FileType vimfiler call s:vimfiler_my_settings()
augroup END
function! s:vimfiler_my_settings()
  nmap <buffer> q <Plug>(vimfiler_exit)
  nmap <buffer> Q <Plug>(vimfiler_hide)
endfunction

" }}}

" ### vimshell {{{
nnoremap <Space>vs :VimShell<CR>

"---------------------
" 全角スペースの表示
"---------------------
function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction

if has('syntax')
  augroup ZenkakuSpace
    au!
    au ColorScheme * call ZenkakuSpace()
    au VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
  augroup END
  call ZenkakuSpace()
endif
" }}}

" ### syntastic {{{
let g:syntastic_enable_signs = 1
" エラー時にQuickfixを立ち上げる
" let g:syntastic_auto_loc_list = 1
" htmlはチェックしない
let g:syntastic_mode_map = {
      \'mode': 'active',
      \'active_file_types': ['javascript', 'ruby', 'php'],
      \'passive_filetypes': ['html']
      \}
" チェッカーの設定
let g:syntastic_php_php_args = '-l'
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_javascript_checkers = ['jshint']
let g:syntasticjavascript_jshint_conf = "~/.jshintrc"

" normal モードのとき、<Space>sc でコーディングルールをチェック
nnoremap <silent> <Space>sc :<C-u>SyntasticCheck<CR>
" normal モードのとき、<Space>st でコーディングルールのチェック/非チェックを
" 切り替え
nnoremap <silent> <Space>st :<C-u>SyntasticToggleMode<CR>

" なんでか分からないけど php コマンドのオプションを上書かないと動かなかった
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" }}}

" ### html5.vim {{{
let g:html5_event_handler_attributes_complete = 1
let g:html5_rdfa_attributes_complete = 1
let g:html5_microdata_attributes_complete = 1
let g:html5_aria_attributes_complete = 1

"}}}

" ### cake.vim {{{
" let g:cakephp_enable_fix_mode = 1
" 自動でCakePHPを設定するモードを有効に
" let g:cakephp_enable_auto_mode = 1
" バッファで開くキーバインド設定
nnoremap <Space>cc :Ccontroller
nnoremap <Space>cm :Cmodel
nnoremap <Space>cv :Cview
nnoremap <Space>cvw :Ccontrollerview
nnoremap <Space>cs :Cshell
nnoremap <Space>ct :Ctask
nnoremap <Space>ccf :Cconfig
nnoremap <Space>ccp :Ccomponent
nnoremap <Space>cl :Clog
"}}}

" ### javascript-libraries-syntax.vim {{{
" 機能をオンにする
let g:used_javascript_libs = 'jquery'
" }}}

" ### simple-javascript-indenter {{{
" 機能をオンにする
let g:SimpleJsIndenter_BriefMode = 1
" }}}

" ### transparency {{{
function! s:toggle_transparence()
  if &transparency == 20
    set transparency=0
  else
    set transparency=20
  endif
endfunction
nnoremap <silent> <Space>oT :<C-u>call <SID>toggle_transparence()<CR>
" }}}

" ### vim-gitgutter {{{
let g:gitgutter_max_signs = 999
nnoremap <silent> ,gg :<C-u>GitGutterToggle<CR>
nnoremap <silent> ,gh :<C-u>GitGutterLineHighlightsToggle<CR>
" }}}

" ### vim-lightline {{{
let g:lightline = {
        \ 'colorscheme': 'landscape',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [
        \     ['mode', 'paste'],
        \     ['fugitive', 'gitgutter', 'filename'],
        \   ],
        \   'right': [
        \     ['lineinfo', 'syntastic'],
        \     ['percent'],
        \     ['charcode', 'fileformat', 'fileencoding', 'filetype'],
        \   ]
        \ },
        \ 'component_function': {
        \   'modified': 'MyModified',
        \   'readonly': 'MyReadonly',
        \   'fugitive': 'MyFugitive',
        \   'filename': 'MyFilename',
        \   'fileformat': 'MyFileformat',
        \   'filetype': 'MyFiletype',
        \   'fileencoding': 'MyFileencoding',
        \   'mode': 'MyMode',
        \   'syntastic': 'SyntasticStatuslineFlag',
        \   'charcode': 'MyCharCode',
        \   'gitgutter': 'MyGitGutter',
        \ },
        \ 'separator': {'left': '⮀', 'right': '⮂'},
        \ 'subseparator': {'left': '⮁', 'right': '⮃'}
        \ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &ro ? '⭤' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? substitute(b:vimshell.current_dir,expand('~'),'~','') :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
      let _ = fugitive#head()
      return strlen(_) ? '⭠ '._ : ''
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth('.') > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth('.') > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth('.') > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth('.') > 60 ? lightline#mode() : ''
endfunction

function! MyGitGutter()
  if ! exists('*GitGutterGetHunkSummary')
        \ || ! get(g:, 'gitgutter_enabled', 0)
        \ || winwidth('.') <= 90
    return ''
  endif
  let symbols = [
        \ g:gitgutter_sign_added . ' ',
        \ g:gitgutter_sign_modified . ' ',
        \ g:gitgutter_sign_removed . ' '
        \ ]
  let hunks = GitGutterGetHunkSummary()
  let ret = []
  for i in [0, 1, 2]
    if hunks[i] > 0
      call add(ret, symbols[i] . hunks[i])
    endif
  endfor
  return join(ret, ' ')
endfunction

" https://github.com/Lokaltog/vim-powerline/blob/develop/autoload/Powerline/Functions.vim
function! MyCharCode()
  if winwidth('.') <= 70
    return ''
  endif

  " Get the output of :ascii
  redir => ascii
  silent! ascii
  redir END

  if match(ascii, 'NUL') != -1
    return 'NUL'
  endif

  " Zero pad hex values
  let nrformat = '0x%02x'

  let encoding = (&fenc == '' ? &enc : &fenc)

  if encoding == 'utf-8'
    " Zero pad with 4 zeroes in unicode files
    let nrformat = '0x%04x'
  endif

  " Get the character and the numeric value from the return value of :ascii
  " This matches the two first pieces of the return value, e.g.
  " "<F>  70" => char: 'F', nr: '70'
  let [str, char, nr; rest] = matchlist(ascii, '\v\<(.{-1,})\>\s*([0-9]+)')

  " Format the numeric value
  let nr = printf(nrformat, nr)

  return "'". char ."' ". nr
endfunction

" }}}

" ### smartinput {{{
" smartinput-endwise用の設定
" call smartinput_endwise#define_default_rules()

" ()内でのスペースの入力／削除を補助
call smartinput#map_to_trigger('i', '<Space>', '<Space>', '<Space>')
call smartinput#define_rule({
            \   'at'    : '(\%#)',
            \   'char'  : '<Space>',
            \   'input' : '<Space><Space><Left>',
            \   })

call smartinput#define_rule({
            \   'at'    : '( \%# )',
            \   'char'  : '<BS>',
            \   'input' : '<Del><BS>',
            \   })

" Rubyで文字列内展開やブロック引数do ||の補助
call smartinput#map_to_trigger('i', '#', '#', '#')
call smartinput#define_rule({
            \   'at'       : '\%#',
            \   'char'     : '#',
            \   'input'    : '#{}<Left>',
            \   'filetype' : ['ruby'],
            \   'syntax'   : ['Constant', 'Special'],
            \   })

call smartinput#map_to_trigger('i', '<Bar>', '<Bar>', '<Bar>')
call smartinput#define_rule({
            \   'at' : '\({\|\<do\>\)\s*\%#',
            \   'char' : '<Bar>',
            \   'input' : '<Bar><Bar><Left>',
            \   'filetype' : ['ruby'],
            \    })

" http://blog.supermomonga.com/articles/vim/share-cr-map-with-multiple-plugins.html
if neobundle#tap('vim-smartinput')
  call neobundle#config({
        \   'autoload' : {
        \     'insert' : 1
        \   }
        \ })

  function! neobundle#tapped.hooks.on_post_source(bundle)
    call smartinput_endwise#define_default_rules()
  endfunction

  call neobundle#untap()
endif

if neobundle#tap('vim-smartinput-endwise')
  function! neobundle#tapped.hooks.on_post_source(bundle)
    " neosnippet and neocomplete compatible
    call smartinput#map_to_trigger('i', '<Plug>(vimrc_cr)', '<Enter>', '<Enter>')
    imap <expr><CR> !pumvisible() ? "\<Plug>(vimrc_cr)" :
          \ neosnippet#expandable() ? "\<Plug>(neosnippet_expand)" :
          \ neocomplete#close_popup()
  endfunction
  call neobundle#untap()
endif
" }}}

" ### vim-rails {{{
" 有効化
let g:rails_default_file='config/database.yml'
let g:rails_level = 4
let g:rails_mappings=1
let g:rails_modelines=0
" let g:rails_some_option = 1
" let g:rails_statusline = 1
" let g:rails_subversion=0
" let g:rails_syntax = 1
" let g:rails_url='http://localhost:3000'
" let g:rails_ctags_arguments='--languages=-javascript'
" let g:rails_ctags_arguments = ''
function! SetUpRailsSetting()
  nnoremap <buffer><Space>r :R<CR>
  nnoremap <buffer><Space>a :A<CR>
  nnoremap <buffer><Space>m :Rmodel<Space>
  nnoremap <buffer><Space>c :Rcontroller<Space>
  nnoremap <buffer><Space>v :Rview<Space>
  nnoremap <buffer><Space>p :Rpreview<CR>
endfunction
 
aug MyAutoCmd
  au User Rails call SetUpRailsSetting()
aug END
 
aug RailsDictSetting
  au!
aug END

autocmd User Rails.view*                 NeoSnippetSource ~/.vim/snippet/ruby.rails.view.snip
autocmd User Rails.controller*           NeoSnippetSource ~/.vim/snippet/ruby.rails.controller.snip
autocmd User Rails/db/migrate/*          NeoSnippetSource ~/.vim/snippet/ruby.rails.migrate.snip
autocmd User Rails/config/routes.rb      NeoSnippetSource ~/.vim/snippet/ruby.rails.route.snip

" }}}

" ### switch.vim {{{
" https://gist.github.com/alpaca-tc/6696152
function! s:separate_defenition_to_each_filetypes(ft_dictionary) "{{{
  let result = {}

  for [filetypes, value] in items(a:ft_dictionary)
    for ft in split(filetypes, ",")
      if !has_key(result, ft)
        let result[ft] = []
      endif

      call extend(result[ft], copy(value))
    endfor
  endfor

  return result
endfunction "}}}

nnoremap ! :Switch<CR>
let s:switch_definition = {
      \ '*': [
      \   ['is', 'are']
      \ ],
      \ 'ruby,eruby,haml' : [
      \   ['if', 'unless'],
      \   ['while', 'until'],
      \   ['.blank?', '.present?'],
      \   ['include', 'extend'],
      \   ['class', 'module'],
      \   ['.inject', '.delete_if'],
      \   ['.map', '.map!'],
      \   ['attr_accessor', 'attr_reader', 'attr_writer'],
      \ ],
      \ 'Gemfile,Berksfile' : [
      \   ['=', '<', '<=', '>', '>=', '~>'],
      \ ],
      \ 'ruby.application_template' : [
      \   ['yes?', 'no?'],
      \   ['lib', 'initializer', 'file', 'vendor', 'rakefile'],
      \   ['controller', 'model', 'view', 'migration', 'scaffold'],
      \ ],
      \ 'erb,html,php' : [
      \   { '<!--\([a-zA-Z0-9 /]\+\)--></\(div\|ul\|li\|a\)>' : '</\2><!--\1-->' },
      \ ],
      \ 'rails' : [
      \   [100, ':continue', ':information'],
      \   [101, ':switching_protocols'],
      \   [102, ':processing'],
      \   [200, ':ok', ':success'],
      \   [201, ':created'],
      \   [202, ':accepted'],
      \   [203, ':non_authoritative_information'],
      \   [204, ':no_content'],
      \   [205, ':reset_content'],
      \   [206, ':partial_content'],
      \   [207, ':multi_status'],
      \   [208, ':already_reported'],
      \   [226, ':im_used'],
      \   [300, ':multiple_choices'],
      \   [301, ':moved_permanently'],
      \   [302, ':found'],
      \   [303, ':see_other'],
      \   [304, ':not_modified'],
      \   [305, ':use_proxy'],
      \   [306, ':reserved'],
      \   [307, ':temporary_redirect'],
      \   [308, ':permanent_redirect'],
      \   [400, ':bad_request'],
      \   [401, ':unauthorized'],
      \   [402, ':payment_required'],
      \   [403, ':forbidden'],
      \   [404, ':not_found'],
      \   [405, ':method_not_allowed'],
      \   [406, ':not_acceptable'],
      \   [407, ':proxy_authentication_required'],
      \   [408, ':request_timeout'],
      \   [409, ':conflict'],
      \   [410, ':gone'],
      \   [411, ':length_required'],
      \   [412, ':precondition_failed'],
      \   [413, ':request_entity_too_large'],
      \   [414, ':request_uri_too_long'],
      \   [415, ':unsupported_media_type'],
      \   [416, ':requested_range_not_satisfiable'],
      \   [417, ':expectation_failed'],
      \   [422, ':unprocessable_entity'],
      \   [423, ':precondition_required'],
      \   [424, ':too_many_requests'],
      \   [426, ':request_header_fields_too_large'],
      \   [500, ':internal_server_error'],
      \   [501, ':not_implemented'],
      \   [502, ':bad_gateway'],
      \   [503, ':service_unavailable'],
      \   [504, ':gateway_timeout'],
      \   [505, ':http_version_not_supported'],
      \   [506, ':variant_also_negotiates'],
      \   [507, ':insufficient_storage'],
      \   [508, ':loop_detected'],
      \   [510, ':not_extended'],
      \   [511, ':network_authentication_required'],
      \ ],
      \ 'rspec': [
      \   ['describe', 'context', 'specific', 'example'],
      \   ['before', 'after'],
      \   ['be_true', 'be_false'],
      \   ['get', 'post', 'put', 'delete'],
      \   ['==', 'eql', 'equal'],
      \   { '\.should_not': '\.should' },
      \   ['\.to_not', '\.to'],
      \   { '\([^. ]\+\)\.should\(_not\|\)': 'expect(\1)\.to\2' },
      \   { 'expect(\([^. ]\+\))\.to\(_not\|\)': '\1.should\2' },
      \ ],
      \ 'markdown' : [
      \   ['[ ]', '[x]']
      \ ]
      \ }

let s:switch_definition = s:separate_defenition_to_each_filetypes(s:switch_definition)
function! s:define_switch_mappings() "{{{
  if exists('b:switch_custom_definitions')
    unlet b:switch_custom_definitions
  endif

  let dictionary = []
  for filetype in split(&ft, '\.')
    if has_key(s:switch_definition, filetype)
      let dictionary = extend(dictionary, s:switch_definition[filetype])
    endif
  endfor

  if exists('b:rails_root')
    let dictionary = extend(dictionary, s:switch_definition['rails'])
  endif

  if has_key(s:switch_definition, '*')
    let dictionary = extend(dictionary, s:switch_definition['*'])
  endif

  " if !empty('dictionary')
  "   call alpaca#let_b('switch_custom_definitions', dictionary)
  " endif
endfunction "}}}

augroup SwitchSetting
  autocmd!
  autocmd Filetype * if !empty(split(&ft, '\.')) | call <SID>define_switch_mappings() | endif
augroup END
" }}}

" }}} plugin end
" vim: foldmethod=marker
" vim: foldcolumn=3
" vim: foldlevel=0
