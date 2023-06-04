noremap <Up> <Nop>
noremap <Down> <Nop>


noremap <Left> <Nop>
noremap <Right> <Nop>
"noremap h <Nop>
"noremap l <Nop>

let mapleader = "\<Space>"
set relativenumber
set showcmd

set noexpandtab
"set shiftwidth=2
set tabstop=2

set autoread
set number
set cmdheight=2
set encoding=utf8
set ffs=unix,dos,mac
set noerrorbells
set novisualbell
set t_vb=
set tm=500
set ignorecase
set smartcase
set hlsearch
set incsearch
set lazyredraw
set magic
set t_Co=256
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set cursorline
set re=0

set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set laststatus=2
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

set so =7

let g:ycm_confirm_extra_conf = 0

function! HasPaste()
	if &paste
		return 'PASTE MODE  '
	endif
	return ''
endfunction


autocmd BufReadPost *
			\ if line("'\"") > 0 && line("'\"") <= line("$") |
			\   exe "normal! g`\"" |
			\ endif	

nnoremap <leader>w :w<CR>
nnoremap <leader>W :w<CR>
command WW w !sudo tee % > /dev/null


xnoremap <leader>y y"0
nnoremap <leader>y y"0

xnoremap <leader>Y y"*
nnoremap <leader>Y y"*

nnoremap <leader>p p"0
xnoremap <leader>p p"0

nnoremap <leader>P p"*
xnoremap <leader>P p"*

nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>f :Files<CR>
nnoremap <leader>h :tabnew<CR>
nnoremap <leader>1 :tabnext 1<CR>
nnoremap <leader>2 :tabnext 2<CR>
nnoremap <leader>3 :tabnext 3<CR>
nnoremap <leader>4 :tabnext 4<CR>
nnoremap <leader>5 :tabnext 5<CR>
nnoremap <leader>6 :tabnext 6<CR>
nnoremap <leader>7 :tabnext 7<CR>
nnoremap <leader>8 :tabnext 8<CR>
nnoremap <leader>9 :tabnext 9<CR>


function! RipgrepFzf(query, fullscreen)
	let command_fmt = 'rg --column --glob !node_modules --line-number --no-heading --color=always --smart-case -- %s || true'
	let initial_command = printf(command_fmt, shellescape(a:query))
	let reload_command = printf(command_fmt, '{q}')
	let spec = {'options': ['--disabled', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
	let spec = fzf#vim#with_preview(spec, 'right', 'ctrl-/')
	call fzf#vim#grep(initial_command, 1, spec, a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

nnoremap <leader>s :RG<CR>
nnoremap <leader>r :ALEFindReferences<CR>

nnoremap <leader>q :wq<CR>
nnoremap <leader>Q :q<CR>
nnoremap <leader>rc :tabe ~/.vimrc<cr>
nnoremap <leader>t :tabe test.js<cr>
nnoremap <leader>in :normal magg=G`a<cr>
nnoremap <leader>po :tabe postSave.sh<cr>
nnoremap <leader>i :normal gg=G``<cr>
nnoremap M1 '1
nnoremap M2 '2
nnoremap M3 '3
nnoremap M4 '4
nnoremap M5 '5
nnoremap M6 '6
nnoremap M7 '7
nnoremap M8 '8
nnoremap M9 '9

let $FZF_DEFAULT_COMMAND='find . \( -name node_modules -o -name .git \) -prune -o -print'

nnoremap <silent><C-n> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><C-j> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><C-m> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><C-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>
nnoremap <silent>gd :ALEGoToDefinition<CR>

set background=dark

nnoremap <leader>k :!make && echo ".\n" && ./main < main.in<cr>

autocmd! bufwritepost .vimrc source %
autocmd! bufwritepost *.vim source ~/.vimrc

inoremap { {}<Esc>ha

let g:camelcasemotion_key = '<leader>'

let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

set ttyfast
set mouse=a


set timeout ttimeout
set timeoutlen=300
set ttimeoutlen=20

let g:ale_fixers = {}
let g:ale_fixers = {
 \ 'javascript': ['prettier', 'eslint'],
 \ 'typescript': ['prettier', 'eslint'],
 \ 'javascriptreact': ['prettier', 'eslint'],
 \ 'typescriptreact': ['prettier', 'eslint'],
 \ }

let g:ale_fix_on_save = 1
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
let g:ale_set_highlights = 0

inoremap <silent><expr> <Tab> coc#pum#visible() ? coc#pum#confirm() : "<Tab>"

call plug#begin()
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'justinmk/vim-sneak'
Plug 'alpertuna/vim-header'
Plug 'KabbAmine/yowish.vim'
"Plug 'crusoexia/vim-monokai'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'sudar/comments.vim'
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
Plug 'sheerun/vim-polyglot'
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'terryma/vim-multiple-cursors'
call plug#end()

colorscheme monokai
"source ~/.vim/customTheme
