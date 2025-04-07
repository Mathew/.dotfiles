local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

require('go').setup({
    lsp_cfg={capabilities=capabilities},
    luasnip=true,
    goimports="gopls",
    fillstruct="gopls",
    gofmt = "gopls",
    comment_placeholder = "",
    lsp_gofumpt=false,
    lsp_codelens=true,
    lsp_on_attach = function(client, buffer) 
        vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer=0})
        vim.keymap.set("n", "<Leader>r", "<cmd>GoRename<cr>", {buffer=0})
        vim.keymap.set("n", "<leader>a", "<cmd>GoCodeAction<cr>", {buffer=0})
        vim.keymap.set("n", "<leader>At", "<cmd>GoAddTag<cr>", {buffer=0})
        vim.keymap.set("n", "<leader>AT", "<cmd>GoRmTag<cr>", {buffer=0})
    end,
})
