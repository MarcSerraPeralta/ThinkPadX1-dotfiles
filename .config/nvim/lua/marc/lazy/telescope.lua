return {
    "nvim-telescope/telescope.nvim",

    tag = "0.1.5",

    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    config = function()
        require('telescope').setup({})

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>pf', function()
            require('telescope.builtin').find_files({
                find_command = {
                    "rg",
                    "--files",
                    "--hidden",
                    "--no-ignore",
                    "--follow",
                    "--glob", "!.git/*"
                },
            })
            end, { desc = "Find files (dotfiles included, .git excluded)" }
        )
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        -- grep current word under cursor (no spaces)
        vim.keymap.set('n', '<leader>pws', function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)
        -- grep current word (includes punctuation)
        vim.keymap.set('n', '<leader>pWs', function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)
        -- prompted grep
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
        -- search across all neovim tags
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
    end
}
