vim.keymap.set("n", "<Leader>m", "<cmd>lua require('harpoon.mark').add_file()<CR>", {})
vim.keymap.set("n", "<Leader>Ma", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", {})
vim.keymap.set("n", "<Leader>'a", "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", {})
vim.keymap.set("n", "<Leader>'s", "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", {})
vim.keymap.set("n", "<Leader>'d", "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", {})
vim.keymap.set("n", "<Leader>'f", "<cmd>lua require('harpoon.ui').nav_file(4)<CR>", {})

