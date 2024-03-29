"-------------------------------------------------------------------------------
" dein.vim
"-------------------------------------------------------------------------------
" dein settings {{{
if &compatible
  set nocompatible
endif

set ttimeout
set ttimeoutlen=100

" dein.vimのディレクトリ
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

execute 'set runtimepath^=' . s:dein_repo_dir

if dein#load_state(expand('~/.cache/plugins2'))
  call dein#begin(expand('~/.cache/plugins2'))
  let s:rc_dir = expand('<sfile>:h')
  let s:toml = resolve(s:rc_dir . '/dein.toml')
  let s:lazy_toml = resolve(s:rc_dir . '/dein_lazy.toml')
  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

if !has('vim_starting') && dein#check_install()
  " Installation check.
  call dein#install()
endif

" }}}
