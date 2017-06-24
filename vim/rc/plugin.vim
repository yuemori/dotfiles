"-------------------------------------------------------------------------------
" プラグイン設定 Plugin Settings
"-------------------------------------------------------------------------------
let s:plugin_dir = expand('<sfile>:h') . '/plugin'

function! s:source_plugin(name) abort
  execute 'source' resolve(s:plugin_dir. '/' . a:name . '.vim')
endfunction

call s:source_plugin('agit')
call s:source_plugin('ag')
call s:source_plugin('dash')
call s:source_plugin('fugitive')
call s:source_plugin('fzf')
call s:source_plugin('gitgutter')
call s:source_plugin('omnisharp')
call s:source_plugin('tcomment')
call s:source_plugin('unite')
call s:source_plugin('unite-rails')
call s:source_plugin('vim-lightline')
call s:source_plugin('vim-rails')
call s:source_plugin('vimfiler')
call s:source_plugin('zenkaku')

if has('nvim')
 let g:deoplete#enable_at_startup = 1
endif
