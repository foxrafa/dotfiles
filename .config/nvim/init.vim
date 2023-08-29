source ~/.config/nvim/custom-monokai.vim

noremap <Up> <Nop>
noremap <Down> <Nop>

noremap <Left> <Nop>
noremap <Right> <Nop>

let mapleader = "\<Space>"
set relativenumber
set showcmd

set noexpandtab
set shiftwidth=2
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
nnoremap <leader>s :RG<CR>
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

nnoremap <leader>q :wq<CR>
nnoremap <leader>Q :q<CR>
nnoremap <leader>rc :tabe ~/.config/nvim/init.vim<cr>
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

inoremap { {}<Esc>ha

let g:camelcasemotion_key = '<leader>'

let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

set ttyfast
set mouse=a


set timeout ttimeout
set timeoutlen=300
set ttimeoutlen=20

function! MyTabLine()
    let s = ''
    for i in range(tabpagenr('$'))
        " select the highlighting
        if i + 1 == tabpagenr()
            let s .= '%#TabLineSel#'
        else
            let s .= '%#TabLine#'
        endif

        " add tab number
        let s .= ' ' . (i + 1) . ' '

        " add buffer names
        let bufnr = tabpagebuflist(i + 1)[0]
        let file = bufname(bufnr)
        let buftype = getbufvar(bufnr, 'buftype')
        if buftype == 'nofile'
            if file =~ '\/.'
                let file = substitute(file, '.*\/\ze.', '', '')
            endif
        else
            let file = fnamemodify(file, ':t')
        endif
        if file == ''
            let file = '[No Name]'
        endif
        let s .= ' ' . file . ' '

        " add close tab character
        if i + 1 == tabpagenr()
            let s .= '%#TabLineSel#%T'
        else
            let s .= '%#TabLine#%T'
        endif
    endfor

    " after the last tab fill with TabLineFill and reset tab page nr
    let s .= '%#TabLineFill#%T'

    " right aligned close current tab
    let s .= '%=%#TabLine#%X'

    return s
endfunction

set tabline=%!MyTabLine()
set stal=2

let g:EasyMotion_do_mapping = 0
nmap <leader>k <Plug>(easymotion-overwin-w)
hi EasyMotionTarget ctermbg=none ctermfg=LightRed cterm=underline

let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyz'

augroup ReloadInit
    autocmd!
    autocmd BufWritePost ~/.config/nvim/* source ~/.config/nvim/init.vim
    autocmd BufWritePost ~/dotfiles/.config/nvim/* source ~/.config/nvim/init.vim
augroup END

call plug#begin()
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'preservim/nerdtree'
Plug 'sudar/comments.vim'
Plug 'easymotion/vim-easymotion'
Plug 'sheerun/vim-polyglot'

" LSP Support
Plug 'neovim/nvim-lspconfig'                           " Required
Plug 'williamboman/mason.nvim', {'do': ':MasonUpdate'} " Optional
Plug 'williamboman/mason-lspconfig.nvim'               " Optional

" Autocompletion
Plug 'hrsh7th/nvim-cmp'         " Required
Plug 'hrsh7th/cmp-nvim-lsp'     " Required
Plug 'L3MON4D3/LuaSnip'         " Required

Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v2.x'}
call plug#end()

lua <<EOF
local lsp = require('lsp-zero').preset("recommended")

lsp.ensure_installed({
	'bashls',
	'tsserver',
	'clangd',
	'pyright',
	'vimls',
	'lua_ls'
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
  ["<C-Space>"] = cmp.mapping.complete(),
	['<Tab>'] = function(fallback)
	print(cmp.visible())
		if cmp.visible() then
			cmp.confirm({ select = true })
    else
      fallback()
    end
  end,
})

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = '❌',
        warn = '⚠️',
    }
})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})

	vim.keymap.set("n", "<leader>r", function() vim.lsp.buf.rename() end, opts)
end)

-- " (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()
EOF
