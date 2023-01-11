-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }


    use({
        'rose-pine/neovim',
        as = 'rose-pine',
        config = function()
            vim.cmd('colorscheme rose-pine')
        end
    })



    use({'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'})
    use('nvim-treesitter/playground')
    use('theprimeagen/harpoon')
    use('mbbill/undotree')
    use('tpope/vim-fugitive')

    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},
        }
    }

    use("folke/zen-mode.nvim")
    use("github/copilot.vim")

    use("christianfosli/wsl-copy")

    use("simrat39/rust-tools.nvim")

    --use("andweeb/presence.nvim")
    --use("/home/bluekossa/projects/lua/presence.nvim")
    use("Bluekossa/presence.nvim")

    use("jiangmiao/auto-pairs")

    use("lukas-reineke/indent-blankline.nvim")

    use("p00f/nvim-ts-rainbow")
    use("neovim/nvim-lspconfig")

    -- Clojure
    use("Olical/conjure")
    use("tpope/vim-dispatch")
    use("clojure-vim/vim-jack-in")
    use("radenling/vim-dispatch-neovim")

    -- Crystal
    use("vim-crystal/vim-crystal")

    -- Webdev
    use("alvan/vim-closetag")
    use('neovim/nvim-lspconfig')
    use('jose-elias-alvarez/null-ls.nvim')
    use('MunifTanjim/prettier.nvim')
    use("mattn/emmet-vim")

    use("BlueKossa/windows-terminal-bg.nvim")

    use("udalov/kotlin-vim")

end)
