-- Install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

vim.cmd([[
augroup Packer
	autocmd!
	autocmd BufWritePost init.lua PackerCompile
augroup end
]])

local use = require("packer").use
require("packer").startup(function()
	use("wbthomason/packer.nvim") -- Package manager
	use("tpope/vim-sleuth") -- Autodetect indentation settings
	use("tpope/vim-fugitive") -- Git commands in nvim
	use("tpope/vim-unimpaired")
	use("tpope/vim-vinegar") -- Improve netrw
	use("ludovicchabant/vim-gutentags") -- Automatic tags management
	use("mg979/vim-visual-multi") -- Multiple cursors
	use("godlygeek/tabular") -- Align text
	use("terrortylor/nvim-comment")
	use("mattn/emmet-vim")
	-- UI to select things (files, grep results, open buffers...)
	use({ "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } })
	use("Mofiqul/vscode.nvim") -- Theme inspired by VSCode
	-- Add indentation guides even on blank lines
	use("lukas-reineke/indent-blankline.nvim")
	-- Add git related info in the signs columns and popups
	use({
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("gitsigns").setup({
				-- debug_mode = true,
			})
		end,
	})
	-- Highlight, edit, and navigate code using a fast incremental parsing library
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	-- Additional textobjects for treesitter
	use("nvim-treesitter/nvim-treesitter-textobjects")
	use("neovim/nvim-lspconfig") -- Collection of configurations for built-in LSP client
	use("hrsh7th/nvim-cmp") -- Autocompletion plugin
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/cmp-vsnip")
	use("hrsh7th/vim-vsnip")
	use("rafamadriz/friendly-snippets")
	use({
		"blackCauldron7/surround.nvim",
		config = function()
			require("surround").setup({
				mappings_style = "sandwich",
			})
		end,
	}) -- visual select then s<char>
	use("andymass/vim-matchup")
	use("AndrewRadev/splitjoin.vim") -- trigger: gS and gJ
	use("phaazon/hop.nvim") -- Easymotion
	use("cohama/lexima.vim") -- auto close (brackets) pairs

	use("ray-x/go.nvim") -- Go

	use({
		"windwp/nvim-spectre",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("spectre").setup()
		end,
	}) -- Search and replace

	use({ "jose-elias-alvarez/null-ls.nvim", requires = { "nvim-lua/plenary.nvim" } }) -- for linting and formatting purposes
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})
	use("nvim-lua/lsp-status.nvim")
	use("gennaro-tedesco/nvim-peekup") -- peek at registers
	use("onsails/lspkind-nvim")
	use({ "tzachar/cmp-tabnine", run = "./install.sh", requires = "hrsh7th/nvim-cmp" })

	use({ "akinsho/flutter-tools.nvim", requires = "nvim-lua/plenary.nvim" }) -- Flutter
	use({ "iamcco/markdown-preview.nvim", run = "cd app && yarn install" })
	use("dbeniamine/cheat.sh-vim") -- <leader>KB
end)

--Set highlight on search
vim.o.hlsearch = true

--Make line numbers default
vim.wo.number = true

--Enable mouse mode
vim.o.mouse = "a"

--Enable break indent
vim.o.breakindent = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = "yes"

--After vertical split, select lower pane
--(hozontal splitting, keep default: select left pane)
vim.o.splitbelow = true

vim.o.scrolloff = 5

--Backup, Swap and View Files
--Create dirs
vim.cmd([[
silent execute '!mkdir -p $HOME/.vim/.backup'
silent execute '!mkdir -p $HOME/.vim/.swap'
silent execute '!mkdir -p $HOME/.vim/.views'
silent execute '!mkdir -p $HOME/.vim/.undo'
]])
vim.o.backup = true
vim.o.undofile = true
vim.o.backupdir = os.getenv("HOME") .. "/.vim/.backup/"
vim.o.directory = os.getenv("HOME") .. "/.vim/.swap/"
vim.o.viewdir = os.getenv("HOME") .. "/.vim/.views/"
vim.o.undodir = os.getenv("HOME") .. "/.vim/.undo/"

--Set colorscheme (order is important here)
vim.o.termguicolors = true
vim.g.vscode_style = "dark"
vim.g.vscode_transparent = 1
vim.cmd([[colorscheme vscode]])

