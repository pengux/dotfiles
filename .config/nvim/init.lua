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
  use("ludovicchabant/vim-gutentags") -- Automatic tags management
  use("mg979/vim-visual-multi") -- Multiple cursors
  use("godlygeek/tabular") -- Align text
  use("terrortylor/nvim-comment")
  use("mattn/emmet-vim")
  -- UI to select things (files, grep results, open buffers...)
  use({ "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } })
  use { "nvim-telescope/telescope-file-browser.nvim" }
  -- use("Mofiqul/vscode.nvim") -- Theme inspired by VSCode
  use("dracula/vim")
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

  use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })
  use({
    "TimUntersberger/neogit",
    requires = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },
  })

  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
  -- Additional textobjects for treesitter
  use("nvim-treesitter/nvim-treesitter-textobjects")
  use("JoosepAlviste/nvim-ts-context-commentstring")
  use("neovim/nvim-lspconfig") -- Collection of configurations for built-in LSP client
  use("hrsh7th/nvim-cmp") -- Autocompletion plugin
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-cmdline")
  use("hrsh7th/cmp-vsnip")
  use("hrsh7th/vim-vsnip")
  use("rafamadriz/friendly-snippets")
  use("tpope/vim-surround") -- visual select then s<char>, or cs<from><to>
  use("andymass/vim-matchup")
  use("AndrewRadev/splitjoin.vim") -- trigger: gS and gJ
  use("phaazon/hop.nvim") -- Easymotion
  use("cohama/lexima.vim") -- auto close (brackets) pairs

  use("mfussenegger/nvim-dap")
  use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
  use({ "leoluz/nvim-dap-go", requires = { "mfussenegger/nvim-dap" } })

  use("ray-x/guihua.lua") -- float term, codeaction and codelens gui support
  use("ray-x/go.nvim") -- Go

  use({
    "nvim-pack/nvim-spectre",
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
  use("dbeniamine/cheat.sh-vim") -- <leader>KB, <leader>KE to send first error, <leader>l + <leader>h to navigate in cheat buffer
  use({
    "AckslD/nvim-neoclip.lua",
    requires = {
      -- you'll need at least one of these
      { "nvim-telescope/telescope.nvim" },
      -- {'ibhagwan/fzf-lua'},
    },
    config = function()
      require("neoclip").setup()
    end,
  })

  use({ "nvim-orgmode/orgmode" })
  use({ "github/copilot.vim" })
  use({
    "tyru/open-browser-github.vim",
    requires = {
      { "tyru/open-browser.vim" },
    },
  })
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

--Hide ~ at the end of buffer
vim.o.fcs = "eob: "

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
-- vim.g.vscode_style = "dark"
-- vim.g.vscode_transparent = 1
vim.cmd([[colorscheme dracula]])

--Remap space as leader key
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Search selected text
vim.cmd([[
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
]])

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
vim.o.clipboard = "unnamedplus"
-- vim.api.nvim_set_keymap("n", "y", '"+y', { noremap = true })
-- vim.api.nvim_set_keymap("v", "y", '"+y', { noremap = true })

-- Map key for saving changes
vim.api.nvim_set_keymap("n", "<leader>.", ":w<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>q", ":q<CR>", { noremap = true })

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

--Folds
vim.o.foldmethod = 'indent'
vim.o.foldenable = false
-- vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
-- vim.wo.foldcolumn = "1"
-- vim.wo.foldlevel = 99 -- feel free to decrease the value
-- vim.wo.foldenable = true

--Map blankline
vim.g.indent_blankline_char = "┊"
vim.g.indent_blankline_filetype_exclude = { "help", "packer" }
vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile" }
vim.g.indent_blankline_show_trailing_blankline_indent = false

--Gutentags
vim.g.gutentags_cache_dir = os.getenv("HOME") .. "/.cache/gutentags"

--Telescope
local actions_layout = require "telescope.actions.layout"
local fb_actions = require "telescope".extensions.file_browser.actions
local actions = require "telescope.actions"
require("telescope").setup({
  defaults = {
    layout_strategy = "vertical",
    path_display = { "truncate" },
    mappings = {
      i = {
        ["<C-u>"] = false,
        ["<C-d>"] = false,
        ["<C-h>"] = actions_layout.toggle_preview,
      },
    },
  },
  extensions = {
    file_browser = {
      mappings = {
        ["i"] = {
          ["<C-H>"] = fb_actions.toggle_hidden,
          ["<C-h>"] = fb_actions.goto_parent_dir,
          ["<C-l>"] = actions.select_default,
        },
        ["n"] = {
          ["H"] = fb_actions.toggle_hidden,
          ["h"] = fb_actions.goto_parent_dir,
          ["l"] = actions.select_default,
        },
      },
    },
  },
})

require("telescope").load_extension("file_browser")

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
vim.api.nvim_set_keymap(
  "n",
  "<leader>sj",
  [[<cmd>lua require('telescope.builtin').jumplist()<CR>]],
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>p",
  [[<cmd>lua require('telescope').extensions.neoclip.default()<CR>]],
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

vim.api.nvim_set_keymap(
  "n",
  "<space>e",
  ":Telescope file_browser<CR>",
  { noremap = true }
)
-- vim.api.nvim_set_keymap('n', '<leader>f', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], { noremap = true, silent = true })

--Treesitter configuration
--Parsers must be installed manually via :TSInstall
require("nvim-treesitter.configs").setup({
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = "all",
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "org" }, -- Remove this to use TS highlighter for some of the highlights (Experimental)
    additional_vim_regex_highlighting = { "org" }, -- Required since TS highlighter doesn't support all syntax features (conceal)
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
    enable = false, -- EXPERIMENTAL, not working properly yet
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
if cmp then
  cmp.setup({
    preselect = cmp.PreselectMode.None,
    -- select = true,
    -- completion = {
    -- 	completeopt = "menu,menuone,noinsert",
    -- },
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
end

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
    "<leader>si",
    [[<cmd>lua require('telescope.builtin').lsp_implementations({wrap_results=true,show_line=false})<CR>]],
    opts
  )
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "<leader>sr",
    [[<cmd>lua require('telescope.builtin').lsp_references({wrap_results=true,show_line=false})<CR>]],
    opts
  )
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "v", "<leader>ca", "<cmd>lua vim.lsp.buf.range_code_action()<CR>", opts)
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
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>dq", "<cmd>lua vim.diagnostic.setqflist()<CR>", opts)
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
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

--Enable the following language servers
local servers = { "terraformls", "rls", "graphql" }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

lspconfig['gopls'].setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    ["gopls"] = {
      buildFlags = { "-tags=integration" },
    },
  },
}

