" -----------------------------------------------------------------------------
"                                   SETTINGS
" -----------------------------------------------------------------------------
" switch from the default Vi-compatibility mode so as to enable useful
" vim functionality.
set nocompatible


" without this option, whever you switch buffers
" and your current buffer is not save, vim will
" prompt you to save the file
set hidden


" set encoding to utf-8 because why not
set encoding=utf-8


" disable wrapping of long lines
set nowrap


" enable file detection and indent scripts
filetype on
filetype plugin indent on
 
 
" for running netrw, vim's built-in file/directory
" explorer
set nocp

 
" Disable the default Vim startup message.
set shortmess+=I



" add numbering for lines
set number



" use ripgrep instead of grep
set grepprg=rg\ --vimgrep\ --smart-case\ --follow


" make vim paste copied text from the external program without
" having to use `=*p` or `=+p`
set clipboard=unnamed


" set tabs to 4 characters, spaces
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab

" Enable autoindent
set autoindent

" Enable sensible indentation and settings for python files
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set fileformat=unix

" for python, mark extra whitespace as bad
highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Enable sensible indentation for html and css files
au BufNewFile,BufRead  *.html,*.css,*.js,*.ts,*.jsx,*.tsx,*yml,*.yaml,*.sql
    \ set tabstop=2 |
    \ set shiftwidth=2 |
    \ set softtabstop=2

" Enable vim to try do a smart job in indentations
set smartindent

" Make backspace behave more reasonably
set backspace=indent,eol,start

" Disable hiding buffers protection. See `:help hidden` for more information on this.
set hidden


" enable mouse support
set mouse+=a


" no swapfile, no backups
set noswapfile
set nobackup
set undodir=~/.vim/undodir " you have to mkdir
set undofile

" Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=

" for folding
set foldmethod=indent
set foldlevel=99

" ignorecase makes all searches case-insensitive
" smartcase overrides the ignorecase option if the search pattern contains
" at least one uppercase character. That is, if there's an uppercase
" character, the search becomes case-sensistive
" For situations where you want to override ignorecase for an all-lowercase
" search patter, append \C to the pattern, for example /foo\C will not match
" Foo and FOO
set ignorecase smartcase

" add search highlighting, incremental search & shortened
" command for disabling highlighting after a search
set hlsearch incsearch

" turn on syntax highlighting, set colorscheme
syntax on
" colorscheme pablo 


" set width to 80 characters
set colorcolumn=80
" highlight ColorColumn ctermbg=0 guibg=lightgrey
hi ColorColumn ctermbg=darkgrey guibg=darkgrey

" on splitting windows, open new file on right or below
set splitbelow
set splitright



" -----------------------------------------------------------------------------
"                                   MAPPINGS
" -----------------------------------------------------------------------------
" set map leader key to <space>
" make sure spacebar doesn't have any mapping beforehand
nnoremap <SPACE> <Nop>
let mapleader = " "

" Add mapping for clearing highlighting after a search
nnoremap <silent> \ :<C-u>nohlsearch<CR>

" Center to line when searching
" currently disabling rest of options till I understand them
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz

nnoremap <esc><esc> :noh<return><esc>

" Unbind some useless/annoying default key bindings.
" 'Q' in normal mode enters Ex mode. You almost never want this.
nmap Q <Nop> 

" add key combos for navigating between split windows
" ctrl+j move to split window below
" ctrl+k move to split window above
" ctrl+l move to split window on the right
" ctrl+h move to spit window on the left
nnoremap <C-J> <C-W><C-J> 
nnoremap <C-K> <C-W><C-K> 
nnoremap <C-L> <C-W><C-L> 
nnoremap <C-H> <C-W><C-H> 



nnoremap <leader>q :make<CR>



" enable escape for terminal mode
" enable nav from terminal (while in terminal mode)
if has('nvim')
    " tnoremap <Esc> <C-\><C-n>
    " tnoremap <C-v><Esc> <Esc>

    tnoremap <C-h> <C-\><C-n><C-w>h
    tnoremap <C-j> <C-\><C-n><C-w>j
    tnoremap <C-k> <C-\><C-n><C-w>k
    tnoremap <C-l> <C-\><C-n><C-w>l
endif


" -----------------------------------------------------------------------------
"                                   PLUGINS
" -----------------------------------------------------------------------------
" automatically install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

 
 
" set up fzf
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" f for searching files within vim
" b search for open buffers with fzf
" c search for code with ripgrep 
" m search for marks with fzf
" l search lines within current file with fzf
" w search windows & tabs with fzf
nnoremap <silent><leader>f :Files!<CR> 	
nnoremap <silent><leader>b :Buffers!<CR> 	
nnoremap <silent><leader>c :Rg!<CR> 		
nnoremap <silent><leader>m :Marks!<CR> 		
nnoremap <silent><leader>l :BLines!<CR> 		
nnoremap <silent><leader>w :Windows!<CR> 	



