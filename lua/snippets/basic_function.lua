local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
    s("fn", {
        i(1, 'void'), t(' '), i(2, 'name'), t('('), i(3, '/* params */'), t(') {'),
        t({ '', '\t'}),
        i(4, '//code'),
        t({ '', '}'})
    })
}
