"-------------------------------------------------------------------------------
" dash
" see: http://qiita.com/yuyuchu3333/items/292e99a521a9653e75fb
"-------------------------------------------------------------------------------
function! s:dash(...)
  let ft = &filetype
  if &filetype == 'python'
    let ft = ft.'2'
  endif
  let ft = ft.':'
  let word = len(a:000) == 0 ? input('Dash search: ', ft.expand('<cword>')) : ft.join(a:000, ' ')
  call system(printf("open dash://'%s'", word))
endfunction
command! -nargs=* Dash call <SID>dash(<f-args>)

au User Rails nnoremap <buffer><C-K><C-K> :Dash rails:<C-R><C-W><CR>
