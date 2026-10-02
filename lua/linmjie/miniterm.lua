local M = {}

local compiler_map = {
    lua = 'lua',
    python = 'python3',
    c = 'gcc',
    cpp = 'g++',
}

local needs_run_binary = {
    c = true,
    cpp = true,
}

M.get_run_command = function (file)
    local filetype = vim.bo.filetype
    local compiler = compiler_map[filetype]
    local opt = ''
    if needs_run_binary[filetype] then
        opt = ' && ./a.out'
    end
    if compiler_map[filetype] == nil then
        return ''
    end
    return string.format('%s %s%s', compiler, file, opt)
end

return M