" For working with Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
let g:go_fmt_command = "goimports"    " Run goimports along gofmt on each save
let g:go_auto_type_info = 1           " Automatically get signature/type info for object under cursor
 
 
 
" add tim-pope's commentary plugin
Plug 'tpope/vim-commentary'

 
 
" add tim-pope's surround plugin to simplify quoting/wrapping text
Plug 'tpope/vim-surround'
 
 
 
" add tim-pope's unimpaired plugin for quick navigation of lists
Plug 'tpope/vim-unimpaired'



" for cpp dev
Plug 'ycm-core/YouCompleteMe'
" to enable syntastic:
" github.com/ycm-core/YouCompleteMe#user-content-the-gycm_show_diagnostics_ui-option
let g:ycm_show_diagnostics_ui = 0
let syntastic_cpp_checkers = ['clang_tidy']
let syntastic_go_checkers = [ 'gofmt' ]
Plug 'rhysd/vim-clang-format'
let g:clang_format#auto_format = 1
 
 
 
" add tmux navigation compatibility
Plug 'christoomey/vim-tmux-navigator'
let g:tmux_navigator_save_on_switch = 1  
" Disable tmux navigator when zooming the Vim pane
let g:tmux_navigator_disable_when_zoomed = 1

" Easily interact with tmux from vim
" Plug 'preservim/vimux'
" <Leader>vl    run last command executed by VimuxRunCommand
" <Leader>vi    Inspect runner pane
" <leader>vz    Zoom the tmux runner pane
" map <Leader>vp :VimuxPromptCommand<CR>
" map <Leader>vl :VimuxRunLastCommand<CR>     
" map <Leader>vi :VimuxInspectRunner<CR>      
" map <leader>vz :VimuxZoomRunner<CR>         

 
 
" for working with git within vim
Plug 'tpope/vim-fugitive' 

" for showing git diff markers on curr buffer
Plug 'airblade/vim-gitgutter'



" add theme
Plug 'joshdick/onedark.vim'



" add nerdtree for file nav
Plug 'preservim/nerdtree'
" NERDTreeFind - find location of file in curr buffer
" NERDTreeToggle - open/close NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
" autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
"     \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
" manage NERDTree and tabs painlessly
Plug 'jistr/vim-nerdtree-tabs'
" for displaying git status in nerdtree
Plug 'Xuyuanp/nerdtree-git-plugin'
let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'M',
                \ 'Staged'    :'+',
                \ 'Untracked' :'??',
                \ 'Renamed'   :'Renamed',
                \ 'Unmerged'  :'Unmerged',
                \ 'Deleted'   :'Deleted',
                \ 'Dirty'     :'Dirty',
                \ 'Ignored'   :'Ignored',
                \ 'Clean'     :'Clean',
                \ 'Unknown'   :'Unknown',
                \ }
" disable show ignored
let g:NERDTreeGitStatusShowIgnored = 0



" for toggling, displaying and navigating marks
Plug 'kshenoy/vim-signature'



" add statusline
Plug 'itchyny/lightline.vim'
let g:lightline = {
    \ 'colorscheme': 'one',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             ['readonly', 'filename']],
    \   'right': [ [ 'percent', 'lineinfo'],
    \              [ 'buffer_number'],
    \              [ 'gitbranch']]
    \ },
    \ 'component': {
    \   'buffer_number': '[%n]' 
    \ },
    \ 'component_function': {
    \   'filename': 'LightlineFilename',
    \   'gitbranch': 'TrimmableGitBranchname',
    \ },
    \ }
" trimmable git branch name
function! TrimmableGitBranchname()
  return winwidth(0) > 70 ? FugitiveHead() : ''
endfunction
" concat filename and modified status
function! LightlineFilename()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let modified = &modified ? ' +' : ''
  return filename . modified
endfunction
 
 

" for autoclosing {},(),[],"",'',``
Plug 'jiangmiao/auto-pairs'



" for browsing tags
Plug 'preservim/tagbar'
nnoremap <Leader>t :TagbarToggle<CR>



" display buffer list on tabline
Plug 'ap/vim-buftabline'



" for distraction free writing
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240
" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'
" Highlighting priority (default: 10)
" Set it to -1 not to overrule hlsearch
let g:limelight_priority = -1
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
cnoremap Fg Goyo<CR>
cnoremap Fl Limelight!!<CR>



call plug#end()

" ----------------------------------------------------------------------
"
" ----------------------------------------------------------------------

colorscheme onedark
