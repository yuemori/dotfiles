"-------------------------------------------------------------------------------
" vim-rails
"-------------------------------------------------------------------------------
" 有効化
let g:rails_default_file='config/database.yml'
let g:rails_level = 4
let g:rails_mappings=1
let g:rails_modelines=0
let g:rails_projections = {
  \ "app/services/*_service.rb": {
  \   "command": "service",
  \   "test": "spec/services/%s_spec.rb",
  \   "affinity": "model",
  \   "related": "app/generates/{}.rb",
  \ },
  \ "app/generates/v1/*.rb": {
  \   "command": "rpc",
  \   "test": "spec/services/v1/%s_spec.rb",
  \   "affinity": "model",
  \   "alternate": "app/services/v1/{}_service.rb",
  \ },
  \ "app/generates/type/*.rb": {
  \   "command": "type",
  \   "affinity": "model",
  \   "alternate": "spec/factories/type/%i.rb",
  \ },
  \ "app/generates/enum/*.rb": {
  \   "command": "enum",
  \   "affinity": "model",
  \ },
  \ "app/controllers/*_controller.rb": {
  \   "command": "controller",
  \   "affinity": "controller",
  \   "test": "spec/requests/%s_spec.rb",
  \   "related": "app/services/%s_service.rb",
  \ },
  \ "spec/requests/*_spec.rb": {
  \   "alternate": "app/controllers/%s_controller.rb",
  \   "related": "app/services/%s_service.rb"
  \ },
  \ "spec/factories/*.rb": {
  \   "command": "factory",
  \   "affinity": "model",
  \   "alternate": "app/models/%i.rb",
  \   "related": "spec/models/%i_spec.rb"
  \ },
  \ "spec/factories/type/*.rb": {
  \   "command": "factory",
  \   "affinity": "model",
  \   "alternate": "app/generates/type/%i.rb",
  \ },
  \ "app/validators/*.rb": {
  \   "command": "validator",
  \   "alternate": "spec/validators/%s_spec.rb",
  \ },
  \ "db/schema/*.schema": {
  \   "command": "schema",
  \ }
\}

function! SetUpRailsSetting()
  nnoremap <buffer><Space>r :R<CR>
  nnoremap <buffer><Space>a :A<CR>
  nnoremap <buffer><Space>m :Rmodel<Space>
  nnoremap <buffer><Space>c :Rcontroller<Space>
  nnoremap <buffer><Space>v :Rview<Space>
  nnoremap <buffer><Space>p :Rpreview<CR>
endfunction
 
aug MyAutoCmd
  au User Rails call SetUpRailsSetting()
aug END
 
aug RailsDictSetting
  au!
aug END

autocmd User Rails.view*                 NeoSnippetSource ~/.vim/snippet/ruby.rails.view.snip
autocmd User Rails.controller*           NeoSnippetSource ~/.vim/snippet/ruby.rails.controller.snip
autocmd User Rails/db/migrate/*          NeoSnippetSource ~/.vim/snippet/ruby.rails.migrate.snip
autocmd User Rails/config/routes.rb      NeoSnippetSource ~/.vim/snippet/ruby.rails.route.snip
autocmd BufRead,bufNewFile *.erb set filetype=eruby
