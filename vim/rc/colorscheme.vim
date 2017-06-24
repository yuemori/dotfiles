"-------------------------------------------------------------------------------
" カラースキーマ ColorScheme
"-------------------------------------------------------------------------------

if has('nvim')
  " colorscheme railscasts
  colorscheme Tomorrow-Night-Bright
" transparency: https://github.com/vim/vim/issues/981
  hi! Normal ctermbg=NONE guibg=NONE
  hi! NonText ctermbg=NONE guibg=NONE
  set notermguicolors
  set termguicolors
else
  set t_Co=16
  colorscheme desert
endif
