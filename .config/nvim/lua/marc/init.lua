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

-- file explorer
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- avoid vim adding comment symbols when creating new line from commented line
vim.opt.formatoptions:remove({ "o", "r" })

-- set round borders across all diagnostics
vim.diagnostic.config({ float = { border = "rounded" } })

-- be able to close the diagnostic floating windows by pressing Esc
local ns = vim.api.nvim_create_namespace("global_diag_float_close")
local orig_open_float = vim.diagnostic.open_float
local diag_win = nil
vim.diagnostic.open_float = function(bufnr, opts)
  -- Close existing float if valid
  if diag_win and vim.api.nvim_win_is_valid(diag_win) then
    vim.api.nvim_win_close(diag_win, false)
    diag_win = nil
    vim.on_key(nil, ns)
  end

  opts = opts or {}
  opts.border = opts.border or "rounded"

  local float_buf, win = orig_open_float(bufnr, opts)
  diag_win = win

  -- Auto-close on <Esc>
  vim.on_key(function(key)
    if key == vim.api.nvim_replace_termcodes("<Esc>", true, false, true) then
      if diag_win and vim.api.nvim_win_is_valid(diag_win) then
        vim.api.nvim_win_close(diag_win, false)
      end
      diag_win = nil
      vim.on_key(nil, ns)
    end
  end, ns)

  return float_buf, win
end

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
        vim.keymap.set("n", "<leader>e", function() vim.diagnostic.open_float(nil, {
            focusable = false, scope = "line",
            }) end, {desc = "Show diagnostics for the current line" })
        vim.keymap.set("v", "<Leader>ff", function()
            vim.lsp.buf.format({ range = {
                ["start"] = vim.api.nvim_buf_get_mark(0, "<"),
                ["end"]   = vim.api.nvim_buf_get_mark(0, ">"),
            }})
            end, { desc = "Format selected lines with LSP" })
        vim.keymap.set("n", "<leader>ff", function()
            vim.lsp.buf.format({})
            end, { desc = "Format entire file with LSP" })
        vim.keymap.set("n", "<leader>xx", function()
            require("telescope.builtin").diagnostics({ bufnr = nil })
            end, { desc = "Show all diagnostics (Telescope)" })

    end
})
