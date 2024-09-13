vim.opt.colorcolumn = "80"
vim.opt.signcolumn = "yes"

vim.opt.cursorline = true
vim.opt.rnu = true
vim.opt.nu = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 5
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.termguicolors = true

vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.scrolloff = 8
vim.opt.updatetime = 50
vim.api.nvim_set_option("clipboard","unnamed")


vim.api.nvim_command([[
    autocmd Filetype javascript setlocal ts=4 sw=4 sts=0 noexpandtab
    autocmd Filetype html setlocal ts=4 sw=4 sts=0 noexpandtab
    autocmd Filetype go setlocal ts=4 sw=4 sts=0 noexpandtab
    set noswapfile
]])


-- Automatically format file based on LSP if available.
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

-- Debug function
function P(item) 
    print(vim.inspect(item))
end
