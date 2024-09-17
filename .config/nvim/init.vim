" ========== General Settings ==========
set encoding=utf8
set ffs=unix,dos,mac
set ttyfast
set mouse=a
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set laststatus=2
set cmdheight=2
set showcmd
set relativenumber
set number
set cursorline
set re=0

" ========== Leader Key ==========
let mapleader = "\<Space>"

" ========== Tab and Indentation Settings ==========
set noexpandtab
set shiftwidth=2
set tabstop=2
filetype plugin indent on

" ========== Search Settings ==========
set ignorecase
set smartcase
set hlsearch
set incsearch
set magic

" ========== Performance Settings ==========
set lazyredraw

" ========== Error Bells ==========
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" ========== Color Settings ==========
set t_Co=256

" ========== Custom Status Line ==========
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

function! HasPaste()
	if &paste
		return 'PASTE MODE  '
	endif
	return ''
endfunction

" ========== Auto Commands ==========
" Remember last position
autocmd BufReadPost *
			\ if line("'\"") > 0 && line("'\"") <= line("$") |
			\   exe "normal! g`\"" |
			\ endif

" Set wrap for markdown files
autocmd FileType markdown setlocal wrap

" Remap j and k for wrapped lines in markdown files
autocmd FileType markdown noremap <buffer> j gj
autocmd FileType markdown noremap <buffer> k gk