--Remap space as leader key
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--Easier cursor navigation between split windows using CTRL and h,j,k, or l
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { noremap = true })
-- Zoom a window by editing it in a new tab
vim.api.nvim_set_keymap("n", "<C-w>z", ":tab sp<CR>", {})

--Buffer mappings
--Remap for dealing with word wrap
vim.api.nvim_set_keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

--Toggle show whitespace characters
vim.o.listchars = "tab:>→,trail:.,precedes:<,extends:>"
vim.api.nvim_set_keymap("n", "<leader>li", ":set list! list?<CR>", { noremap = true })

--Yank to clipboard
vim.api.nvim_set_keymap("n", "y", '"+y', { noremap = true })
vim.api.nvim_set_keymap("v", "y", '"+y', { noremap = true })

--Highlight on yank
vim.cmd([[
augroup YankHighlight
	autocmd!
	autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup end
]])

--Tabs and indentation
vim.o.expandtab = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4

--Map blankline
vim.g.indent_blankline_char = "┊"
vim.g.indent_blankline_filetype_exclude = { "help", "packer" }
vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile" }
vim.g.indent_blankline_show_trailing_blankline_indent = false

--netrw and vim-vinegar setup
vim.cmd([[
noremap <silent> <Leader>e :call ExOpen()<CR>
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

fun! ExOpen()
	let g:last_bufnr = bufnr('%')
	exe "normal \<Plug>VinegarUp"
endf

fun! ExClose()
	if &filetype == "netrw"
		exe ':b' . g:last_bufnr
	endif
endf

augroup netrw
	autocmd!
	autocmd filetype netrw nmap <buffer> <Leader>e :call ExClose()<CR>
	autocmd filetype netrw nmap <buffer> l <CR>
	autocmd filetype netrw nmap <buffer> h <Plug>VinegarUp
augroup END
]])

--Gutentags
vim.g.gutentags_cache_dir = os.getenv("HOME") .. "/.cache/gutentags"

--Telescope
require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<C-u>"] = false,
				["<C-d>"] = false,
			},
		},
	},
})

--Telescope
vim.api.nvim_set_keymap(
	"n",
	"<leader>sb",
	[[<cmd>lua require('telescope.builtin').buffers()<CR>]],
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>sf",
	[[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]],
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>gf",
	[[<cmd>lua require('telescope.builtin').git_files({previewer = false})<CR>]],
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>sz",
	[[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]],
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>sh",
	[[<cmd>lua require('telescope.builtin').help_tags()<CR>]],
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>st",
	[[<cmd>lua require('telescope.builtin').tags()<CR>]],
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>sd",
	[[<cmd>lua require('telescope.builtin').grep_string()<CR>]],
	{ noremap = true, silent = true }
)
-- vim.api.nvim_set_keymap('n', '<leader>sp', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>so', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap(
	"n",
	"<leader>?",
	[[<cmd>lua require('telescope.builtin').oldfiles()<CR>]],
	{ noremap = true, silent = true }
)
-- vim.api.nvim_set_keymap('n', '<leader>f', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], { noremap = true, silent = true })

--Treesitter configuration
--Parsers must be installed manually via :TSInstall
require("nvim-treesitter.configs").setup({
	-- One of "all", "maintained" (parsers with maintainers), or a list of languages
	ensure_installed = "maintained",
	highlight = {
		enable = true, -- false will disable the whole extension
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn",
			node_incremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm",
		},
	},
	indent = {
		enable = true,
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},
		matchup = {
			enable = true, -- mandatory, false will disable the whole extension
			-- disable = { "c", "ruby" },  -- optional, list of language that will be disabled
			-- [options]
		},
	},
})

--Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

--nvim-cmp setup
local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local lspkind = require("lspkind")

local source_mapping = {
	buffer = "[Buffer]",
	nvim_lsp = "[LSP]",
	nvim_lua = "[Lua]",
	cmp_tabnine = "[TN]",
	path = "[Path]",
}

