local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
    s("snippets", {
        t({
            'local ls = require("luasnip")',
            'local s = ls.snippet',
            'local t = ls.text_node',
            'local i = ls.insert_node',
            '',
            'return {',
            '\t'
        }),
        i(1, '--snippets'),
        t({'', '}'})
    })
}
