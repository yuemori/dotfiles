"-------------------------------------------------------------------------------
" キーマッピング Mapping
"-------------------------------------------------------------------------------
" 誤動作すると困るキーの無効
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
" exモードの無効化
nnoremap Q <Nop>
" 行移動を直感的に
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
" pasteモードのキーマッピング
nnoremap <F10> :set paste!<CR>:set paste?<CR>
" インサートモードでjjとkkをEscにマッピング
inoremap <silent> jj <ESC>
inoremap <silent> kk <ESC>
" インサートモードを抜けると自動的にIMをオフにする
" noremap <silent> <ESC> <ESC>:set iminsert=0<CR>
" Ctrl+Spaceでキーワード補完を展開
" inoremap <C-space> <C-p>
" ノーマルモードで行頭に移動
nnoremap <Space>h ^
" ノーマルモードで行末に移動
nnoremap <Space>l $
" 単語検索
nnoremap <Space>/ *

" insertモードでもhjklで移動
" inoremap <C-h> <Left>
" inoremap <C-l> <Right>
" inoremap <C-j> <Down>
" inoremap <C-k> <Up>

"挿入モードのキーバインドをemacs風に
inoremap <C-a> <Home>
" inoremap <C-e> <End>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
" inoremap <C-n> <Down>
" inoremap <C-p> <Up>
inoremap <C-h> <BS>
inoremap <C-d> <Del>
" inoremap <C-k> <C-o>D

" 編集中のファイルのディレクトリに移動
nnoremap ,cd :execute ":lcd" . expand("%:p:h")<CR>

" 以下、タブ切り替え用のキーマッピング
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sn gt
nnoremap sp gT
nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap so <C-w>_<C-w>|
nnoremap sO <C-w>=
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap sT :<C-u>Unite tab<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>

" Escの二回押しでハイライト消去
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" 日時の入力補助
" inoremap <expr> ,df strftime(

" ターミナルモードで開く
nnoremap <Space>T :<C-u>vsplit<CR><Esc><C-w>w:terminal<CR>

if has('nvim')
  tnoremap <Esc> <C-\><C-n>
endif
