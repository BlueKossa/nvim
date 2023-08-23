local current_dir = vim.fn.getcwd()

if current_dir:find("school") then
    vim.cmd("Copilot disable")
end
