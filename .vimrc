set nocompatible
set encoding=utf-8
setglobal fileencoding=utf-8
set fileencodings=ucs-bom,utf-8
set nohidden
" Don't add invisible linebreak at EOF
set binary noeol
" Key mapping delay
set timeoutlen=1000
" Key code delay
set ttimeoutlen=0
syntax sync minlines=256 " start highlighting from 256 lines backwards
set synmaxcol=300        " do not highlight very long lines
set listchars=tab:>-,trail:.,precedes:<,extends:>
set display+=uhex
"
" Display hidden unicode characters as hex
set display+=uhex

set number

" Highlight all search matches
set showmatch

" Incremental search (ie. search while you type)
set hlsearch

" Ignore case for search unless it contains uppercase characters
set ignorecase
set smartcase

" After vertical split, select lower pane
" (hozontal splitting, keep default: select left pane)
set splitbelow

" Remove scrollbars
set guioptions+=lrbRL
set guioptions-=lrbRL

" No audio bell
set vb

set clipboard=unnamedplus

let mapleader = "\<Space>"

" Required!
call plug#begin('~/.vim/plugged')

" Defaults everyone can agree on
Plug 'tpope/vim-sensible'

" Tools
Plug 'neomake/neomake'
Plug 'tpope/vim-sleuth'
Plug 'godlygeek/tabular'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround' " cs and ys, for example ysiw to surround word
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tomtom/tcomment_vim'
Plug 'mattn/emmet-vim' " trigger: <C-y-,>
Plug 'sickill/vim-pasta' " Pasting in Vim with indentation adjusted to destination context.
Plug 'Lokaltog/vim-easymotion'
Plug 'miyakogi/conoline.vim' " Highlight current line
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'itchyny/lightline.vim'
Plug 'AndrewRadev/splitjoin.vim' " trigger: gS and gJ
Plug 'Raimondi/delimitMate'
Plug 'LeonB/vim-previous-buffer'
Plug 'tpope/vim-speeddating'
Plug 'dyng/ctrlsf.vim'
Plug 'dylanaraps/wal.vim'
Plug 'haya14busa/is.vim' " Better incremental search
Plug 'osyo-manga/vim-anzu'
Plug 'christoomey/vim-tmux-navigator'

" JS
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue'] }

" Go
Plug 'fatih/vim-go', { 'for': 'go' }

" Autocomplete & Snippets
Plug 'SirVer/ultisnips' " C-j and C-k to jump between placeholders
Plug 'honza/vim-snippets'

Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/asyncomplete-buffer.vim'
Plug 'prabirshrestha/asyncomplete-file.vim'
Plug 'prabirshrestha/asyncomplete-ultisnips.vim'

" Syntax
"Plug 'editorconfig/editorconfig-vim'
Plug 'sheerun/vim-polyglot' " Replace all syntax plugins with this one

if executable('ctags')
    Plug 'prabirshrestha/asyncomplete-tags.vim'
    "Plug 'ludovicchabant/vim-gutentags'
    Plug 'majutsushi/tagbar' " trigger: <Leader>B
endif

" Vim Readline key bindings
Plug 'tpope/vim-rsi'

" Required!
call plug#end()

" JS
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.css,*.scss,*.less Prettier
let g:prettier#config#bracket_spacing = 'true'

" ReactJS
let g:jsx_ext_required = 0 " Allow JSX in normal JS files

" Backup, Swap and View Files
" Create dirs
silent execute '!mkdir -p $HOME/.vim/.backup'
silent execute '!mkdir -p $HOME/.vim/.swap'
silent execute '!mkdir -p $HOME/.vim/.views'
silent execute '!mkdir -p $HOME/.vim/.undo'
" Store backups in $HOME to keep the directory trees clean
set backup
set undofile
set backupdir=$HOME/.vim/.backup/
set directory=$HOME/.vim/.swap/
set viewdir=$HOME/.vim/.views/
set undodir=$HOME/.vim/.undo/

