" plugins {{{
" https://github.com/junegunn/vim-plug
call plug#begin('~/.config/nvim/plugged')

Plug 'Shougo/deoplete.nvim'
Plug 'Shougo/echodoc.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neosnippet.vim'
Plug 'bling/vim-airline'
Plug 'brookhong/cscope.vim'
Plug 'elzr/vim-json'
Plug 'fatih/vim-go'
Plug 'garyburd/go-explorer'
Plug 'godlygeek/tabular'
Plug 'honza/vim-snippets'
Plug 'kien/ctrlp.vim'
Plug 'majutsushi/tagbar'
Plug 'mhinz/vim-grepper'
Plug 'mhinz/vim-startify'
Plug 'pR0Ps/molokai-dark'
Plug 'pangloss/vim-javascript'
Plug 'robertmeta/nofrils'
Plug 'rodjek/vim-puppet'
Plug 'sjl/gundo.vim'
Plug 'solarnz/thrift.vim'
Plug 'tikhomirov/vim-glsl'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'w0rp/ale'
Plug 'zchee/deoplete-go'

call plug#end()
" }}}

" Ale {{{

let g:ale_sign_error='⊘'
let g:ale_sign_warning='⚠'

" }}}

" colorscheme {{{

set termguicolors
set background=dark
let g:nofrils_strbackgrounds=1

let g:hot_colors_name = 'molokai-dark'
let g:cool_colors_name = 'nofrils-dark'

try
    if g:colors_name == "default"
        execute 'colorscheme ' . g:hot_colors_name
    endif
catch E121
    execute 'colorscheme ' . g:hot_colors_name
endtry

function! ToggleHotCold()
  if g:colors_name == g:hot_colors_name
      execute 'colorscheme ' . g:cool_colors_name
  else
      execute 'colorscheme ' . g:hot_colors_name
  endif
endfunction

nnoremap cof :call ToggleHotCold()<CR>

" }}}

" *line {{{

" airline {{{
let g:airline_powerline_fonts=0
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#eclim#enabled = 1
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#capslock#enabled = 1

" unicode symbols
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_symbols.readonly = 'R'
let g:airline_symbols.linenr = 'L'

" }}}

" }}}

" Options {{{

set cursorline
set nocursorcolumn
set expandtab
set list
set scrolloff=3 " Try to keep 3 lines after cursor
set splitbelow
set splitright
set virtualedit=all
set inccommand=nosplit
set fillchars=
set lazyredraw
set shortmess=atToO
set cmdheight=1
set noshowmode

let g:netrw_liststyle = 3

set tabstop=4
set shiftwidth=4
set smartindent
set nowrap

set mouse=a

" }}}

" searching {{{
set ignorecase " Do case insensitive matching...
set smartcase  " ...but only if the user didn't explicitly case

" disable hlsearch in insert mode
augroup hlsearch
  autocmd InsertEnter * :setlocal nohlsearch
  autocmd InsertLeave * :setlocal   hlsearch
augroup END

" mappings to make "very magic" the default
nnoremap / /\v
nnoremap ? ?\v
" }}}

" Save undo files in central location {{{
if has("persistent_undo")
  set undofile
  set undodir=$HOME/.config/nvim/undo
  if !isdirectory(&undodir) && exists("*mkdir")
    call mkdir(&undodir, "p", 0700)
  endif
endif
" }}}

" Save swap files in central location {{{
set directory=$HOME/.config/nvim/swap
if exists("*mkdir") && !isdirectory(&directory)
  call mkdir(&directory, "p", 0700)
endif
" }}}

" Spelling {{{
set spell

" ... except for some filetypes
augroup nospell
  autocmd FileType help setlocal nospell
  autocmd FileType man setlocal nospell
  autocmd FileType startify setlocal nospell
  autocmd FileType godoc setlocal nospell
  autocmd FileType qf setlocal nospell
  autocmd FileType netrw setlocal nospell
  autocmd FileType vim-plug setlocal nospell
  autocmd FileType fugitiveblame setlocal nospell
augroup END
" }}}

" Folding {{{

" default to indent folding
set foldmethod=indent
set foldlevelstart=1

" set foldmethod=syntax
" let javaScript_fold=1         " JavaScript
" let perl_fold=1               " Perl
" let php_folding=1             " PHP
" let r_syntax_folding=1        " R
" let ruby_fold=1               " Ruby
" let sh_fold_enabled=1         " sh
" let vimsyn_folding='af'       " Vim script
" let xml_syntax_folding=1      " XML

