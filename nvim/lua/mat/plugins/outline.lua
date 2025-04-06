vim.keymap.set("n", "<leader>B", "<cmd>Outline<CR>")

require("outline").setup {
    outline_window = {position = "left",},
    preview_window = {
        auto_preview = true,
    }
  -- Your setup opts here (leave empty to use defaults)
}

-- Set of filetypes where Outline should be enabled
local supported_filetypes = {
  python = true,
  go = true,
  typescript = true,
  javascript = true,
  rust = true,
  cpp = true,
}

-- Auto-open Outline on LSP attach
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf

    -- Optional: restrict to specific filetypes
    local ft = vim.bo[bufnr].filetype

    if supported_filetypes[ft] and not require("outline").is_open() then
      -- Use a slight delay to allow LSP to send symbols
      vim.defer_fn(function()
        require("outline").open({ focus_outline = false })
      end, 100) -- delay in ms
    end
  end,
})

