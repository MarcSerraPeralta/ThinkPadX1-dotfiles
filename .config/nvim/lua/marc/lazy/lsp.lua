return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" }, -- load lsp only when loading files (faster)
    dependencies = {
        -- "ray-x/lsp_signature.nvim", -- shows the signature of functions while typing
        "hrsh7th/nvim-cmp", -- autocompletion
        "hrsh7th/cmp-nvim-lsp", -- enable LSP <-> cmp communication
        -- "L3MON4D3/LuaSnip", -- snippets = templates for functions, classes...
    },

    config = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        capabilities.positionEncoding = "utf-8" -- basedpyright uses utf16 by default

        -- LSP for python
        vim.lsp.config("basedpyright", {
            capabilities = capabilities,
            settings = {
                basedpyright = {
                    typeCheckingMode = "recommended",
                    analysis = {
                        exclude = { "**/*.ipynb" },
                        diagnosticMode = "workspace", -- scans the whole workspace
                    },
                },
            },
        })
        vim.lsp.enable("basedpyright")

        -- autocompletion based on the LSP
        local cmp = require("cmp")
        cmp.setup({
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
            }),
        })

        -- ruff linter and formatter for python (do not use for diagnosis)
        vim.lsp.config("ruff", {
            capabilities = capabilities,
            on_attach = function(client, bufnr)
                -- Disable all diagnostics from ruff
                client.server_capabilities.diagnosticProvider = false
            end,
        })
        vim.lsp.enable("ruff")

        -- configure LSP behavior and visualization
        vim.diagnostic.config({
            update_in_insert = true, -- make LSPs work also while in insert mode
            virtual_text = {
                prefix = "●", 
                spacing = 4,
                severity = nil,
                source = "if_many",   -- show source if there are multiple
                format = function(diagnostic)
                  return diagnostic.message
                end,
                right_align = true,   
            },
            signs = true,
            severity_sort = true,
        })

        -- the keymaps for the LSP are defined in init.lua

    end,
}
