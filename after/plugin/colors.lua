function ColorScheme(color)
	color = color or "rose-pine"
	vim.cmd.colorscheme(color)

    -- Uncomment if transparent background
	--vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	--vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

vim.o.termguicolors = true
ColorScheme("boo")
--require("material.functions").change_style("deep ocean")

vim.keymap.set("n", "<leader>hg", function()
    local result = vim.cmd(":Inspect")
    print(vim.inspect(result))
end)

-- Color fixes 
vim.cmd("highlight GitGutterDelete guibg=none") -- Why? No idea.
