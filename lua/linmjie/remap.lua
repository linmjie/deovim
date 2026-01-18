vim.cmd("set number")
vim.cmd("set rnu")
vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set expandtab")

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set('n', 'K', vim.lsp.buf.hover)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {})
vim.keymap.set('n', "<leader>rn", vim.lsp.buf.rename, {})
vim.keymap.set('n', "<leader>ca", vim.lsp.buf.code_action)
vim.keymap.set('n', "<leader>gfm", vim.lsp.buf.format, {})

vim.keymap.set('n', "<leader>t", function() vim.cmd('buffer#') end)
vim.keymap.set('v', "<leader>cc", '"+y')

vim.keymap.set('n', "<leader>nov", function()
  local new_config = not vim.diagnostic.config().virtual_lines
  vim.diagnostic.config({ virtual_lines = new_config })
end, { desc = 'Toggle diagnostic virtual_lines' })
vim.keymap.set('n', "<leader>noh", function() vim.cmd('noh') end)

vim.keymap.set("n", "<leader>dt", ":DapToggleBreakpoint<CR>")
vim.keymap.set("n", "<leader>dc", ":DapContinue<CR>")
vim.keymap.set("n", "<leader>dx", ":DapTerminate<CR>")
vim.keymap.set("n", "<leader>dov", ":DapStepOver<CR>")
vim.keymap.set("n", "<leader>dou", ":DapStepOut<CR>")
vim.keymap.set("n", "<leader>din", ":DapStepInto<CR>")

vim.keymap.set('n', "<leader>sb", "i#!/usr/bin/env bash<ESC>")

vim.keymap.set('n', "<leader>el", ":Telescope ")
