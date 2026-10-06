local miniterm = require("linmjie.miniterm")

local compiler_map = {
    lua = 'lua',
    python = 'python3',
    c = 'gcc',
    cpp = 'g++',
}

local flags = {
    c = '-Wall -Wextra -fsanitize=address',
    cpp = '-std=c++20 -Wall -Wextra -fsanitize=address -Wno-unused-parameter'
}

local needs_run_binary = {
    c = true,
    cpp = true,
}

local get_run_command = function(file)
    local filetype = vim.bo.filetype
    local compiler = compiler_map[filetype]
    local flag = flags[filetype] or ''
    if flag ~= '' then
        flag = flag .. ' '
    end
    local opt = ''
    if needs_run_binary[filetype] then
        opt = ' && ./a.out'
    end
    if compiler_map[filetype] == nil then
        return ''
    end
    return string.format('%s %s%s%s', compiler, flag, file, opt)
end

vim.api.nvim_create_user_command('Run', function()
    local cmd = get_run_command(vim.api.nvim_buf_get_name(0))
    vim.cmd.w()
    miniterm.open_terminal()
    local id = vim.bo[miniterm.state.floating.buf].channel
    vim.fn.chansend(id, cmd .. '\r')
end, {})
