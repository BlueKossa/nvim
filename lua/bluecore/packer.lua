-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use { "bluz71/vim-moonfly-colors", as = "moonfly" }
    use {
        "EdenEast/nightfox.nvim",
        as = "nightfox",
    }

    use({
        'rose-pine/neovim',
        as = 'rose-pine',
    })
    use { "briones-gabriel/darcula-solid.nvim", requires = "rktjmp/lush.nvim" }
    use { 'marko-cerovac/material.nvim', as = 'material' }



    use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
    use('nvim-treesitter/playground')
    use('nvim-treesitter/nvim-treesitter-context')
    use('theprimeagen/harpoon')
    use('mbbill/undotree')
    use('tpope/vim-fugitive')

    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }

    use("folke/zen-mode.nvim")
    use("github/copilot.vim")

    use("christianfosli/wsl-copy")

    --use("andweeb/presence.nvim")
    --use("/home/bluekossa/projects/lua/presence.nvim")
    use("Bluekossa/presence.nvim")
    --use("/home/bluecore/projects/lua/presence.nvim/")

    --use("jiangmiao/auto-pairs")
    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }


    use("lukas-reineke/indent-blankline.nvim")

    use("p00f/nvim-ts-rainbow")

    -- Clojure
    --use("Olical/conjure")
    --use("tpope/vim-dispatch")
    --use("clojure-vim/vim-jack-in")
    --use("radenling/vim-dispatch-neovim")

    -- Crystal
    use("vim-crystal/vim-crystal")

    -- Webdev
    use("alvan/vim-closetag")
    use('jose-elias-alvarez/null-ls.nvim')
    use('MunifTanjim/prettier.nvim')
    use("mattn/emmet-vim")

    use("BlueKossa/windows-terminal-bg.nvim")

    use("udalov/kotlin-vim")

    use("nvim-tree/nvim-tree.lua")
    use("nvim-tree/nvim-web-devicons")
    --use("glepnir/galaxyline.nvim")
    use("hoob3rt/lualine.nvim")
    use("airblade/vim-gitgutter")
    use("evanleck/vim-svelte")

    -- Wakatime
    use("wakatime/vim-wakatime")
end)
