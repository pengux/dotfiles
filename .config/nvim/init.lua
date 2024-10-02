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

  -- util packages
  use("nvim-lua/plenary.nvim")
  use { "nvim-neotest/nvim-nio" }

  use("tpope/vim-sleuth")   -- Autodetect indentation settings
  use("tpope/vim-fugitive") -- Git commands in nvim
  use 'nvim-tree/nvim-web-devicons'
  use("echasnovski/mini.nvim")
  use("tpope/vim-unimpaired")
  use("mg979/vim-visual-multi") -- Multiple cursors
  use("godlygeek/tabular")      -- Align text
  use("mattn/emmet-vim")
  use("dhruvasagar/vim-table-mode")
  -- UI to select things (files, grep results, open buffers...)
  use({ "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } })
  use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })
  use {
    'TimUntersberger/neogit',
    requires = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },
  }

  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
  -- Additional textobjects for treesitter
  use("nvim-treesitter/nvim-treesitter-textobjects")
  use("JoosepAlviste/nvim-ts-context-commentstring")
  use("neovim/nvim-lspconfig") -- Collection of configurations for built-in LSP client
  use("hrsh7th/nvim-cmp")      -- Autocompletion plugin
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-cmdline")
  use("L3MON4D3/LuaSnip")
  use("saadparwaiz1/cmp_luasnip")
  use("rafamadriz/friendly-snippets")
  use("andymass/vim-matchup")
  use({
    'Wansmer/treesj',
    requires = { 'nvim-treesitter/nvim-treesitter' }, -- if you install parsers with `nvim-treesitter`
    config = function()
      local langs = require('treesj.langs').presets

      -- Add fallback to all language
      for _, nodes in pairs(langs) do
        nodes.comment = {
          both = {
            fallback = function(tsn)
              -- mini.splitjoin returns `nil` if nothing to toggle
              local res = require('mini.splitjoin').toggle()

              if not res then
                vim.cmd('normal! gww')
              end
            end,
          },
        }
      end

      require('treesj').setup({})
    end,
  })

  use("mfussenegger/nvim-dap")
  use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
  use({ "leoluz/nvim-dap-go", requires = { "mfussenegger/nvim-dap" } })

  use("ray-x/go.nvim") -- Go
  use("simrat39/rust-tools.nvim")

  use("nvim-lua/lsp-status.nvim")
  use("gennaro-tedesco/nvim-peekup") -- peek at registers
  use("onsails/lspkind-nvim")
  use({ "tzachar/cmp-tabnine", run = "./install.sh", requires = "hrsh7th/nvim-cmp" })

  use({ "akinsho/flutter-tools.nvim", requires = "nvim-lua/plenary.nvim" }) -- Flutter
  use({ "iamcco/markdown-preview.nvim", run = "cd app && yarn install" })
  use("dbeniamine/cheat.sh-vim")                                            -- <leader>KB, <leader>KE to send first error, <leader>l + <leader>h to navigate in cheat buffer
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

  use({ "github/copilot.vim" })
  -- use {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   event = "InsertEnter",
  --   config = function()
  --     require("copilot").setup({
  --       filetypes = {
  --         go = true,
  --       },
  --       -- suggestion = { enabled = false },
  --       -- panel = { enabled = false },
  --     })
  --   end,
  -- }
  -- use {
  --   "zbirenbaum/copilot-cmp",
  --   after = { "copilot.lua" },
  --   config = function()
  --     require("copilot_cmp").setup()
  --   end
  -- }
  use({
    "tyru/open-browser-github.vim",
    requires = {
      { "tyru/open-browser.vim" },
    },
  })
  use({ "samjwill/nvim-unception" }) -- opening files in terminal in same instance of neovim
  use { "catppuccin/nvim", as = "catppuccin" }

  use({ "akinsho/toggleterm.nvim" })
  use(
    {
      "lmburns/lf.nvim",
      requires = { "plenary.nvim", "toggleterm.nvim" }
    }
  )
  -- use({ "joechrisellis/lsp-format-modifications.nvim" })
  use {
    "SmiteshP/nvim-navbuddy",
    requires = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
      "numToStr/Comment.nvim",        -- Optional
      "nvim-telescope/telescope.nvim" -- Optional
    }
  }
  use {
    'tanvirtin/vgit.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    }
  }
  use {
    'marcelofern/vale.nvim'
  }
  use {
    'David-Kunz/gen.nvim'
  }
  use({
    "aserowy/tmux.nvim",
    config = function() return require("tmux").setup({
      navigation = {
        enable_default_keybindings = false,
      },
    }) end
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
vim.o.background = "dark"
vim.cmd([[colorscheme catppuccin]])
vim.cmd.highlight({ "Cursor", "guibg=reverse", "guifg=NONE" })

-- Search selected text
vim.cmd([[
vnoremap // y/\V<C-R>=escape(@",'/\')<cr><cr>
]])

local keymap_opts = { noremap = true, silent = true }

-- Yank to clipboard
vim.o.clipboard = "unnamedplus"

--Remap space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set("", "<Space>", "<Nop>", keymap_opts)

--Toggle show whitespace characters
vim.o.listchars = "tab:>~,trail:.,precedes:<,extends:>"
vim.keymap.set("n", "<leader>li", ":set list! list?<cr>", keymap_opts)

-- Easier cursor navigation between split windows using CTRL and h,j,k, or l
-- vim.keymap.set("n", "<C-h>", "<C-w>h", keymap_opts)
-- vim.keymap.set("n", "<C-j>", "<C-w>j", keymap_opts)
-- vim.keymap.set("n", "<C-k>", "<C-w>k", keymap_opts)
-- vim.keymap.set("n", "<C-l>", "<C-w>l", keymap_opts)
-- Zoom a window by editing it in a new tab
vim.keymap.set("n", "<C-h>", "<cmd>lua require'tmux'.move_left()<cr>", keymap_opts)
vim.keymap.set("n", "<C-j>", "<cmd>lua require'tmux'.move_bottom()<cr>", keymap_opts)
vim.keymap.set("n", "<C-k>", "<cmd>lua require'tmux'.move_top()<cr>", keymap_opts)
vim.keymap.set("n", "<C-l>", "<cmd>lua require'tmux'.move_right()<cr>", keymap_opts)
vim.keymap.set("n", "<C-w>z", ":tab sp<cr>", {})

-- Buffer mappings
-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Map key for saving changes
vim.keymap.set("n", "<leader>.", ":w<cr>", keymap_opts)
vim.keymap.set("n", "<leader>q", ":q<cr>", keymap_opts)

-- Buffers navigation
vim.keymap.set("n", "<S-l>", ":bnext<cr>", keymap_opts)
vim.keymap.set("n", "<S-h>", ":bprevious<cr>", keymap_opts)
-- delete all buffers except for the active one
vim.keymap.set("n", "<leader>bD", [[:%bdelete|edit #|normal `"<cr>]], keymap_opts)

-- Tabs navigation
vim.keymap.set("n", "<A-h>", ":tabprev<cr>", keymap_opts)
vim.keymap.set("n", "<A-l>", ":tabnext<cr>", keymap_opts)
vim.keymap.set("n", "<A-c>", ":tabnew<cr>", keymap_opts)

-- Terminal mappings
vim.keymap.set("t", "<ESC>", [[<C-\><C-n>]], keymap_opts)
vim.keymap.set("n", "<leader>cc", ":term<cr>A", keymap_opts)
vim.keymap.set("n", "<leader>cs", ":split<cr>:wincmd j<cr>:term<cr>A", keymap_opts)
vim.keymap.set("n", "<leader>ct", ":tabnew<cr>:term<cr>A", keymap_opts)
vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], keymap_opts)
vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], keymap_opts)
vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]], keymap_opts)
vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]], keymap_opts)

