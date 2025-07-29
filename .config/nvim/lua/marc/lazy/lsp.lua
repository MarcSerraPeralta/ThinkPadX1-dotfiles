return {{
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

        -- LSP for python
        require("lspconfig").basedpyright.setup({
            capabilities = capabilities,
            settings = {
              basedpyright = {
                  typeCheckingMode = "recommended",
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

        -- configure LSP behavior and visualization
        vim.diagnostic.config({
            update_in_insert = true, -- make LSPs work also while in insert mode
            virtual_text = {
                prefix = "●",         -- can be "", "●", "▶", etc.
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
    end,
},}