lspconfig['html'].setup {
  cmd = { "vscode-html-languageserver", "--stdio" },
  on_attach = on_attach,
  capabilities = capabilities,
}

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
vim.api.nvim_set_keymap(
  "v",
  "<leader>w",
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR })<cr>",
  {}
)
vim.api.nvim_set_keymap(
  "v",
  "<leader>W",
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR })<cr>",
  {}
)

require("nvim_comment").setup()

--Emmet
vim.g.user_emmet_install_global = 0
vim.cmd([[autocmd FileType html,css,php EmmetInstall]])

--nvim-dap
local dap = require("dap")
dap.defaults.fallback.external_terminal = {
  command = "/usr/bin/alacritty",
  args = { "-e" },
}
vim.api.nvim_set_keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>dr", "<cmd>lua require'dap'.run_to_cursor()<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>dsu", "<cmd>lua require'dap'.step_out()<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", { noremap = true })
vim.api.nvim_set_keymap("v", "<leader>de", "<cmd>lua require'dapui'.eval()<cr>", { noremap = true })

dap.adapters.dlv_spawn = function(cb)
  local stdout = vim.loop.new_pipe(false)
  local handle
  local pid_or_err
  local port = 38697
  local opts = {
    stdio = { nil, stdout },
    args = { "dap", "-l", "127.0.0.1:" .. port },
    detached = true,
  }
  handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
    stdout:close()
    handle:close()
    if code ~= 0 then
      print("dlv exited with code", code)
    end
  end)
  assert(handle, "Error running dlv: " .. tostring(pid_or_err))
  stdout:read_start(function(err, chunk)
    assert(not err, err)
    if chunk then
      vim.schedule(function()
        --- You could adapt this and send `chunk` to somewhere else
        require("dap.repl").append(chunk)
      end)
    end
  end)
  -- Wait for delve to start
  vim.defer_fn(function()
    cb({ type = "server", host = "127.0.0.1", port = port })
  end, 100)
end

dap.configurations.go = {
  {
    type = "dlv_spawn",
    name = "Launch dlv & file",
    request = "launch",
    program = "${file}",
  },
}

--nvim-dap-ui
local dapui = require("dapui")
dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open("tray")
end
-- dap.listeners.before.event_terminated["dapui_config"] = function()
-- 	dapui.close()
-- end
-- dap.listeners.before.event_exited["dapui_config"] = function()
-- 	dapui.close()
-- end

--nvim-dap-go
require("dap-go").setup()

--go.nvim
require("go").setup({
  dap_debug_keymap = true,
  run_in_floaterm = true,
  -- tag_transform = true,
})
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
  sources = {
    null_ls.builtins.diagnostics.golangci_lint,
    -- null_ls.builtins.formatting.stylua,
    -- null_ls.builtins.formatting.dart_format,
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
    theme = "dracula",
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
    globalstatus = true,
  },
  sections = {
    lualine_x = { "require'lsp-status'.status()", "GetExpandTab()", "encoding", "fileformat", "filetype" },
  },
})

--nvim-peekup
-- vim.g.peekup_open = '<leader>"'
require("nvim-peekup.config").on_keystroke["delay"] = "1ms"

--flutter-tools
require("flutter-tools").setup({
  debugger = {
    enabled = true,
  },
  lsp = {
    cmd = { "dart", "language-server" },
    on_attach = on_attach,
    capabilities = capabilities,
  },
})

--neogit
require("neogit").setup({
  disable_commit_confirmation = true,
  integrations = {
    diffview = true,
  },
})
vim.api.nvim_set_keymap("n", "<leader>gg", "<cmd>Neogit<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>gl", "<cmd>Neogit log<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>gp", "<cmd>Neogit push<cr>", { noremap = true })

--orgmode
require("orgmode").setup({
  org_agenda_files = { "~/org/*" },
  org_default_notes_file = "~/org/refile.org",
})
require("orgmode").setup_ts_grammar()

--github copilot
vim.cmd([[
imap <silent><script><expr> <C-x> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true
]])
