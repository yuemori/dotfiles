" let test#strategy = "neovim"
let test#strategy = "asyncrun_background_term"
let g:asyncrun_open = 8
" let test#neovim#term_position = "vert"

nnoremap <Space>tf :<C-u>TestFile<CR>
nnoremap <Space>tn :<C-u>TestNearest<CR>
nnoremap <Space>tv :<C-u>TestVisit<CR>
nnoremap <Space>tl :<C-u>TestLast<CR>
nnoremap <Space>ts :<C-u>TestSuite<CR>