-- Remap clipboard paste in command mode
vim.keymap.set("i", '<A-v>', [[<C-r>+]], keymap_opts)
vim.keymap.set("c", '<A-v>', [[<C-r>+]], keymap_opts)

-- Diagnostic navigation
vim.keymap.set("n", "<leader>df", vim.diagnostic.open_float, keymap_opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, keymap_opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, keymap_opts)
vim.keymap.set("n", "<leader>dq", vim.diagnostic.setqflist, keymap_opts)

-- Highlight on yank
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

-- Mini
require('mini.ai').setup()
require('mini.align').setup()
require('mini.splitjoin').setup()

local mini_bufremove = require("mini.bufremove")
mini_bufremove.setup({})
vim.keymap.set("n", "<leader>bd", mini_bufremove.delete, keymap_opts)

require('mini.comment').setup({})

local mini_jump2d = require('mini.jump2d')
mini_jump2d.setup({
  mappings = {
    start_jumping = '',
  },
})
vim.keymap.set({ "n", "v" }, "m",
  function()
    if vim.bo.buftype == "quickfix" then
      vim.cmd [[execute "normal! \<CR>"]]
    else
      mini_jump2d.start(mini_jump2d.builtin_opts.single_character)
    end
  end, keymap_opts)
vim.cmd [[hi MiniJump2dSpot gui=undercurl,bold,italic]]

