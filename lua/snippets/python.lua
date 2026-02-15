local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local ex = require('luasnip.extras')
local sn = ls.snippet_node
local d = ls.dynamic_node
local rep = ex.rep

return {
    s("main", {
        t({
            'def main():',
            '\t'
        }),
        i(1, '...'),
        t({
            '',
            '',
            'if __name__ == "__main__":',
            '\tmain()'
        }),
    }),
    s('pval', {
        t("print(f'"), i(1), t(": {"), rep(1), t("}')")
    }),

    s('forenum', {
        t('for '), i(1, 'index'), t(', '), i(2, 'value'), t(' in enumerate('), i(3, 'list'),
        t({
            '):',
            "\t"
        }),
        d(4, function(args)
            local index = args[1][1] or "index"
            local value = args[2][1] or "value"
            return sn(nil, {
                i(1, string.format("print(f'%s: {%s}, %s: {%s}')", index, index, value, value))
            })
        end, {1,2}),
    }),

    s('fordict', {
        t('for '), i(1, 'key'), t(', '), i(2, 'value'), t(' in '), i(3, 'dict'),
        t({
            '.items():',
            "\t"
        }),
        d(4, function(args)
            local key = args[1][1] or "key"
            local value = args[2][1] or "value"
            return sn(nil, {
                i(1, string.format("print(f'%s: {%s}, %s: {%s}')", key, key, value, value))
            })
        end, {1,2}),
    })
}
