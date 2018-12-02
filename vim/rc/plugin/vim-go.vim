let g:go_fmt_command = "goimports"
let g:go_metalinter_autosave = 1
let g:go_metalinter_enabled = ['vet', 'golint']
let g:go_metalinter_autosave_enabled = ['vet', 'golint']
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_gocode_unimported_packages = 1
set completeopt-=preview

nnoremap K :GoDoc
autocmd FileType go nmap <Space>gb  <Plug>(go-build)
autocmd FileType go nmap <Space>gt  <Plug>(go-test)
