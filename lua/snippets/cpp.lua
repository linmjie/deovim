local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local ex = require("luasnip.extras")
local rep = ex.rep

local function smartPointer(type)
    return s(type, {
        t('std::' .. type .. '_ptr<'), i(1, 'T'),
        t('> '), i(2, 'name'),
        t(' = std::make_' .. type .. '<'), rep(1), t('>();')
    })
end

return {
    smartPointer("unique"),
    smartPointer("shared"),

    s("lambda", {
        t('['), i(1, ''), t(']'),
        t('('), i(2, ''), t(')'),
        t('{ return '), i(3, ''), t('; }')
    }),
    s("anonymous_function", {
        t('['), i(1, ''), t(']'),
        t('('), i(2, ''), t(')'),
        t('{'), i(3, ''), t('}')
    })
}
