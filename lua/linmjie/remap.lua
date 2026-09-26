vim.cmd("set number")
vim.cmd("set rnu")
vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set expandtab")
vim.cmd("set nowrap")

vim.g.mapleader = " "

-- exit from file to directory
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set('n', 'K', vim.lsp.buf.hover)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {})
vim.keymap.set('n', "<leader>rn", vim.lsp.buf.rename, {})
vim.keymap.set('n', "<leader>ca", vim.lsp.buf.code_action)
vim.keymap.set('n', "<leader>gfm", vim.lsp.buf.format, {})

-- switching to last open file (Alt-tab kinda)
vim.keymap.set('n', "<leader>t", function() vim.cmd('buffer#') end)

-- paste to system clipboard
vim.keymap.set('v', "<leader>cc", '"+y')

-- default lsp behavior is that errors pop on new lines, this toggles that
vim.keymap.set('n', "<leader>nov", function()
    local new_config = not vim.diagnostic.config().virtual_lines
    vim.diagnostic.config({ virtual_lines = new_config })
end, { desc = 'Toggle diagnostic virtual_lines' })

vim.keymap.set('n', "<leader>cn", function() vim.diagnostic.jump({count = 1}) end)
vim.keymap.set('n', "<leader>cb", function() vim.diagnostic.jump({count = -1}) end)

vim.keymap.set('n', "<leader>noi", function()
    local clangd_client = vim.lsp.get_clients({ name = 'clangd' })[1]
    if not clangd_client then return end
    local clangd_cmd = clangd_client.config.cmd
    local header_insertion = clangd_cmd[2]
    if header_insertion == '--header-insertion=iwyu' then
        clangd_cmd[2] = '--header-insertion=never'
    elseif header_insertion == '--header-insertion=never' then
        clangd_cmd[2] = '--header-insertion=iwyu'
    end
    vim.cmd('lsp restart clangd')
    -- hardcoding substring index cuz there's not built in split
    print('Automatic header insertion: ' .. string.sub(clangd_cmd[2], 20))
end)

-- disabling highlighting
vim.keymap.set('n', "<leader>noh", function() vim.cmd('noh') end)

-- debug utils, neovim is kinda terrible with debuggers though
vim.keymap.set("n", "<leader>dt", ":DapToggleBreakpoint<CR>")
vim.keymap.set("n", "<leader>dc", ":DapContinue<CR>")
vim.keymap.set("n", "<leader>dx", ":DapTerminate<CR>")
vim.keymap.set("n", "<leader>dov", ":DapStepOver<CR>")
vim.keymap.set("n", "<leader>dou", ":DapStepOut<CR>")
vim.keymap.set("n", "<leader>din", ":DapStepInto<CR>")

vim.keymap.set('n', "<leader>sb", "i#!/usr/bin/env bash<ESC>")

vim.keymap.set('n', "<leader>el", ":Telescope ")

vim.keymap.set('n', '<leader>jup', ':Jupynvim')
