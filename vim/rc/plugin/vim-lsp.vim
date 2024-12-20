
"  vim-lsp
"--------------------------------

" let g:lsp_log_verbose = 1
" let g:lsp_log_file = expand('~/vim-lsp.log')
let g:lsp_hover_ui = 'float'

let g:lsp_preview_float = 1
" let g:lsp_preview_keep_focus = 1
" let g:lsp_preview_autoclose = 1

" let g:lsp_diagnostics_echo_cursor = 1
" let g:lsp_diagnostics_echo_delay = 10
"
" let g:lsp_diagnostics_float_cursor = 1
" let g:lsp_diagnostics_float_delay = 100

let g:lsp_document_code_action_signs_enabled = 1
let g:lsp_document_code_action_signs_delay = 200
let g:lsp_diagnostics_enabled = 1
let g:lsp_semantic_enabled = 1
" let g:lsp_work_done_progress_enabled = 1
let g:lsp_settings_filetype_go = ['gopls', 'golangci-lint-langserver']

let g:lsp_diagnostics_highlights_enabled = 1
let g:lsp_diagnostics_highlights_delay = 10
let g:lsp_diagnostics_highlights_insert_mode_enabled = 1

let g:lsp_diagnostics_signs_enabled = 1
let g:lsp_diagnostics_signs_delay = 10
let g:lsp_diagnostics_signs_insert_mode_enabled = 1

" let g:lsp_diagnostics_virtual_text_enabled = 1
" let g:lsp_diagnostics_virtual_text_delay = 10

let g:lsp_completion_documentation_delay = 40
let g:lsp_document_highlight_delay = 20

let g:lsp_fold_enabled = 0

let g:lsp_diagnostics_signs_priority_map = {
        \'LspError': 20,
        \'LspWarning': 20,
        \'LspInformation': 20,
        \'LspHint': 20,
        \}

function! s:on_lsp_buffer_enabled() abort
  setlocal signcolumn=yes
  " if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
  setlocal omnifunc=lsp#complete

  nmap <buffer><Space>ld <plug>(lsp-document-diagnostics)
  nmap <buffer><Space>ll <plug>(lsp-definition)
  nmap <buffer><Space>lr <plug>(lsp-references)
  nmap <buffer><Space>li <plug>(lsp-implementation)
  nmap <buffer><Space>ln :<C-u>LspRename<CR>
  nmap <buffer><Space>en <plug>(lsp-next-error)
  nmap <buffer><Space>ep <plug>(lsp-previous-error)
  nmap <buffer><Space>lh <plug>(lsp-hover)

  let g:lsp_format_sync_timeout = 1000
  autocmd BufWritePre *.go call execute(['LspCodeActionSync source.organizeImports', 'LspDocumentFormatSync'])
endfunction

augroup lsp_install
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

let g:lsp_settings = {}
let g:lsp_settings['gopls'] = {
  \  'workspace_config': {
  \    'usePlaceholders': v:true,
  \    'gofumpt': v:true,
  \    'experimentalWorkspaceModule': v:true,
  \  },
  \  'initialization_options': {
  \    'usePlaceholders': v:true,
  \    'gofumpt': v:true,
  \    'experimentalWorkspaceModule': v:true,
  \  },
  \}

let g:lsp_settings['typeprof'] = {
  \ 'disabled': 1,
  \}

let g:lsp_settings['golangci-lint-langserver'] = {
  \  'initialization_options': {
  \    'command': ['golangci-lint', 'run',
  \        '--enable-all',
  \        '--fast',
  \        '--disable', 'lll',
  \        '--disable', 'wsl',
  \        '--disable', 'gochecknoglobals',
  \        '--disable', 'gci',
  \        '--disable', 'gofumpt',
  \        '--out-format', 'json',
  \        '--max-issues-per-linter', '0',
  \        '--max-same-issues', '0',
  \    ],
  \  },
  \}