" Reload configuration files on save
augroup ReloadInit
	autocmd!
	autocmd BufWritePost ~/.config/nvim/* source ~/.config/nvim/init.vim
	autocmd BufWritePost ~/dotfiles/.config/nvim/* source ~/.config/nvim/init.vim
augroup END

" ========== Key Mappings ==========
" Disable arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" Leader key mappings
nnoremap <leader>w :w<CR>
nnoremap <leader>W :w<CR>
nnoremap <leader>g :Format<CR>
nnoremap <leader>q :wq<CR>
nnoremap <leader>Q :q<CR>
nnoremap <leader>rc :tabe ~/.config/nvim/init.vim<cr>
nnoremap <leader>t :tabe test.js<cr>
nnoremap <leader>e :tabe<cr>
nnoremap <leader>in :normal magg=G`a<cr>
nnoremap <leader>po :tabe postSave.sh<cr>
nnoremap <leader>i :normal gg=G``<cr>

" Tab navigation
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

" Other mappings
nnoremap D dd
inoremap { {}<Esc>ha
command WW w !sudo tee % > /dev/null

" Mark mappings
nnoremap M1 '1
nnoremap M2 '2
nnoremap M3 '3
nnoremap M4 '4
nnoremap M5 '5
nnoremap M6 '6
nnoremap M7 '7
nnoremap M8 '8
nnoremap M9 '9

" ========== Plugin Settings ==========
" NERDTree
let g:NERDTreeQuitOnOpen = 1
autocmd BufEnter NERD_tree_* | execute 'normal R'
nnoremap <leader>n :NERDTreeToggle<CR>

" FZF
nnoremap <leader>f :Files<CR>
nnoremap <leader>s :RG<CR>

" EasyMotion
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyz'
nmap <leader>k <Plug>(easymotion-overwin-w)
hi EasyMotionTarget ctermbg=none ctermfg=LightRed cterm=underline

" Camelcase motion
let g:camelcasemotion_key = '<leader>'

" Vimtex
let g:vimtex_quickfix_enabled = 0
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'

" Vimspector
nnoremap <Leader>l :call vimspector#Launch()<CR>
nnoremap <Leader>L :call vimspector#Reset()<CR>
nnoremap <Leader>c :call vimspector#RunToCursor()<CR>
nnoremap <Leader>C :call vimspector#Continue()<CR>
nnoremap <Leader>i :call vimspector#StepInto()<CR>
nnoremap <Leader>o :call vimspector#StepOver()<CR>
nnoremap <Leader>O :call vimspector#StepOut()<CR>
nnoremap <Leader>b :call vimspector#ToggleBreakpoint()<CR>
nnoremap <Leader>B :call vimspector#ClearBreakpoints()<CR>
nnoremap <Leader>p :call vimspector#Pause()<CR>
nnoremap <Leader>v <Plug>VimspectorBalloonEval
xmap <Leader>v <Plug>VimspectorBalloonEval

command! VimspectorResetAndRestart call VimspectorResetAndRestartFunc()
function! VimspectorResetAndRestartFunc()
	call vimspector#Evaluate("-exec monitor reset")
	call vimspector#Restart()
endfunction
nnoremap <Leader>R :VimspectorResetAndRestart<CR>

" Harpoon
nnoremap mm :lua require("harpoon.mark").add_file()<CR>
nnoremap M :lua require("harpoon.ui").toggle_quick_menu()<CR>
nnoremap <F5> :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <F6> :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <F7> :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <F8> :lua require("harpoon.ui").nav_file(4)<CR>

" OSCYank
vnoremap <leader>y y:OSCYankVisual<CR>

" YCM
let g:ycm_confirm_extra_conf = 0

" ========== Custom Functions ==========
" Calculator function
function! EchoSelectedText()
	let saved_register = @"
	normal! gv"ay
	let selected_text = @a
	let @a = saved_register

	let result = system('echo "scale=10; ' . selected_text . '" | bc 2>/dev/null')

	if result != ''
		let result = trim(result)
		execute "normal! gv\"_c" . result
	else
		echo "Invalid expression or result"
	endif
endfunction

xnoremap M :<C-u>call EchoSelectedText()<CR>

" ========== Custom Tab Line ==========
function! MyTabLine()
	let s = ''
	for i in range(tabpagenr('$'))
		if i + 1 == tabpagenr()
			let s .= '%#TabLineSel#'
		else
			let s .= '%#TabLine#'
		endif

		let s .= ' ' . (i + 1) . ' '

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

		if i + 1 == tabpagenr()
			let s .= '%#TabLineSel#%T'
		else
			let s .= '%#TabLine#%T'
		endif
	endfor

	let s .= '%#TabLineFill#%T'
	let s .= '%=%#TabLine#%X'

	return s
endfunction

set tabline=%!MyTabLine()
set stal=2

" ========== Cursor Shape ==========
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" ========== Timeout Settings ==========
set timeout ttimeout
set timeoutlen=300
set ttimeoutlen=20

" ========== Plugin Declarations ==========
call plug#begin()
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	Plug 'preservim/nerdtree'
	Plug 'sudar/comments.vim'
	Plug 'easymotion/vim-easymotion'
	Plug 'sheerun/vim-polyglot'
	Plug 'neovim/nvim-lspconfig'
	Plug 'williamboman/mason.nvim', {'do': ':MasonUpdate'}
	Plug 'williamboman/mason-lspconfig.nvim'
	Plug 'hrsh7th/nvim-cmp'
	Plug 'hrsh7th/cmp-nvim-lsp'
	Plug 'L3MON4D3/LuaSnip'
	Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v2.x'}
	Plug 'lervag/vimtex'
	Plug 'puremourning/vimspector'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'ThePrimeagen/harpoon'
	Plug 'ojroques/vim-oscyank'
	Plug 'mhartington/formatter.nvim'
	Plug 'zbirenbaum/copilot.lua'
	Plug 'lukas-reineke/indent-blankline.nvim'
	Plug 'b0o/schemastore.nvim'
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()

" ========== Source Custom Colorscheme ==========
source ~/.config/nvim/custom-monokai.vim

" ========== Lua Configuration ==========
lua <<EOF

-- Indent Blankline setup
local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}
local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

vim.g.rainbow_delimiters = { highlight = highlight }
require("ibl").setup { scope = { highlight = highlight } }

hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

-- LSP Zero setup
local lsp = require('lsp-zero').preset("recommended")

lsp.ensure_installed({
'bashls',
'tsserver',
'pyright',
'vimls',
'lua_ls'
})

local lspconfig = require'lspconfig'

lspconfig.clangd.setup {
	cmd = {"/Users/fox/code/espressif/esp-clang/bin/clangd"}
}

local function check_back_space()
local col = vim.fn.col('.') - 1
return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
['<Tab>'] = function(fallback)
print(cmp.visible())
if cmp.visible() then
	cmp.confirm({ select = true })
elseif require('copilot.suggestion').is_visible() then
	require('copilot.suggestion').accept()
elseif check_back_space() then
	fallback()
else
	cmp.complete()
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

lsp.setup()

-- Formatter setup
local util = require "formatter.util"

require("formatter").setup {
	filetype = {
		javascript = {
			require("formatter.filetypes.javascript").prettier
		},
		javascriptreact = {
			require("formatter.filetypes.javascriptreact").prettier
		},
	}
	}

-- Copilot setup
require('copilot').setup({
panel = {
	enabled = true,
	auto_refresh = false,
	keymap = {
		jump_prev = "[[",
		jump_next = "]]",
		accept = "<CR>",
		refresh = "gr",
		open = "<M-CR>"
	},
	layout = {
		position = "bottom",
		ratio = 0.4
	},
},
suggestion = {
	enabled = true,
	auto_trigger = true,
	hide_during_completion = true,
	debounce = 75,
	keymap = {
		accept_word = false,
		accept_line = false,
		next = "<C-k>",
		prev = "<C-j>",
		dismiss = "<C-]>",
	},
},
copilot_node_command = 'node',
server_opts_overrides = {},
})
EOF
