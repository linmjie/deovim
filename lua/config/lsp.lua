-- lsp
--------------------------------------------------------------------------------
-- See https://gpanders.com/blog/whats-new-in-neovim-0-11/ for a nice overview
-- of how the lsp setup works in neovim 0.11+.

-- This actually just enables the lsp servers.
-- The configuration is found in the lsp folder inside the nvim config folder,
-- so in ~.config/lsp/lua_ls.lua for lua_ls, for example.
vim.lsp.enable('lua_ls')
vim.lsp.enable('clangd')
vim.lsp.enable('rust-analyzer')

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
      vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup' }
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
      vim.keymap.set('i', '<C-Space>', function()
        vim.lsp.completion.get()
      end)
    end
  end,
})

-- Diagnostics
vim.diagnostic.config({
  -- Use the default configuration
  -- virtual_lines = true

  -- Alternatively, customize specific options
  virtual_lines = true
    -- Only show virtual line diagnostics for the current cursor line
    --current_line = true,
})

--custom
local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.config(
    'clangd',
        {
            filetypes = {'c', 'cpp'},
            capabilities = capabilities,
            ...  -- other lspconfig configs
        },
    'rust-analyzer',
        {
            capabilities = capabilities
        },
    'lua-ls',
        {
            capabilities = capabilities
        },
    'ts-ls',
        {
            capabilities = capabilities
        },
    'jdtls',
        {
            capabilities = capabilities
        },
    'pyright',
        {
            capabilities = capabilities
        }
)

