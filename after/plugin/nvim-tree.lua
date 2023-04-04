vim.g.loaded_netrw = 1

vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true


require("nvim-tree").setup({
    diagnostics = {
        enable = true,
    },
    view = {
        side = "right",
    }
})


vim.api.nvim_set_keymap("n", "<leader>pv", ":NvimTreeToggle<CR>", {noremap = true, silent = true})