require('mini.pairs').setup({})

require('mini.starter').setup({})

local mini_surround = require('mini.surround')
mini_surround.setup({})
vim.keymap.set("v", "S", function() return mini_surround.add('visual') end, keymap_opts)

require('mini.tabline').setup({})

GetExpandTab = function()
  return vim.o.expandtab and "." or "→"
end

require('mini.statusline').setup({
  -- Content of statusline as functions which return statusline string. See
  -- `:h statusline` and code of default contents (used instead of `nil`).
  content = {
    -- Content for active window
    active = function()
      local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
      local git           = MiniStatusline.section_git({ trunc_width = 75 })
      local diagnostics   = MiniStatusline.section_diagnostics({ trunc_width = 75 })
      local filename      = MiniStatusline.section_filename({ trunc_width = 140 })
      local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 120 })
      local expandTab     = GetExpandTab()

      return MiniStatusline.combine_groups({
        { hl = mode_hl,                 strings = { mode } },
        { hl = 'MiniStatuslineDevinfo', strings = { git, diagnostics } },
        '%<', -- Mark general truncate point
        { hl = 'MiniStatuslineFilename', strings = { filename } },
        '%=', -- End left alignment
        { hl = 'MiniStatuslineFileinfo', strings = { expandTab, fileinfo } },
      })
    end,
    -- Content for inactive window(s)
    inactive = nil,
  },
  -- Whether to use icons by default
  use_icons = true,
  -- Whether to set Vim's settings for statusline (make it always shown with
  -- 'laststatus' set to 2). To use global statusline in Neovim>=0.7.0, set
  -- this to `false` and 'laststatus' to 3.
  set_vim_settings = true,
})

--Telescope
local telescope = require('telescope')
local actions_layout = require "telescope.actions.layout"
local telescope_builtin = require('telescope.builtin')
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
})

--Telescope
vim.keymap.set("n", "<leader>sb", telescope_builtin.buffers, keymap_opts)
vim.keymap.set("n", "<leader>sf", function() return telescope_builtin.find_files({ previewer = false }) end, keymap_opts)
vim.keymap.set("n", "<leader>gf", function() return telescope_builtin.git_files({ previewer = false }) end, keymap_opts)
vim.keymap.set("n", "<leader>sz", telescope_builtin.current_buffer_fuzzy_find, keymap_opts)
vim.keymap.set("n", "<leader>sh", telescope_builtin.help_tags, keymap_opts)
vim.keymap.set("n", "<leader>so", telescope_builtin.current_buffer_tags, keymap_opts)
vim.keymap.set({ "n", "v" }, "<leader>sd", telescope_builtin.grep_string, keymap_opts)
vim.keymap.set("n", "<leader>sj", telescope_builtin.jumplist, keymap_opts)
vim.keymap.set({ "n", "v" }, "<leader>p", telescope.extensions.neoclip.default, keymap_opts)
vim.keymap.set("n", "<leader>sg", telescope_builtin.live_grep, keymap_opts)
vim.keymap.set("n", "<leader>?", telescope_builtin.oldfiles, keymap_opts)
vim.keymap.set("n", "<leader>de", telescope_builtin.diagnostics, keymap_opts)

--Treesitter configuration
--Parsers must be installed manually via :TSInstall
require 'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = "all",

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = false,

  ignore_install = {},
  modules = {},

  highlight = {
    enable = true,
  },
}

--Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

--nvim-cmp setup
local lspkind = require("lspkind")

