vim.keymap.set("n", "<Leader>B", "<cmd>SymbolsOutline<CR>", {})

vim.g.symbols_outline = {
    auto_preview = false,
}

vim.api.nvim_set_hl(0, "FocusedSymbol", {ctermbg = 0, fg = "#C678DD"})
