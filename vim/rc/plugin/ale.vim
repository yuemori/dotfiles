let g:ale_linters = {
\ 'cs': ['OmniSharp'],
\ 'go': ['gometalinter', 'go build'], 
\ 'ruby': ['rubocop'], 
\}

let g:ale_fixers = {
\ 'ruby': ['rubocop']
\}

let g:ale_fix_on_save = 0
