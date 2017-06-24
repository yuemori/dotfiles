"-------------------------------------------------------------------------------
" syntastic
"-------------------------------------------------------------------------------
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
