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
    use { 'rockerBOO/boo-colorscheme-nvim' }



    use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
    use('nvim-treesitter/playground')
    use('theprimeagen/harpoon')
    use('mbbill/undotree')
    use('tpope/vim-fugitive')

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = "v2.x",
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

    use("github/copilot.vim")

    -- use("christianfosli/wsl-copy")

    use("BlueKossa/presence.nvim")
    --use("/home/bluekossa/projects/lua/presence.nvim")
    --use("$HOME/repos/neovim/presence.nvim")
    --use("/home/bluecore/projects/lua/presence.nvim/")

    --use("jiangmiao/auto-pairs")
    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }


    use("lukas-reineke/indent-blankline.nvim")

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


    use("udalov/kotlin-vim")

    use("nvim-tree/nvim-tree.lua")
    use("nvim-tree/nvim-web-devicons")
    --use("glepnir/galaxyline.nvim")
    use("hoob3rt/lualine.nvim")
    use {'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons'}
    use("airblade/vim-gitgutter")
    use("evanleck/vim-svelte")

    -- Wakatime
    use("wakatime/vim-wakatime")

    -- QML
    use("peterhoeg/vim-qml")
    use("artoj/qmake-syntax-vim")


    use("folke/which-key.nvim")

    -- Latex
    use("lervag/vimtex")
end)
