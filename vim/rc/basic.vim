"-------------------------------------------------------------------------------
" 基本設定 Basics
"-------------------------------------------------------------------------------
set vb t_vb=                      " ビープを鳴らさない
set backspace=indent,eol,start    " バックスペースでなんでも消せるように
set pastetoggle=<F10>             " F10でpasteモードをトグルする
set iminsert=0                    " insertモードで自動的にIMEがオンになるのを防ぐ
set nomodeline                    " モードラインを有効にする
set modelines=0                   " ３行目までをモードラインとして検索
set nobackup                      " バックアップファイルは使わない
set noswapfile                    " スワップファイルは使わない
"set noundofile                    " アンドゥファイルは使わない
set hidden                        " 編集中でも他のファイルを開けるように
set confirm                       " 保存されていないファイルがあるときは終了前に確認
set autoread                      " 外部でファイルに変更がある場合は読み直す
set shellslash                    " セパレーターにスラッシュを利用可能に
set backupskip=/tmp/*,/private/tmp/* " OSXでcrontabを使えるようにするため、backupを作らないようにする
set synmaxcol=200                 " 1行が長くても全部解析しないようにする
set ambiwidth=double

if has('nvim')
  set clipboard+=unnamedplus " クリップボードをvim以外と共有
else
  " ターミナルでマウスを有効にする
  if has('mouse')
    set mouse=a
    set ttymouse=xterm2
  endif
  set clipboard=unnamed,autoselect  " クリップボードをvim以外と共有
endif

" matchitを有効化
if !exists('loaded_matchit')
  runtime macros/matchit.vim
endif

augroup quickfixopen
  autocmd!
  autocmd QuickfixCmdPost make cw
augroup END
