"-------------------------------------------------------------------------------
" denite.vim
"-------------------------------------------------------------------------------

call denite#custom#var('file_rec', 'command',
  \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'final_opts', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'default_opts', ['--no-color', '--nogroup'])

" Change default prompt
call denite#custom#option('default', 'prompt', "( '_')?<")

" Change ignore_globs
call denite#custom#filter('matcher_ignore_globs', 'ignore_globs', [ '.git/'])

nnoremap <Space>um :<C-u>Denite file_mru
nnoremap <Space>uf :<C-u>DeniteBufferDir<CR>
nnoremap <Space>urm :<C-u>Denite unite:rails/model<CR>
nnoremap <Space>urs :<C-u>Denite unite:rails/service<CR>
nnoremap <Space>urt :<C-u>Denite unite:rails/spec<CR>
