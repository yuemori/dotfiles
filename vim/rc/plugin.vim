"-------------------------------------------------------------------------------
" プラグイン設定 Plugin Settings
"-------------------------------------------------------------------------------
let s:plugin_dir = expand('<sfile>:h') . '/plugin'

function! s:source_plugin(name) abort
  execute 'source' resolve(s:plugin_dir. '/' . a:name . '.vim')
endfunction

" call s:source_plugin('ale')
call s:source_plugin('agit')
call s:source_plugin('terraform')
call s:source_plugin('ag')
" call s:source_plugin('dash')
call s:source_plugin('fugitive')
call s:source_plugin('fzf')
call s:source_plugin('gitgutter')
call s:source_plugin('omnisharp')
call s:source_plugin('smartchr')
call s:source_plugin('tcomment')
call s:source_plugin('unite')
call s:source_plugin('unite-rails')
call s:source_plugin('vim-lightline')
call s:source_plugin('vim-rails')
call s:source_plugin('vimfiler')
call s:source_plugin('vim-indent-guides')
call s:source_plugin('zenkaku')
call s:source_plugin('vim-go')
call s:source_plugin('neosnippet')
call s:source_plugin('golang')
call s:source_plugin('elixir')
call s:source_plugin('language-client')
call s:source_plugin('vim-test')
call s:source_plugin('vim-lsp')

if !has('nvim')
  call dein#add('roxma/nvim-yarp')
  call dein#add('roxma/vim-hug-neovim-rpc')
endif
let g:deoplete#enable_at_startup = 1
