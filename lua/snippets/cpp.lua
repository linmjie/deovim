local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local ex = require("luasnip.extras")
local rep = ex.rep
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta

local function smartPointer(pointerType)
    return s(pointerType,
        fmt([[std::{}_ptr<{}> {} = std::make_{}<{}>({});]], {
            t(pointerType),
            i(1, 'T'),
            i(2, 'name'),
            t(pointerType),
            rep(1),
            i(3)
        })
    )
end

return {
    s('ts', {
        t('this->')
    }),
    smartPointer("unique"),
    smartPointer("shared"),
    s('hfn', {
        t('[[nodiscard]] '),
        i(1, 'void'), t(' '), i(2, 'name'), t('('), i(3, '/* params */'), t(');')
    }),

    s('vhfn', {
        i(1, 'void'), t(' '), i(2, 'name'), t('('), i(3, '/* params */'), t(');')
    }),

    s("lambda", fmta([[[<capture>](<param>){ return <body>; }]], {
        capture = i(1),
        param = i(2),
        body = i(3)
    })),

    s("anonymous_function", fmta([[[<capture>](<param>){<body>}]], {
        capture = i(1),
        param = i(2),
        body = i(3)
    })),
}
