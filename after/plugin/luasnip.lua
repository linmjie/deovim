local ls = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()

vim.keymap.set({'i', 's'}, "<Tab>", function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, {silent = true})

vim.keymap.set({'i', 's'}, "<C-Tab>", function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, {silent = true})

ls.add_snippets('lua', require("snippets.neovim"))
ls.add_snippets('cpp', require("snippets.basic_function"))
ls.add_snippets('c', require("snippets.basic_function"))
ls.add_snippets('java', require("snippets.basic_function"))
