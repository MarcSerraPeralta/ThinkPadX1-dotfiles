require("marc.remap")
require("marc.set")
require("marc.lazy_init") -- needs to be loaded after remap because it contains the leader keys

-- remove langauges for neovim plugins that are not lua or python
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- set colorscheme from the ones described in lazy
vim.cmd[[colorscheme tokyonight]]
-- change context line color (needs to be done after loading colorscheme to avoid overwritting)
vim.cmd.highlight("TreesitterContext guibg=#2e3347") 
vim.cmd.highlight("TreesitterContextLineNumber guibg=#2e3347")  

-- set round borders across all diagnostics
vim.diagnostic.config({
  float = { border = "rounded" },
})

-- load keymaps for LSP only after LSP is attached
local MarcGroup = vim.api.nvim_create_augroup('Marc', {})
vim.api.nvim_create_autocmd('LspAttach', {
    group = MarcGroup,
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("i", "<leader>vh", function() vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
        -- show diagnosis for current line.
        -- the function is quite long because I want the floating window to
        -- close when typing <Esc> (the default close action is with cursor movement)
        vim.keymap.set("n", "<leader>d", function()
            local line_diagnostics = vim.diagnostic.get(0, 
                { lnum = vim.api.nvim_win_get_cursor(0)[1] - 1 }
            )

            if vim.tbl_isempty(line_diagnostics) then
                return  -- no diagnostics, don't open anything
            end

            local float_bufnr, float_winnr = vim.diagnostic.open_float(nil, {
                focusable = false,
                scope = "line",
                border = "rounded",
            })

            local ns = vim.api.nvim_create_namespace("diag_float_auto_close")

            vim.on_key(function()
                if vim.api.nvim_win_is_valid(float_winnr) then
                    vim.api.nvim_win_close(float_winnr, false)
                end
                vim.on_key(nil, ns) -- clear key listener
            end, ns)
        end, { desc = "Show diagnostics and close on key press" })
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
    end
})
