" noremap <C-]> :call LanguageClient#textDocument_definition()<CR>
noremap <C-T> <C-O>

let g:goimports_simplify = 1  " 保存時に`gofmt -s`を実行する
