require("packer").startup(function()
    -- Plugin manager.
    use("wbthomason/packer.nvim")

    -- Theme
    use("folke/tokyonight.nvim")

    -- Godot support
    use("habamax/vim-godot")

    -- Popup fuzzy finder.
    use({
        "nvim-telescope/telescope.nvim",
        requires = { {"nvim-lua/plenary.nvim"} }
    })


    -- Better Syntax highlighting (and more).
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate"
    })
    -- Show context (function, class, etc.) of current cursor position
    use("nvim-treesitter/nvim-treesitter-context")

    -- Better fuzzy finding.
    use({
        "nvim-telescope/telescope-fzf-native.nvim", 
        run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build" 
    })

    -- Language Server Configs - Needs individual language servers" installed
    use("neovim/nvim-lspconfig")
    -- Completion Engine - suggestions for completions
    use("hrsh7th/nvim-cmp")
    -- Use the LSP as a source for completions
    use("hrsh7th/cmp-nvim-lsp")
    -- Use buffers as a source for completions
    use("hrsh7th/cmp-buffer")
    -- Pictograms on autocomplete suggestions
    use("onsails/lspkind-nvim")
    -- Method signature arguments pop-up
    use("hrsh7th/cmp-nvim-lsp-signature-help")
    -- Autcompletion for paths
    use("hrsh7th/cmp-path")
    -- Autocomplete for vim lua - only enables in .lua files.
    use("hrsh7th/cmp-nvim-lua")
    -- Snippet Engine
    use("L3MON4D3/LuaSnip")
    use("saadparwaiz1/cmp_luasnip")
    -- Testing
    use("klen/nvim-test")
    -- Harpoon, persistant marks via shortcuts
    use({
        "ThePrimeagen/harpoon",
        requires = { {"nvim-lua/plenary.nvim"} }
    })

    -- Tree for current buffer symbols.
    use ("hedyhli/outline.nvim")

    -- Dash.app needs intalled on osx - seaches language docs.
    use({
        'mrjones2014/dash.nvim',
        run = 'make install',
    })

    -- Better Go Support
    use("ray-x/guihua.lua")
    use("ray-x/go.nvim")

    -- Symbols in the gutter for highlighting changes.
    use("airblade/vim-gitgutter")

    -- Copilot
    use("zbirenbaum/copilot.lua")
    use("zbirenbaum/copilot-cmp")
end)

require("mat.plugins.telescope")
require("mat.plugins.treesitter")
require("mat.plugins.cmp")
require("mat.plugins.lspconfig")
require("mat.plugins.harpoon")
require("mat.plugins.outline")
require("mat.plugins.copilot")
require("mat.plugins.go")
require("mat.plugins.testing")
require("mat.plugins.tokyonight")
require("mat.plugins.tmuxnav")

