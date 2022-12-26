"-------------------------------------------------------------------------------
" ファイルタイプ FileType
"-------------------------------------------------------------------------------
filetype indent on
filetype plugin on
" HTML/CSS用設定
au FileType html setlocal noexpandtab ts=2 sw=2 fenc=utf-8
au FileType css setlocal expandtab ts=4 sw=2 fenc=utf-8

" PHP用設定
" PHPファイル用タブストップ設定
au FileType php setlocal expandtab ts=4 sw=4 fenc=utf-8
" phpファイルでhtmlスニペットを有効にする
" au BufNewFile,BufRead *.php set filetype=html.php
" ctpファイルをphpとして関連付ける
au BufNewFile,BufRead *.ctp set filetype=html.php
" twigファイルを認識させる
au BufNewFile,BufRead *.twig set filetype=html.twig

" coffeescript用設定
" coffeescriptファイルを認識させる
au FileType coffee setlocal expandtab ts=2 sts=2 sw=2 et
au BufNewFile,BufRead,BufReadPre *.coffee set filetype=coffee

" Ruby用設定
" YAMLファイル用タブストップ設定
au FileType yaml setlocal expandtab ts=2 sw=2 fenc=utf-8
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
au BufNewFile,BufRead *.yaml set filetype=yaml
" erbファイルでhtmlスニペットを有効にする
au BufNewFile,BufRead *.erb set filetype=eruby.html
" slimファイルを認識させる
au FileType slim setlocal expandtab ts=2 sts=2 sw=2 et
au BufNewFile,BufRead,BufReadPre *.slim set filetype=slim

" markdown用設定
au BufNewFile,BufRead *.md set filetype=markdown

au FileType cs setlocal expandtab ts=4 sts=4 sw=4 et
au FileType csharp setlocal expandtab ts=4 sts=4 sw=4 et

au BufNewFile,BufRead *.tpl set filetype=mustache

au BufNewFile,BufRead *.tf set filetype=terraform
au BufNewFile,BufRead *.tf setlocal ts=2 sw=2 sts=2 et
aut FileType terraform setlocal ts=2 sw=2 sts=2 et

au BufNewFile,BufRead *.ex set filetype=elixir

let g:ruby_host_prog = '/Users/yasutomo.uemori/.rbenv/shims/neovim-ruby-host'
