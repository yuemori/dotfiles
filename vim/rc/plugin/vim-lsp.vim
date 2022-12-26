
"  asynccomplete.vim
"--------------------------------
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_auto_completeopt = 0
let g:asyncomplete_popup_delay = 200

let g:lsp_hover_ui = 'float'
let g:lsp_preview_float = 1
let g:lsp_document_code_action_signs_enabled = 1
let g:lsp_document_code_action_signs_delay = 200
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_settings_filetype_go = ['gopls', 'golangci-lint-langserver']

let g:lsp_diagnostics_signs_priority_map = {
        \'LspError': 20,
        \'LspWarning': 20,
        \'LspInformation': 20,
        \'LspHint': 20,
        \}

function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  " if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
  setlocal omnifunc=lsp#complete

  nmap <buffer><Space>ld <plug>(lsp-document-symbol)
  nmap <buffer><Space>lw <plug>(lsp-workspace-symbol)
  nmap <buffer><Space>le <plug>(lsp-document-diagnostics)
  nmap <buffer><Space>ll <plug>(lsp-definition)
  nmap <buffer><Space>lr <plug>(lsp-references)
  nmap <buffer><Space>li <plug>(lsp-implementation)
  nmap <buffer><Space>ln <plug>(lsp-nename)
  nmap <buffer><Space>en <plug>(lsp-next-error)
  nmap <buffer><Space>ep <plug>(lsp-previous-error)
  nmap <buffer><Space>lc <plug>(lsp-code-lens)
  nmap <buffer><Space>la <plug>(lsp-code-action)
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
