local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local ex = require('luasnip.extras')
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
            "\tprint(f'"
        }), rep(1), t(': {'), rep(1), t('}, '), rep(2), t(': {'), rep(2), t("}')")
    }),
    s('fordict', {
        t('for '), i(1, 'key'), t(', '), i(2, 'value'), t(' in '), i(3, 'dict'),
        t({
            '.items():',
            "\tprint(f'"
        }), rep(1), t(': {'), rep(1), t('}, '), rep(2), t(': {'), rep(2), t("}')")
    })
}
