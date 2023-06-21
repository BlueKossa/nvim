function ColorScheme(color)
	color = color or "rose-pine"
	vim.cmd.colorscheme(color)

    -- Uncomment if transparent background
	--vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	--vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end


ColorScheme("carbonfox")
