local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")
require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    sources = cmp.config.sources({
        { name = "copilot" },
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "buffer" },
        { name = "luasnip" },
        { name = "path" },
        { name = "nvim_lua"},
    }),
    mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({select = false}),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    formatting = {
        format = lspkind.cmp_format({
            mode = "symbol",
            maxwidth = 50,
            ellipsis_char = '...',
            symbol_map = { Copilot = "" }
        }),
    },
})


local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local lspconfig = require("lspconfig")

lspconfig.pyright.setup({
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
                ignore = {'*'},
            },
        },
    }
})

lspconfig.ruff.setup {
    init_options = {
        settings = {
            args = { "--line-length=88" },
            inlay_hints = true,
        }
    }
}

lspconfig.ts_ls.setup{
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
}

lspconfig.gdscript.setup{
    cmd = { "nc", "127.0.0.1", "6005"},
    filetypes = { "gd", "gdscript", "gdscript3" },
    root_dir = lspconfig.util.root_pattern("project.godot", ".git"),
    single_file_support = true
}
