return {
    "nvim-lualine/lualine.nvim",
    config = function() require('lualine').setup({
        options = {
            theme = 'nightfly',
            component_separators = '',
            section_separators = '',
        },
        sections = {
            lualine_a = {},
            lualine_b = {{
                'filename',
                path = 1,  -- 0 = just filename, 1 = relative path, 2 = absolute path
                symbols = { modified = ' ●', readonly = ' 🔒', unnamed = '[No Name]' },
            }},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {},
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {{
                'filename',
                path = 1,
                symbols = { modified = ' ●', readonly = ' 🔒', unnamed = '[No Name]' },
            }},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {},
        },
        tabline = {},
        extensions = {},
        }) end,
}
