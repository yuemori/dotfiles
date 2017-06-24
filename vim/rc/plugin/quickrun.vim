"-------------------------------------------------------------------------------
" QuickRun
"-------------------------------------------------------------------------------
" QuickRunの設定オブジェクトをつくる
let g:quickrun_config = {}
 
" すべてのファイルタイプで vimproc をつかってコマンドを実行する
let g:quickrun_config['_'] = {
      \ 'runner': 'vimproc',
      \       'runner/vimproc/updatetime' : 100
      \ }
