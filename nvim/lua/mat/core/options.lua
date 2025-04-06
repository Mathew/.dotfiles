vim.opt.colorcolumn = "80"
vim.opt.signcolumn = "yes"

vim.opt.cursorline = true
vim.opt.rnu = true
vim.opt.nu = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.termguicolors = true

vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.scrolloff = 8
vim.opt.updatetime = 50
vim.opt.clipboard = "unnamedplus"
vim.opt.swapfile = false

vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 0
vim.g.netrw_liststyle = 3

-- Debug function
function P(item) 
    print(vim.inspect(item))
end

