function map(mode, lhs, rhs, opts) 
	local options = { noremap = true }
	if opts then
        options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = ","
map("n", "<Leader><Space>", ":nohlsearch<CR>", { silent = true})
map("n", "<C-s>", ":!tmux neww gogo-workspace<CR><CR>", { silent = true})

vim.keymap.set("n", "<Leader>dj", vim.diagnostic.goto_next, {})
vim.keymap.set("n", "<Leader>dk", vim.diagnostic.goto_prev, {})

-- Vertical and Horizontal splits
vim.keymap.set("n", "<Leader>|", "<C-w>v<CR>", {})
vim.keymap.set("n", "<Leader>-", "<C-w>s<CR>", {})
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", {})
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", {})
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", {})
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", {})


return map