local cmp = require("cmp")
cmp.setup({
	preselect = cmp.PreselectMode.None,
	select = true,
	completion = {
		completeopt = "menu,menuone,noinsert",
	},
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	mapping = {
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif vim.fn["vsnip#available"](1) == 1 then
				feedkey("<Plug>(vsnip-expand-or-jump)", "")
			elseif has_words_before() then
				cmp.complete()
			else
				fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_prev_item()
			elseif vim.fn["vsnip#jumpable"](-1) == 1 then
				feedkey("<Plug>(vsnip-jump-prev)", "")
			end
		end, { "i", "s" }),
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "vsnip" },
		{ name = "buffer" },
		{ name = "cmp_tabnine" },
	},
	formatting = {
		format = function(entry, vim_item)
			vim_item.kind = lspkind.presets.default[vim_item.kind]
			local menu = source_mapping[entry.source.name]
			if entry.source.name == "cmp_tabnine" then
				if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
					menu = entry.completion_item.data.detail .. " " .. menu
				end
				vim_item.kind = ""
			end
			vim_item.menu = menu
			return vim_item
		end,
	},
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

--LSP settings
local lspconfig = require("lspconfig")
local on_attach = function(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	local opts = { noremap = true, silent = true }
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		"gi",
		[[<cmd>lua require('telescope.builtin').lsp_implementations()<CR>]],
		opts
	)
	-- vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", [[<cmd>lua require('telescope.builtin').lsp_references()<CR>]], opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "v", "<space>ca", "<cmd>lua vim.lsp.buf.range_code_action()<CR>", opts)
	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		"<leader>de",
		[[<cmd>lua require('telescope.builtin').diagnostics()<CR>]],
		opts
	)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>df", [[<cmd>lua vim.diagnostic.open_float()<CR>]], opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		"<leader>so",
		[[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]],
		opts
	)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>fo", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

	--Format on save
	if client.resolved_capabilities.document_formatting then
		vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
	end
end

--Hide virtual text for lsp diagnostics, use <leader>df mapping declared above to show them
vim.diagnostic.config({
	virtual_text = false,
})

--nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

--Enable the following language servers
local servers = { "gopls", "terraformls", "rls" }
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

-- lspconfig['dartls'].setup {
--   cmd = { "dart", "language-server" },
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }
--
-- Example custom server
-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lspconfig.sumneko_lua.setup({
	cmd = { "lua-language-server" },
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Setup your lua path
				path = runtime_path,
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})

--hop
require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
-- vim.api.nvim_set_keymap('n', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
-- vim.api.nvim_set_keymap('n', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})
-- vim.api.nvim_set_keymap('o', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<cr>", {})
-- vim.api.nvim_set_keymap('o', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<cr>", {})
-- vim.api.nvim_set_keymap('', 't', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
-- vim.api.nvim_set_keymap('', 'T', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})
vim.api.nvim_set_keymap(
	"n",
	"<leader>w",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR })<cr>",
	{}
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>W",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR })<cr>",
	{}
)

require("nvim_comment").setup()

--Emmet
vim.g.user_emmet_install_global = 0
vim.cmd([[autocmd FileType html,css EmmetInstall]])

--go.nvim
require("go").setup()
-- Import on save
vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]], false)

--Spectre
vim.api.nvim_set_keymap("n", "<leader>ss", "<cmd>lua require'spectre'.open()<cr>", { noremap = true })
vim.api.nvim_set_keymap("v", "<leader>ss", "<cmd>lua require'spectre'.open_visual()<cr>", { noremap = true })
vim.api.nvim_set_keymap(
	"n",
	"<leader>sw",
	"<cmd>lua require'spectre'.open_visual({select_word=true})<cr>",
	{ noremap = true }
)
vim.api.nvim_set_keymap("n", "<leader>sp", "<cmd>lua require'spectre'.open_file_search()<cr>", { noremap = true })

-- null-ls.nvim
local null_ls = require("null-ls")

null_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	debug = true,
	sources = {
		null_ls.builtins.diagnostics.golangci_lint,
		null_ls.builtins.formatting.stylua,
	},
})

--lsp-status
require("lsp-status").config({
	status_symbol = "",
})

--lualine (statusbar)
GetExpandTab = function()
	return vim.o.expandtab and "spaces" or "tabs"
end

require("lualine").setup({
	options = {
		theme = "vscode",
		section_separators = { left = "", right = "" },
		component_separators = { left = "", right = "" },
	},
	sections = {
		lualine_x = { "require'lsp-status'.status()", "GetExpandTab()", "encoding", "fileformat", "filetype" },
	},
})

--nvim-peekup
vim.g.peekup_paste_after = '""'
require("nvim-peekup.config").on_keystroke["delay"] = "1ms"

--flutter-tools
require("flutter-tools").setup({
	lsp = {
		-- cmd = { "dart", "language-server" },
		on_attach = on_attach,
		capabilities = capabilities,
	},
})
