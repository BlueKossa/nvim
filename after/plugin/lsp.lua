local lsp = require('lsp-zero')
local lspconfig = require('lspconfig')
local is_nix = os.getenv("NIX_PATH") ~= nil
lsp.preset("recommended")
lspconfig.lua_ls.setup({
    cmd = { "lua-lsp" },
    filetypes = { "lua", "balls" },
})

lspconfig.qmlls.setup{
    filetypes = { "qml" },
}
if is_nix then
    lsp.setup_servers({
        "lua_ls",
        "rust_analyzer",
        "jedi_language_server",
        "qmlls",
    })
else
    lsp.ensure_installed({
        'tsserver',
        'eslint',
        'rust_analyzer',
    })
end
local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})


lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})



lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})
-- Save the last search term
local search_term = nil
local function set_keymaps()
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "<C-j>", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "<C-k>", vim.diagnostic.goto_prev, opts)
    -- Code actions, excluding generate actions
    vim.keymap.set("n", "<leader>vca", function()
        vim.lsp.buf.code_action({
            context = {
                only = {
                    "quickfix",
                    "refactor",
                }
            },
            apply = true,
        })
    end, opts)
    vim.keymap.set("n", "<leader>vsca", function()
        local new_search_term = vim.fn.input("Search code action: ")
        if new_search_term ~= "" then
            search_term = new_search_term
        end
        vim.lsp.buf.code_action({
            filter = function(ca)
                for term in search_term:gmatch("[^%s]+") do
                    if ca.title:match(term) ~= nil then
                        return true
                    end
                end
                return false
            end
        })
    end, opts)
    vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
end

local function enable_inlay()
    vim.lsp.inlay_hint(0, true)
end

local function disable_inlay()
    vim.lsp.inlay_hint(0, false)
end

local group = vim.api.nvim_create_augroup("toggle-lsp-inlay", { clear = true })

local function toggle_inlay_on_insert()
    -- create an autocommand
    vim.api.nvim_create_autocmd("InsertEnter", {
        group = group,
        callback = disable_inlay,
    })

    vim.api.nvim_create_autocmd("InsertLeave", {
        group = group,
        callback = enable_inlay,
    })
end

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil
lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    if client.name == "eslint" then
        vim.cmd.LspStop('eslint')
        return
    end
    set_keymaps()
end)


lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})


lspconfig.rust_analyzer.setup({
    on_attach = function()
        set_keymaps()
        enable_inlay()
        toggle_inlay_on_insert()
    end,
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                features = "all",
            },

            checkOnSave = true,

            check = {
                command = "clippy",
                allTargets = true,
                features = "all",
                invocationLocation = "workspace",
                extraArgs = { "--tests" },
            },

        },
    },
})

vim.api.nvim_set_hl(0, "LspInlayHint", {
    link = "Comment",
})
