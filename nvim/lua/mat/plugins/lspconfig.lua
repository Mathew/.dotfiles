local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

vim.lsp.config("pyright", {
    on_attach = function()
        vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer=0})
        vim.keymap.set("n", "<Leader>r", vim.lsp.buf.rename, {buffer=0})
        vim.keymap.set("n", "<Leader>a", vim.lsp.buf.code_action, {buffer=0})
    end,
    before_init = function(_, config)
        local match = vim.fn.glob(config.cmd_cwd .. '/poetry.lock')
        if match ~= '' then
            config.settings.python.autoSearchPaths = false
          
            local venv = vim.fn.trim(vim.fn.system('poetry env info -p'))
            config.settings.python.pythonPath = venv .. "/bin/python"
        end
    end,
    capabilities = capabilities,
    settings = {
        pyright = {
            disableOrganizeImports = true,
        },
        python = {
            analysis = {
                ignore = {},
            },
        },
    }
})
vim.lsp.enable("pyright")

vim.lsp.config("ruff", {
    init_options = {
        settings = {
            args = { "--line-length=88" },
            inlay_hints = true,
        }
    }
})
vim.lsp.enable("ruff")

vim.lsp.config("ts_ls", {
  init_options = {},
  filetypes = {
    "javascript",
    "typescript",
  },
  settings = {
      javascript = {
          format = {
              indentSize = 2,
              tabSize = 2,
              convertTabsToSpaces = true
          }
      }
  }
})
vim.lsp.enable("ts_ls")

vim.lsp.config("gdscript", {
    cmd = { "nc", "127.0.0.1", "6005"},
    filetypes = { "gd", "gdscript", "gdscript3" },
    root_dir = require("lspconfig.util").root_pattern("project.godot", ".git"),
    single_file_support = true
})
vim.lsp.enable("gdscript")

