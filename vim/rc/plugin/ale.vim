" if executable('eslint_d')
"   let g:ale_javascript_eslint_use_global = 1
"   let g:ale_javascript_eslint_executable = 'eslint_d'
" endif

let g:ale_linters_explicit = 1
let g:ale_linters = {
  \   'javascript': ['eslint'],
  \   'javascriptreact': ['eslint'],
  \   'typescript': ['eslint'],
  \   'typescriptreact': ['eslint'],
  \   'vue': ['eslint']
  \ }

" let g:ale_linters = {
" \   'javascript': ['eslint'],
" \   'javascriptreact': ['eslint'],
" \   'typescript': ['eslint'],
" \   'typescriptreact': ['eslint'],
" \}

let g:ale_fixers = {
\ '*': ['remove_trailing_lines', 'trim_whitespace'],
\ 'javascript': ['prettier'],
\ 'javascriptreact': ['prettier'],
\ 'typescript': ['prettier'],
\ 'typescriptreact': ['prettier'],
\ }

let g:ale_fix_on_save = 1
"
" autocmd VimEnter,SourcePost * :let b:ale_fixers = ['prettier']
" autocmd VimEnter,SourcePost * :let b:ale_linters = ['eslint']
