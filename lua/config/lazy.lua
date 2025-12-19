-- Bootstrap lazy.nvim
vim.opt.termguicolors = false
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim

require("lazy").setup(
    {
  spec = {
    -- import your plugins
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    {
        'nvim-telescope/telescope.nvim', tag = 'v0.1.9',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {'nvim-telescope/telescope-ui-select.nvim',
        config = function()
            require("telescope").setup {
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown {}}}}
            require("telescope").load_extension("ui-select")
        end
    },
    {"nvim-treesitter/nvim-treesitter", branch = 'master', lazy = false, build = ":TSUpdate"},
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" }
    },
    {
        "mason-org/mason.nvim",
        opts = {}
    },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {},
        dependencies = {
        { "mason-org/mason.nvim", opts = {} },
             "neovim/nvim-lspconfig",
        },
    },
    { "nvim-tree/nvim-web-devicons", opts = {} },
    {
        'nvim-lualine/lualine.nvim',
        options =
        {
            icons_enabled = true,
            theme = 'dracula'
        },
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    {
        "nvimtools/none-ls.nvim",
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                source = {
                    null_ls.builtins.formatting.stylua,
                }
            })
        end
    },


    --SNIPPETS
    {
        "hrsh7th/cmp-nvim-lsp",
    },
    {
        'L3MON4D3/LuaSnip',
        dependencies = {
            'saadparwaiz1/cmp_luasnip',
            'rafamadriz/friendly-snippets'
        }
    },
    {
    "hrsh7th/nvim-cmp",
    config = function()
        local cmp = require("cmp")
        require("luasnip.loaders.from_vscode").lazy_load()
            cmp.setup({
                snippet = {
                  -- REQUIRED - you must specify a snippet engine
                  expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                  end,
                },
                window = {
                  --completion = cmp.config.window.bordered(),
                  documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                  ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                  ['<C-f>'] = cmp.mapping.scroll_docs(4),
                  ['<C-Space>'] = cmp.mapping.complete(),
                  ['<C-e>'] = cmp.mapping.abort(),
                  ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),
                sources = cmp.config.sources({
                  --{ name = 'nvim_lsp' },
                  { name = 'luasnip' }, -- For luasnip users.
                }, {
                  { name = 'buffer' },
                })
              })
    end
    }

  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

require("catppuccin").setup()
require("lualine").setup()
vim.cmd.colorscheme "catppuccin"
