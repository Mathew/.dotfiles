--[[
require("nvim-tmux-navigation").setup ({
    disable_when_zoomed = true, -- defaults to false
    keybindings = {
        left = "<C-h>",
        down = "<C-j>",
        up = "<C-k>",
        right = "<C-l>",
        last_active = "<C-\\>",
        next = "<C-Space>",
    }
})
]]


-- stop netrw capturing the <C-L> mapping
vim.api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  callback = function()
    vim.api.nvim_buf_del_keymap(0, 'n', '<C-L>')
  end,
})

local function smart_move(direction, tmux_cmd)
  local curwin = vim.api.nvim_get_current_win()
  vim.cmd('wincmd ' .. direction)
  if curwin == vim.api.nvim_get_current_win() then
    vim.fn.system('tmux select-pane ' .. tmux_cmd)
  end
end

vim.keymap.set('n', '<C-h>', function() smart_move('h', '-L') end, {silent = true})
vim.keymap.set('n', '<C-j>', function() smart_move('j', '-D') end, {silent = true})
vim.keymap.set('n', '<C-k>', function() smart_move('k', '-U') end, {silent = true})
vim.keymap.set('n', '<C-l>', function() smart_move('l', '-R') end, {silent = true})