local source_mapping = {
  buffer = "[Buffer]",
  nvim_lsp = "[LSP]",
  nvim_lua = "[Lua]",
  cmp_tabnine = "[TN]",
  path = "[Path]",
}

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")
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
        -- vim.fn["vsnip#anonymous"](args.body)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    mapping = {
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete({}),
      ["<C-e>"] = cmp.mapping.close(),
      ["<cr>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
      }),
      -- ["<Tab>"] = cmp.mapping(function(fallback)
      --   if cmp.visible() then
      --     cmp.select_next_item()
      --   elseif vim.fn["vsnip#available"](1) == 1 then
      --     feedkey("<Plug>(vsnip-expand-or-jump)", "")
      --   elseif has_words_before() then
      --     cmp.complete()
      --   else
      --     fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      --   end
      -- end, { "i", "s" }),
      -- ["<S-Tab>"] = cmp.mapping(function()
      --   if cmp.visible() then
      --     cmp.select_prev_item()
      --   elseif vim.fn["vsnip#jumpable"](-1) == 1 then
      --     feedkey("<Plug>(vsnip-jump-prev)", "")
      --   end
      -- end, { "i", "s" }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
          -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
          -- they way you will only jump inside the snippet region
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),

      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    },
    sources = {
      { name = "nvim_lsp" },
      -- { name = "vsnip" },
      { name = 'luasnip' }, -- For luasnip users.
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

-- navbuddy
local navbuddy = require("nvim-navbuddy")
navbuddy.setup {
  lsp = {
    preference = { "gopls" },
  }
}
vim.keymap.set("n", "<leader>t", "<cmd>Navbuddy<cr>", keymap_opts)

--LSP settings
local lspconfig = require("lspconfig")
local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  local opts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "<leader>so", telescope_builtin.lsp_document_symbols, opts)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>si",
    function() return telescope_builtin.lsp_implementations({ wrap_results = true, show_line = false }) end, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>sr",
    function() return telescope_builtin.lsp_references({ wrap_results = true, show_line = false }) end, opts)
  vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>fo", function() return vim.lsp.buf.format({ async = false }) end, opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)

  --Format on save
  -- print(vim.inspect(client.server_capabilities))
  -- exclude gopls for documentRangeFormattingProvider because of https://github.com/golang/go/issues/31150
  -- if client.server_capabilities.documentRangeFormattingProvider then
  --   local lsp_format_modifications = require "lsp-format-modifications"
  --   lsp_format_modifications.attach(client, bufnr, { format_on_save = true })
  -- elseif client.server_capabilities.documentFormattingProvider then
  --   vim.cmd("autocmd BufWritePre (InsertLeave?) <buffer> lua vim.lsp.buf.format({ async = false })")
  -- end

  if client.server_capabilities.documentSymbolProvider then
    navbuddy.attach(client, bufnr)
  end
end

-- Format on save using LSP
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.js,*.jsx,*.ts,*.tsx,*.dart,*.html,*.css,*.json,*.yaml,*.yml",
  callback = function()
    vim.lsp.buf.format({ async = false })
  end
})

--Hide virtual text for lsp diagnostics, use <leader>df mapping declared above to show them
vim.diagnostic.config({
  virtual_text = false,
})

--nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

--Enable the following language servers
local servers = { "terraformls", "graphql", "golangci_lint_ls", "eslint", "tsserver", "jsonnet_ls", "marksman" }
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
-- local runtime_path = vim.split(package.path, ";")
-- table.insert(runtime_path, "lua/?.lua")
-- table.insert(runtime_path, "lua/?/init.lua")

lspconfig.lua_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        -- path = runtime_path,
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

lspconfig.pylsp.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

--Emmet
vim.g.user_emmet_install_global = 0
vim.cmd([[autocmd FileType html,css,php EmmetInstall]])

--nvim-dap
local dap = require("dap")

vim.keymap.set("n", "<leader>dc", dap.continue, keymap_opts)
vim.keymap.set("n", "<leader>dr", dap.run_to_cursor, keymap_opts)
vim.keymap.set("n", "<leader>do", dap.step_over, keymap_opts)
vim.keymap.set("n", "<leader>di", dap.step_into, keymap_opts)
vim.keymap.set("n", "<leader>dsu", dap.step_out, keymap_opts)
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, keymap_opts)

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
  dapui.open({})
end
-- dap.listeners.before.event_terminated["dapui_config"] = function()
-- 	dapui.close()
-- end
-- dap.listeners.before.event_exited["dapui_config"] = function()
-- 	dapui.close()
-- end
--
vim.keymap.set("n", "<leader>du", dapui.toggle, keymap_opts)
vim.keymap.set("v", "<leader>de", dapui.eval, keymap_opts)


--nvim-dap-go
require("dap-go").setup()

--go.nvim
require("go").setup({
  dap_debug_keymap = true,
  run_in_floaterm = true,
  -- tag_transform = true,
})

--lsp-status
require("lsp-status").config({
  status_symbol = "",
})

