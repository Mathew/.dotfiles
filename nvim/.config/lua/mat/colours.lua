vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_functions = true
vim.g.italic_comments = true
vim.g.tokyonight_transparent = true
vim.g.tokyonight_transparent_sidebar = true

vim.cmd([[colorscheme tokyonight]])

vim.api.nvim_set_hl(0, "ColorColumn", {ctermbg = 0, bg = "#555555"})

