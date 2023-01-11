wtbg = require("wt-bg")

wtbg:setup({
    terminal_conf = "/mnt/c/Users/Dexter Stormdal/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json",
    bg_path = "/mnt/c/Users/Dexter Stormdal/Pictures/Wallpapers/Backgrounds/",
})

vim.keymap.set("n", "<leader>bg", function()
    local bg = vim.fn.input("Background: ")
    wtbg:set_background(bg)
end)

vim.keymap.set("n", "<leader>bo", function()
    local opacity = vim.fn.input("Opacity: ")
    wtbg:set_opacity(opacity)
end)