" Wildignore
set wildignore=bower_components/**
set wildignore+=node_modules/**
set wildignore+=third_party/**
set wildignore+=vendor/**

" Tabs and Indentation
set noexpandtab
set tabstop=4
set shiftwidth=4

" Workaround for https://github.com/tpope/vim-sleuth/issues/29.
" Define autocmd as early as possible so other autocmds can override.
runtime! plugin/sleuth.vim
" Different tab and indentation for specific file types
au FileType proto set expandtab ts=2 sw=2 softtabstop=2
au FileType less set expandtab ts=2 sw=2 softtabstop=2
au FileType crontab setlocal nobackup nowritebackup
au FileType javascript.jsx set expandtab ts=2 sw=2 softtabstop=2
au FileType css set expandtab ts=2 sw=2 softtabstop=2
au FileType html set expandtab ts=2 sw=2 softtabstop=2

" Neomake
" When writing a buffer.
call neomake#configure#automake('w')
let g:neomake_go_enabled_makers = ['go', 'golangci_lint', 'golint']
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_open_list = 2
let g:neomake_list_height = 3

" vim-lsp
let g:lsp_virtual_text_enabled = 0
let g:lsp_highlights_enabled = 0
let g:lsp_text_edit_enabled = 0

if executable('rls')
    au User lsp_setup call lsp#register_server({
	\ 'name': 'rls',
	\ 'cmd': {server_info->['rustup', 'run', 'nightly', 'rls']},
	\ 'whitelist': ['rust'],
	\ })
  endif
if executable('pyls')
    " pip install python-language-server
    au User lsp_setup call lsp#register_server({
	\ 'name': 'pyls',
	\ 'cmd': {server_info->['pyls']},
	\ 'whitelist': ['python'],
	\ })
endif
if executable('gopls')
    au User lsp_setup call lsp#register_server({
	\ 'name': 'gopls',
	\ 'cmd': {server_info->['gopls']},
	\ 'whitelist': ['go'],
	\ })
endif
if executable('terraform-lsp')
    au User lsp_setup call lsp#register_server({
	\ 'name': 'tf',
	\ 'cmd': {server_info->['terraform-lsp']},
	\ 'whitelist': ['tf', 'terraform'],
	\ })
endif
if executable('java') && filereadable(expand('~/lsp/eclipse.jdt.ls/plugins/org.eclipse.equinox.launcher_1.5.400.v20190515-0925.jar'))
    au User lsp_setup call lsp#register_server({
	\ 'name': 'eclipse.jdt.ls',
	\ 'cmd': {server_info->[
	\     'java',
	\     '-Declipse.application=org.eclipse.jdt.ls.core.id1',
	\     '-Dosgi.bundles.defaultStartLevel=4',
	\     '-Declipse.product=org.eclipse.jdt.ls.core.product',
	\     '-Dlog.level=ALL',
	\     '-noverify',
	\     '-Dfile.encoding=UTF-8',
	\     '-Xmx1G',
	\     '-jar',
	\     expand('~/lsp/eclipse.jdt.ls/plugins/org.eclipse.equinox.launcher_1.5.400.v20190515-0925.jar'),
	\     '-configuration',
	\     expand('~/lsp/elipse.jdt.ls/config_win'),
	\     '-data',
	\     getcwd()
	\ ]},
	\ 'whitelist': ['java'],
	\ })
endif

" Unimpaired
nmap ½ [
nmap § ]
omap ½ [
omap § ]
xmap ½ [
xmap § ]

" ctrlsf
nmap     <C-F>f <Plug>CtrlSFPrompt
vmap     <C-F>f <Plug>CtrlSFVwordPath
vmap     <C-F>F <Plug>CtrlSFVwordExec
nmap     <C-F>n <Plug>CtrlSFCwordPath
nmap     <C-F>p <Plug>CtrlSFPwordPath
nnoremap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>

" Conoline
" let g:conoline_use_colorscheme_default_normal=1
" let g:conoline_use_colorscheme_default_insert=1


" Key Mappings

" Better incremental search
map n <Plug>(is-nohl)<Plug>(anzu-n-with-echo)
map N <Plug>(is-nohl)<Plug>(anzu-N-with-echo)

" Make so that J and K moves up and down a line while keeping the caret in the
" same column
nmap j gj
nmap k gk

" Zoom a window by editing it in a new tab
nmap <C-w>z :tab sp<CR>

" Use tab in normal mode to switch to previous buffer
nmap <Tab> :PreviousBuffer<CR>

" easier cursor navigation between split windows using CTRL and h,j,k, or l
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Location list shortcuts
function! ToggleLocationList()
  let curbufnr = winbufnr(0)
  for bufnum in map(filter(split(s:GetBufferList(), '\n'), 'v:val =~ "Location List"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if curbufnr == bufnum
      lclose
      return
    endif
  endfor

  let winnr = winnr()
  let prevwinnr = winnr("#")

  let nextbufnr = winbufnr(winnr + 1)
  try
    lopen
  catch /E776/
      echohl ErrorMsg 
      echo "Location List is Empty."
      echohl None
      return
  endtry
  if winbufnr(0) == nextbufnr
    lclose
    if prevwinnr > winnr
      let prevwinnr-=1
    endif
  else
    if prevwinnr > winnr
      let prevwinnr+=1
    endif
  endif
  " restore previous window
  exec prevwinnr."wincmd w"
  exec winnr."wincmd w"
endfunction

nmap <leader>n :ll<CR>
nmap <leader>a :call ToggleLocationList()<CR>

" Fast saving
nnoremap <C-s> :w!<cr>

nnoremap <F3> :set hlsearch!<CR>

map <Leader>q :bp\|bd #<CR>

nmap <Leader>B :TagbarToggle<CR>

" Toggle show whitespace characters
nnoremap <Leader>li :set list! list?<CR>

" EasyMotion {
nmap <Leader>w <Plug>(easymotion-w)
nmap <Leader>W <Plug>(easymotion-b)
nmap <Leader>W <Plug>(easymotion-b)
nmap <Leader>l <Plug>(easymotion-lineforward)
nmap <Leader>j <Plug>(easymotion-j)
nmap <Leader>k <Plug>(easymotion-k)
nmap <Leader>h <Plug>(easymotion-linebackward)

" Format JSON
nnoremap =j :%!python -m json.tool<CR>
nnoremap =x :%!xmllint --format -<CR>

" Netrw
map <silent> <Leader>e :call ExToggle()<CR>
" Override settings to show line numbers
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
let g:netrw_browse_split = 0    " open files in same buffer
let g:netrw_dirhistmax=0      " keep more history
let g:netrw_altfile=1           " last edited file '#'
let g:netrw_use_errorwindow=0   " suppress error window
let g:netrw_liststyle=0         " thin (change to 3 for tree)
let g:netrw_banner=0            " no banner
let g:netrw_altv=1              " open files on right
let g:netrw_preview=1           " open previews vertically
" Delete the netrw buffer when hidden
autocmd FileType netrw setl bufhidden=wipe

fun! ExToggle()
  if &filetype != "netrw"
    call ExOpen()
  else
    call ExClose()
  endif
endf

fun! ExOpen()
  let g:last_bufnr = bufnr('%')
  let g:netrw_browse_split=0  " open files in current window
  exe "Explore"
endf

fun! ExClose()
  if &filetype == "netrw"
    exe ':b' . g:last_bufnr
  endif
endf

augroup netrw
  autocmd!
  autocmd filetype netrw nmap <buffer> l <cr>
  autocmd filetype netrw nmap <buffer> h <Plug>VinegarUp
augroup END

" Autocomplete
" Tab navigation in the popupmenu
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
      \ 'name': 'ultisnips',
      \ 'whitelist': ['*'],
      \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
      \ }))

" Snippets
let g:UltiSnipsExpandTrigger = "<C-x>"

" vim-go {
au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap gd <Plug>(go-def)
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)

let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1
let g:go_def_mode = 'gopls'
let g:go_info_mode = 'gopls'
let g:go_rename_command = 'gopls'
let g:go_metalinter_command = 'golangci-lint'
" neomake already run this on save
let g:go_metalinter_autosave = 0
let g:go_code_completion_enabled = 0

" Disable polyglot for Go files
let g:polyglot_disabled = ['go']

" let g:go_highlight_functions = 1
" let g:go_highlight_methods = 1
" let g:go_highlight_structs = 1
" let g:go_highlight_interfaces = 1
" let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" vim-rsi
" This fixes ��� characters
let g:rsi_no_meta = 1

" FZF {
nmap <Leader>f :GFiles<CR>
nmap <Leader>F :Files<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>H :Helptags!<CR>
nmap <Leader>t :BTags<CR>
nmap <Leader>T :Tags<CR>
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!{.git,node_modules,vendor}/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)

" Lightline
let g:lightline = {
	\ 'active': {
	\   'left': [ [ 'mode', 'paste' ],
	\             [ 'tabs_spaces', 'readonly', 'absolutepath', 'modified' ] ],
	\   'right': [ [ 'lineinfo' ],
	\              [ 'percent' ],
	\              [ 'fileformat', 'fileencoding', 'filetype', 'neomake' ] ],
	\ },
	\ 'component_expand': {
	\   'paste': 'LightlinePaste',
	\   'neomake': 'LightlineNeomake',
	\ },
	\ 'component': {
	\   'tabs_spaces': '%{(&expandtab?"spaces":"tabs").":".&tabstop}',
	\ },
	\ 'component_type': {
	\   'paste': 'warning',
	\   'neomake': 'error',
	\ },
	\ 'separator': { 'left': '', 'right': '' },
	\ 'subseparator': { 'left': '|', 'right': '|' }
      \ }

function LightlinePaste()
    return '%{&paste?"PASTE":""}'
endfunction

function LightlineNeomake()
    return '%{neomake#statusline#LoclistStatus()}'
endfunction

colorscheme wal

" Terraform
let g:terraform_fmt_on_save=1
let g:terraform_align=1
