"-------------------------------------------------------------------------------
" neocomplecache
"-------------------------------------------------------------------------------
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
