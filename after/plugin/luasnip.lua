local ls = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()

ls.add_snippets('cpp', require("snippets.cpp"))

ls.add_snippets('cpp', require("snippets.basic_function"))
ls.add_snippets('c', require("snippets.basic_function"))
ls.add_snippets('java', require("snippets.basic_function"))

ls.add_snippets('python', require("snippets.python"))
ls.add_snippets('lua', require("snippets.neovim"))

-- keymaps
vim.keymap.set({ 'i', 's' }, "<Tab>", function()
    if ls.expand_or_jumpable() then
        return "<Plug>luasnip-expand-or-jump"
    else
        return "<Tab>"
    end
end, { expr = true, silent = true })

vim.keymap.set({ 'i', 's' }, "<S-Tab>", function()
    if ls.jumpable(-1) then
        return "<Plug>luasnip-jump-prev"
    else
        return "<S-Tab>"
    end
end, { expr = true, silent = true })
