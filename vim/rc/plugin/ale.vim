let g:ale_linters = {
\ 'cs': ['OmniSharp'],
\ 'go': ['gometalinter', 'go build'], 
\ 'ruby': ['rubocop'], 
\ 'elixir': ['elixir-ls', 'dialyxir', 'credo']
\}

let g:ale_elixir_elixir_ls_release = '/Users/yasutomo.uemori/ghq/src/github.com/elixir-lsp/elixir-ls/rel'

let g:ale_elixir_elixir_ls_config = { 
\   'elixirLS': {
\     'dialyzerEnabled': v:false,
\   },  
\}

let g:ale_fixers = {
\ 'ruby': ['rubocop'],
\ 'elixir': ['mix_format']
\}

let g:ale_fix_on_save = 0
let g:ale_lint_on_save = 1
let g:ale_completion_enabled = 1

function ALELSPMappings()
	let l:lsp_found=0
	for l:linter in ale#linter#Get(&filetype) | if !empty(l:linter.lsp) | let l:lsp_found=1 | endif | endfor
	if (l:lsp_found)
		nnoremap <buffer> <C-]> :ALEGoToDefinition<CR>
		nnoremap <buffer> <C-^> :ALEFindReferences<CR>
	else
		silent! unmap <buffer> <C-]>
		silent! unmap <buffer> <C-^>
	endif
endfunction
autocmd BufRead,FileType * call ALELSPMappings()