" syntax folding for some filetypes
augroup syntax_folding
  autocmd FileType markdown setlocal foldmethod=syntax
  autocmd FileType json setlocal foldmethod=syntax
  autocmd FileType javascript setlocal foldmethod=syntax
augroup END

" foldcolumn on by default...
" set foldcolumn=4
" ... except for
augroup NoFoldColumn
  autocmd Filetype help setlocal foldcolumn=0
  autocmd Filetype godoc setlocal foldcolumn=0
  autocmd Filetype gitcommit setlocal foldcolumn=0
  autocmd Filetype qf setlocal foldcolumn=0
  autocmd Filetype netrw setlocal foldcolumn=0
augroup END
" mapping to toggle it
nmap <leader>fc <Plug>FoldToggleColumn
" }}}

" hack filetype for some extensions {{{
augroup filetype_ext_hacks
  autocmd BufRead,BufNewFile *.md setlocal filetype=markdown
augroup END
" }}}

" Go! {{{

au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap <Leader>e <Plug>(go-rename)
au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>dd <Plug>(go-def)
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)

au FileType go nmap <leader>d <Plug>(go-doc)
" au FileType go nmap <leader>f <Plug>(go-info)
" au FileType go nmap <leader>d <Plug>(go-def)
" au FileType go nmap <leader>i :GoImports<Cr>

let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1

let g:go_auto_type_info = 1
let g:go_jump_to_error = 1

let g:go_highlight_build_constraints = 1
let g:go_highlight_functions = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_fields = 1
let g:go_highlight_structs = 1
let g:go_highlight_generate_tags = 1

let g:deoplete#sources#go = 'vim-go'
let g:go_snippet_engine = "neosnippet"
let g:go_template_autocreate = 0

let g:go_metalinter_autosave = 0 " XXX disabeld due to failing on fugitive buffers
" let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
" let g:go_metalinter_autosave_enabled = ['vet', 'golint']
" let g:go_metalinter_deadline = "5s"

let g:go_term_mode = "split"
let g:go_term_enabled = 1

augroup nolistgo
  autocmd FileType go setlocal nolist
augroup END

" }}}

" deoplete {{{
let g:deoplete#enable_at_startup = 1
let g:deoplete#disable_auto_complete = 1
set completeopt=menu,preview,longest,noselect

inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : deoplete#mappings#manual_complete()

" echodoc
let g:echodoc_enable_at_startup=1

" }}}

" neosnippet {{{
imap <C-e>     <Plug>(neosnippet_expand_or_jump)
smap <C-e>     <Plug>(neosnippet_expand_or_jump)
xmap <C-e>     <Plug>(neosnippet_expand_target)
imap <C-f>     <Plug>(neosnippet_jump)
smap <C-f>     <Plug>(neosnippet_jump)

let g:neosnippet#snippets_directory='~/.config/nvim/plugged/vim-snippets/snippets'

augroup loadvimgosnip
  autocmd FileType go NeoSnippetSource ~/.config/nvim/plugged/vim-go/gosnippets/snippets/go.snip
augroup END

" For conceal markers.
set conceallevel=1
set concealcursor=niv

" }}}

" CScope {{{

if has("cscope")
  set csprg=/usr/local/bin/cscope
  set csto=0
  set cst
  set nocsverb
  " add any database in current directory
  if filereadable("cscope.out")
      cs add cscope.out
  " else add database pointed to by environment
  elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
  endif
  set csverb
endif

au FileType c nnoremap <leader>fa :call CscopeFindInteractive(expand('<cword>'))<CR>
au FileType c nnoremap <leader>l :call ToggleLocationList()<CR>

" s: Find this C symbol
au FileType c nnoremap <leader>fs :call CscopeFind('s', expand('<cword>'))<CR>
" g: Find this definition
au FileType c nnoremap <leader>fg :call CscopeFind('g', expand('<cword>'))<CR>
" d: Find functions called by this function
au FileType c nnoremap <leader>fd :call CscopeFind('d', expand('<cword>'))<CR>
" c: Find functions calling this function
au FileType c nnoremap <leader>fc :call CscopeFind('c', expand('<cword>'))<CR>
" t: Find this text string
au FileType c nnoremap <leader>ft :call CscopeFind('t', expand('<cword>'))<CR>
" e: Find this egrep pattern
au FileType c nnoremap <leader>fe :call CscopeFind('e', expand('<cword>'))<CR>
" f: Find this file
au FileType c nnoremap <leader>ff :call CscopeFind('f', expand('<cword>'))<CR>
" i: Find files #including this file
au FileType c nnoremap <leader>fi :call CscopeFind('i', expand('<cword>'))<CR>