--nvim-peekup
-- vim.g.peekup_open = '<leader>"'
require("nvim-peekup.config").on_keystroke["delay"] = "1ms"

--flutter-tools
require("flutter-tools").setup({
  debugger = {
    enabled = true,
    run_via_dap = true,
  },
  lsp = {
    cmd = { "dart", "language-server" },
    on_attach = on_attach,
    capabilities = capabilities,
  },
})

-- --neogit
require("neogit").setup({
  disable_commit_confirmation = true,
  integrations = {
    diffview = true,
  },
})
vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<cr>", keymap_opts)
vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", keymap_opts)
vim.keymap.set("n", "<leader>gl", "<cmd>Neogit log<cr>", keymap_opts)
vim.keymap.set("n", "<leader>gp", "<cmd>Neogit push<cr>", keymap_opts)

-- Lazygit
local Terminal = require('toggleterm.terminal').Terminal
local lazygit  = Terminal:new({
  cmd = "lazygit",
  hidden = true,
  direction = "float",
})

function _lazygit_toggle()
  lazygit:toggle()
end

vim.keymap.set("n", "<leader>gg", "<cmd>lua _lazygit_toggle()<CR>", keymap_opts)

-- lf
-- This feature will not work if the plugin is lazy-loaded
-- vim.g.lf_netrw = 1
require("lf").setup({
  border = "rounded",
  winblend = 0,
  direction = "float",
  -- highlights = {
  --   Normal = {guibg = "none"},
  --   NormalFloat = {guibg = "none"},
})

vim.keymap.set("n", "<leader>e", "<cmd>Lf<cr>", keymap_opts)

-- rust tools
local rust_tools = require("rust-tools")
rust_tools.setup({
  server = {
    on_attach = on_attach,
  },
})

--github copilot
vim.cmd([[
imap <silent><script><expr> <C-x> copilot#Accept("\<cr>")
let g:copilot_no_tab_map = v:true
""""]])

-- Voice to text with whisper
vim.keymap.set("n", "<leader>v", ":r !vtt<cr>", keymap_opts)
vim.keymap.set("n", "<leader>vsv", ":r !vtt Swedish<cr>", keymap_opts)
vim.keymap.set("n", "<leader>vvn", ":r !vtt Vietnamese<cr>", keymap_opts)

-- vgit
require('vgit').setup({
  settings = {
    live_blame = {
      enabled = false,
    }
  }
})

-- vale
require("vale").setup({
  -- path to the vale binary.
  bin = "/usr/bin/vale",
  -- path to your vale-specific configuration.
  vale_config_path = "$HOME/.config/vale/vale.ini",
})

require('gen').setup({
  model = "zephyr",       -- The default model to use.
  host = "localhost",     -- The host running the Ollama service.
  port = "11434",         -- The port on which the Ollama service is listening.
  display_mode = "float", -- The display mode. Can be "float" or "split".
  show_prompt = false,    -- Shows the Prompt submitted to Ollama.
  show_model = false,     -- Displays which model you are using at the beginning of your chat session.
  no_auto_close = false,  -- Never closes the window automatically.
  init = function(options) pcall(io.popen, "ollama serve > /dev/null 2>&1 &") end,
  -- Function to initialize Ollama
  command = function(options)
    return "curl --silent --no-buffer -X POST http://" .. options.host .. ":" .. options.port .. "/api/generate -d $body"
  end,
  -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
  -- This can also be a command string.
  -- The executed command must return a JSON object with { response, context }
  -- (context property is optional).
  -- list_models = '<omitted lua function>', -- Retrieves a list of model names
  debug = false -- Prints errors and the command which is run.
})
vim.keymap.set({ 'n', 'v' }, '<leader>ai', ':Gen<CR>', keymap_opts)

-- treesj
local langs = require 'treesj.langs'['presets']

vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = '*',
  callback = function()
    local opts = { buffer = true }
    if langs[vim.bo.filetype] then
      vim.keymap.set({ "n", "v" }, 'gS', '<Cmd>TSJSplit<CR>', opts)
      vim.keymap.set({ "n", "v" }, 'gJ', '<Cmd>TSJJoin<CR>', opts)
    else
      vim.keymap.set({ "n", "v" }, 'gS', MiniSplitjoin.split, opts)
      vim.keymap.set({ "n", "v" }, 'gJ', MiniSplitjoin.join, opts)
    end
  end,
})
