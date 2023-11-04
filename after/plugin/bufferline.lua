local bufferline = require("bufferline")

bufferline.setup {
    options = {
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false,
        show_close_icon = false,
        themable = true,
        modified_icon = "",

        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
        end,
        numbers = function(opts)
            return string.format("%s", opts.raise(opts.ordinal))
        end,
    }
}

-- Keybinds
vim.keymap.set("n", "<leader>tn", "<cmd>BufferLineCycleNext<CR>")
vim.keymap.set("n", "<leader>tb", "<cmd>BufferLineCyclePrev<CR>")
vim.keymap.set("n", "<leader>tc", "<cmd>BufferLineClose<CR>")
vim.keymap.set("n", "<leader>tt", function()
    local tab = vim.fn.getchar() - 48 -- 48 = ASCII 0
    vim.cmd("BufferLineGoToBuffer " .. tab)
end)
