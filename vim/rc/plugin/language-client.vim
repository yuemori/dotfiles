" let g:LanguageClient_serverCommands = {
"     \ 'elixir': [$HOME.'/ghq/src/github.com/elixir-lsp/elixir-ls/rel/language_server.sh'],
"     \ }
"
" if executable($HOME.'/ghq/src/github.com/elixir-lsp/elixir-ls/rel/language_server.sh')
"   au User lsp_setup call lsp#register_server({
"         \ 'name': 'elixir-ls',
"         \ 'cmd': {server_info->[&shell, &shellcmdflag, $HOME.'/ghq/src/github.com/elixir-lsp/elixir-ls/rel/language_server.sh']},
"         \ 'whitelist': ['elixir'],
"         \ 'workspace_config': {'elixirLS': {'dialyzerEnabled': v:false}},
"         \ })
" endif
