local harpoon = require("harpoon")
harpoon:setup()

vim.keymap.set('n', "<leader>aa", function() harpoon:list():add() end)
for i = 1, 9 do
    vim.keymap.set('n', "<leader>a" .. i, function() harpoon:list():replace_at(i) end)
end

for i = 1, 9 do
    vim.keymap.set('n', "<leader>" .. i, function() harpoon:list():select(i) end)
end

vim.keymap.set('n', "<leader>o", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
