vim.cmd("set number")
vim.cmd("set rnu")
vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set expandtab")

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set('n', 'K', vim.lsp.buf.hover)
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
