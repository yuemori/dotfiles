let g:ale_linters = {
\   'javascript': ['eslint'],
\   'javascriptreact': ['eslint'],
\   'typescript': ['eslint'],
\   'typescriptreact': ['eslint'],
\}

let g:ale_fixers = {
\ 'javascript': ['eslint','prettier'],
\ 'javascriptreact': ['eslint','prettier'],
\ 'typescript': ['eslint','prettier'],
\ 'typescriptreact': ['eslint','prettier'],
  }

let g:ale_fix_on_save = 1

autocmd VimEnter,SourcePost * :let b:ale_fixers = ['prettier', 'eslint']
autocmd VimEnter,SourcePost * :let b:ale_linters = ['eslint']
