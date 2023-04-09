local rt = require("rust-tools")


rt.setup({
    tools = {
        inlay_hints = {
            auto = false,
            other_hints_prefix = ":=",
        },
    },
    server = {
        settings = {
            ["rust-analyzer"] = {
                inlayHints = {
                    locationLinks = false,
                },
            },

        },


        on_attach = function(client, bufnr)

            local opts = { buffer = bufnr, remap = false }

            if client.name == "eslint" then
                vim.cmd.LspStop('eslint')
                return
            end


            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
            vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
            vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
            vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
            vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
            vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
            vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
            vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
            -- Hover actions
            vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            rt.inlay_hints.enable()
        end,
    },
})
