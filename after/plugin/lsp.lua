local lsp = require('lsp-zero')
local lspconfig = require('lspconfig')

lsp.preset("recommended")

lsp.ensure_installed({
    'tsserver',
    'eslint',
    'rust_analyzer',
})
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

local function set_keymaps()
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "1", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "2", vim.diagnostic.goto_prev, opts)
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
    vim.keymap.set("n", "<leader>vga", function()
        vim.lsp.buf.code_action({
            context = {
                only = {
                    -- Why is the generate action kind an empty string?
                    "",
                }
            }
        })
    end, opts)
    vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
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

local function enable_inlay()
    vim.lsp.buf.inlay_hint(0, true)
end

local function disable_inlay()
    vim.lsp.buf.inlay_hint(0, false)
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

lspconfig.rust_analyzer.setup({
    on_attach = function(_, bufnr)
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
