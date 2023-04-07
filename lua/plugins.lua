local status, packer = pcall(require, 'packer')
if (not status) then
  print("Packer is not installed")
  return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  use {
    'svrana/neosolarized.nvim',
    requires = { 'tjdevries/colorbuddy.nvim' }
  }
  use 'kyazdani42/nvim-web-devicons' -- File icons
  use 'glepnir/lspsaga.nvim'         -- LSP UIs
  use 'L3MON4D3/LuaSnip'             -- Snipppet
  use 'hoob3rt/lualine.nvim'         -- Statusline
  use 'onsails/lspkind-nvim'         -- vscode-like pictograms

  use 'hrsh7th/cmp-buffer'           -- nvim-cmp source for buffer words
  use 'hrsh7th/cmp-nvim-lsp'         -- nvim-cmp source for neovim's built-in LSP
  use 'hrsh7th/nvim-cmp'             -- Completion

  use 'neovim/nvim-lspconfig'        -- LSP

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  use({
    "jose-elias-alvarez/null-ls.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("after.plugin.null-ls.rc")
    end,
  })                              -- Use Neovim as a language serer to inject LSP diagnostic, code actions, and more via Lua
  use 'MunifTanjim/prettier.nvim' -- Prettier plugin for Neovim's built-in LSP client

  use 'windwp/nvim-autopairs'
  use 'windwp/nvim-ts-autotag'

  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'              -- Common utilities
  use 'nvim-telescope/telescope-file-browser.nvim' --

  use 'akinsho/nvim-bufferline.lua'
  use 'norcalli/nvim-colorizer.lua'

  use 'lewis6991/gitsigns.nvim'
  use 'dinhhuy258/git.nvim'

  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'

  --use "junegunn/vim-plug"                         -- Plugin manager
  use { "neoclide/coc.nvim", branch = 'release' } -- COC

  use { "fatih/vim-go" }

  use { "akinsho/toggleterm.nvim", tag = '*' }

  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' }, -- Required
      {
        -- Optional
        'williamboman/mason.nvim',
        run = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },     -- Required
      { 'hrsh7th/cmp-nvim-lsp' }, -- Required
      { 'L3MON4D3/LuaSnip' },     -- Required
    }
  }

  use({
    "hrsh7th/nvim-cmp",
    requires = {
      "onsails/lspkind-nvim",     -- Icons on the popups
      "hrsh7th/cmp-nvim-lsp",     -- LSP source for nvim-cmp
      "saadparwaiz1/cmp_luasnip", -- Snippets source
      "L3MON4D3/LuaSnip",         -- Snippet engine
    },
    config = function()
      require("after.plugin.cmp.rc")
    end
  })
end)

require("toggleterm").setup {
  direction = "horizontal",
  size = 15,
  open_mapping = [[<C-j>]]
}

local lsp = require("lsp-zero")

lsp.preset("recommended")
lsp.ensure_installed({
  "tsserver",
  "gopls",
  "eslint",
  "rust_analyzer"
})
lsp.set_preferences({
  sign_icons = {}
})
lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }
  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
end)
lsp.setup()
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    signs = false,
    virtual_text = true,
    underline = false,
  }
)
