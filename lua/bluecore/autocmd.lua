
-- For porth syntax
vim.cmd.autocmd("BufRead,BufNewFile *.porth set filetype=porth")
vim.api.nvim_create_autocmd("FileType", {
	pattern = "nix",
	callback = function()
		vim.opt_local.shiftwidth = 2
		vim.opt_local.tabstop = 2
	end
})