" }}}

" Java ... {{{
let g:EclimCompletionMethod = 'omnifunc'
au FileType java nmap <leader>i :JavaImport<Cr>
" }}}

" Mappings {{{

let mapleader=","

" easier use of ranged global normal {{{
" uses, and organizes around, the undocumented `g\/` and `g\&` forms describe
" in ex_global:

" Perform a normal command...
" ...on every line of the buffer
nnoremap <leader>n :%normal<space>
" ...on every line of a visual selection
vnoremap <leader>n :normal<space>
" ...on every line of the last visual selection.
nnoremap <leader>vn :'<,'>normal<space>

" Same progression filtered by the last search pattern.
nnoremap <leader>/: :%g\/<space>
nnoremap <leader>/n :%g\/normal<space>
vnoremap <leader>/n :g\/normal<space>
nnoremap <leader>/v: :'<,'>g\/<space>
nnoremap <leader>/vn :'<,'>g\/normal<space>

" Same progression filtered by the last substitution pattern.
nnoremap <leader>&: :%g\&<space>
nnoremap <leader>&n :%g\&normal<space>
vnoremap <leader>&n :g\&normal<space>
nnoremap <leader>&v: :'<,'>g\&<space>
nnoremap <leader>&vn :'<,'>g\&normal<space>

" }}}

" bindsplit
nmap <leader>bs <Plug>BindsplitVsplit

" no arrow keys for history
cnoremap <C-n> <down>
cnoremap <C-p> <up>

" grepper {{{

nmap gs  <plug>(GrepperOperator)
xmap gs  <plug>(GrepperOperator)

nnoremap <leader>g :Grepper -tool git<cr>
nnoremap <leader>G :Grepper -tool pt<cr>
" nnoremap <leader>* :Grepper -tool ag -cword -noprompt<cr>

let g:grepper           = {}
let g:grepper.tools     = ['git', 'pt', 'grep', 'ack']
let g:grepper.open      = 1
let g:grepper.switch    = 1
let g:grepper.jump      = 0
let g:grepper.next_tool = '<leader>g'
let g:grepper.pt = {
  \ 'pt':        { 'grepprg':    'pt --nogroup --skip-vcs-ignores',
  \                'grepformat': '%f:%l:%m' }}

" }}}

" vimscript editing convenience {{{
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
inoremap <leader>ev <esc>:vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>s% :source %<cr>
" }}}

" easier re-sync for lazy diff algorithm
nnoremap du :diffupdate<cr>

" fugitive bindings {{{
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gc :Gcommit<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>g: :Git
nnoremap <leader>g! :Gsplit!
nnoremap <leader>g\| :Gvsplit!
nnoremap <leader>gD :Gsplit! diff<cr>
nnoremap <leader>ga :Git add %<cr>
nnoremap <leader>gp :Git add --patch %<cr>
nnoremap <leader>gr :Git reset %<cr>
nnoremap <leader>go yaw:Gsplit <C-r>"<cr>
" }}}

" TagBar
nnoremap <leader>tg :TagbarToggle<cr>

" Tabular
nnoremap <leader>tt :Tab<cr>
nnoremap <leader>t\| :Tab/\|/<cr>
nnoremap <leader>t/ :Tab/\//<cr>
nnoremap <leader>t= :Tab/=/<cr>
nnoremap <leader>t, :Tab/,/<cr>
nnoremap <leader>t: :Tab/:/<cr>

" moar vinegar!
nmap <leader>- <Plug>VinegarSplitUp
nmap <leader>\| <Plug>VinegarVerticalSplitUp

" GUndo
nnoremap <leader>gu :GundoToggle<CR>

" }}}

" abbreviations {{{
augroup filetype_abbrs
  autocmd FileType javascript :iabbrev <buffer> vst var self = this;
augroup END
" }}}

" JSON {{{
let g:vim_json_syntax_conceal = 0
" }}}

" Startify {{{
let g:startify_change_to_dir = 0
" }}}

" vim:set foldmethod=marker foldlevel=0 ts=2 sw=2 expandtab:
