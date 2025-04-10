vim.api.nvim_create_autocmd("FileType", {
    pattern = { "gdscript", "python", "lua", "json", "yaml" },
    callback = function()
        vim.opt_local.expandtab = true    -- Use spaces instead of tabs
        vim.opt_local.shiftwidth = 4      -- Indent size
        vim.opt_local.tabstop = 4         -- Displayed width of a tab
        vim.opt_local.softtabstop = 4     -- Soft tab behavior
    end
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "make", "go", "javascript", "html", "make" },
    callback = function()
        vim.opt_local.expandtab = false   -- Use actual tabs (Makefiles & Go require them)
        vim.opt_local.shiftwidth = 4
        vim.opt_local.tabstop = 4
        vim.opt_local.softtabstop = 4
    end
})

-- Automatically format file based on LSP if available.
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        vim.lsp.buf.format()
    end,
})
