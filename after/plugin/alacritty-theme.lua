local al = require("al-theme")

local options = {
    theme_dir = os.getenv("ALACRITTY_THEME_DIR"),
    alacritty_config_path = os.getenv("ALACRITTY_CONFIG_PATH"),
    wsl = true,
    preview = true,
}

al:init(options)

vim.keymap.set("n", "<leader>al", function()
    al:toggle_theme_menu()
end)
