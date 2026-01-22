local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local function basicPrint(shortcut, str)
    return s(shortcut, fmt([[System.out.{}({});]], {
        t(str), i(1)
    }))
end

local function methodReference(shortcut, method)
    return s(shortcut, t('System.out::' .. method))
end

return {
    basicPrint('sout', 'println'),
    basicPrint('soun', 'print'),
    methodReference('soutref', 'println'),
    methodReference('sounref', 'print'),

    basicPrint('souf', 'printf')
}
