
-- For porth syntax
vim.cmd.autocmd("BufRead,BufNewFile *.porth set filetype=porth")
vim.cmd.autocmd("BufRead,BufNewFile *.eris set filetype=eris")
vim.api.nvim_create_autocmd("FileType", {
	pattern = "nix",
	callback = function()
		vim.opt_local.shiftwidth = 2
		vim.opt_local.tabstop = 2
	end
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = "rust",
    callback = function()
        vim.cmd("packadd termdebug")
        vim.g.termdebug_wide = 1
        vim.g.termdebugger = "rust-gdb"
        vim.keymap.set("n", "<leader>dd", function()
            vim.ui.input({
                prompt = "File: ",
                completion = "file",
                default = "target/debug/"
            }, function(input)
                if input == nil or input == "" then
                    return
                end
                vim.cmd("Termdebug " .. input)
            end)
        end)
    end
})
