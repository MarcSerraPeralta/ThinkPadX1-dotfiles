return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" }, -- load lsp only when loading files (faster)
    dependencies = {
        "ray-x/lsp_signature.nvim", -- shows the signature of functions while typing
        "hrsh7th/nvim-cmp", -- autocompletion
        "hrsh7th/cmp-nvim-lsp", -- enable LSP <-> cmp communication
        -- "L3MON4D3/LuaSnip", -- snippets = templates for functions, classes...
    },

    config = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        capabilities.positionEncoding = "utf-8" -- basedpyright uses utf16 by default

        -- LSP for python
        require("lspconfig").basedpyright.setup({
            capabilities = capabilities,
            settings = {
                basedpyright = {
                    typeCheckingMode = "recommended",
                    analysis = {exclude = { "**/*.ipynb" }},
                },
            },
        })

        -- show function signatures while typing
        require("lsp_signature").setup({
            hint_enable = false,      -- disable inline hints for a cleaner look
            timer_interval = 50,     -- faster update rate (default: 200ms)
          })

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
        require("lspconfig").ruff.setup({
            capabilities = capabilities,
            on_attach = function(client, bufnr)
                -- Disable all diagnostics from ruff
                client.server_capabilities.diagnosticProvider = false
            end,
        })

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

        -- configure keymaps
        -- -- display full information of the diagnostics in the current line
        -- -- and close the information in a floating window when pressing any key
        local function close_floating()
            for _, win in ipairs(vim.api.nvim_list_wins()) do
                local config = vim.api.nvim_win_get_config(win)
                if config.relative ~= "" then
                    vim.api.nvim_win_close(win, false)
                end
            end
        end

        vim.keymap.set("n", "<leader>d", function()
            vim.diagnostic.open_float(nil, { scope = "line", border = "rounded" })
            local ns = vim.api.nvim_create_namespace("diag_float_temp")
            vim.on_key(function()
                close_floating()
                vim.on_key(nil, ns)
            end, ns)
            end, { desc = "Show diagnostics and close on keypress" }
        )

        -- -- format the selected lines
        vim.keymap.set("v", "<Leader>ff", function()
            vim.lsp.buf.format({ range = {
                ["start"] = vim.api.nvim_buf_get_mark(0, "<"),
                ["end"]   = vim.api.nvim_buf_get_mark(0, ">"),
            }})
            end, { desc = "Format selected lines with LSP" }
        )
        vim.keymap.set("n", "<leader>ff", function()
            vim.lsp.buf.format({})
            end, { desc = "Format entire file with LSP" }
        )
    end,
}
