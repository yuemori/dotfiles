"-------------------------------------------------------------------------------
" omnisharp
"-------------------------------------------------------------------------------
let g:OmniSharp_selector_ui = 'unite'
let g:syntastic_cs_checkers = ['syntax', 'semantic', 'issues']

if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

let g:neocomplete#sources#omni#input_patterns.cs = '.*[^=\);]'

augroup omnisharp_commands
  autocmd!
  autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
  autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck
  autocmd BufWritePost *.cs call OmniSharp#AddToProject()
  autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

  autocmd FileType cs nnoremap <Space>cg :OmniSharpGotoDefinition<cr>
  autocmd FileType cs nnoremap <Space>cr :OmniSharpRename<cr>
  autocmd FileType cs nnoremap <Space>cf :OmniSharpCodeFormat<cr>
  autocmd FileType cs nnoremap <Space>cu :OmniSharpFindUsages<cr>
  autocmd FileType cs nnoremap <Space>fs :OmniSharpFindSymbol<cr>
  "navigate up by method/property/field
  autocmd FileType cs nnoremap <C-K> :OmniSharpNavigateUp<cr>
  "navigate down by method/property/field
  autocmd FileType cs nnoremap <C-J> :OmniSharpNavigateDown<cr>
augroup END
