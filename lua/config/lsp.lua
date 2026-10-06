-- lsp
--------------------------------------------------------------------------------
-- See https://gpanders.com/blog/whats-new-in-neovim-0-11/ for a nice overview
-- of how the lsp setup works in neovim 0.11+.

-- This actually just enables the lsp servers.
-- The configuration is found in the lsp folder inside the nvim config folder,
-- so in ~.config/lsp/lua_ls.lua for lua_ls, for example.
vim.lsp.enable('lua_ls')
vim.lsp.enable('clangd')
vim.lsp.enable('jdtls')
vim.lsp.enable('pyright')
vim.lsp.enable('rust-analyzer')

--vim.api.nvim_create_autocmd('LspAttach', {
--  callback = function(ev)
--    local client = vim.lsp.get_client_by_id(ev.data.client_id)
--    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
--      vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup' }
--      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
--      vim.keymap.set('i', '<C-Space>', function()
--        vim.lsp.completion.get()
--      end)
--    end
--  end,
--})
--
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
--local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()
local capabilities = require('blink.cmp').get_lsp_capabilities() --get_lsp_capabilities(cmp_capabilities)

vim.lsp.config('clangd', {
    capabilities = capabilities,
    cmd = { 'clangd', '--header-insertion=iwyu' }
})

vim.lsp.config('rust_analyzer', {
  capabilities = capabilities,
})

vim.lsp.config('lua_ls', {
  capabilities = capabilities,
  settings = {
      Lua = {
      runtime = {
        version = 'LuaJIT', -- Neovim uses LuaJIT
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false,
      },
    },
  }
})

vim.lsp.config('tsserver', {
  capabilities = capabilities,
})

vim.lsp.config('jdtls', {
  capabilities = capabilities,
})

vim.lsp.config('pyright', {
  capabilities = capabilities,
})
