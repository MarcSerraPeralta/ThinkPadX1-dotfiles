return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            style = "night",
            styles = {
                keywords = { italic = false },
            },
            on_highlights = function(hl, c)
              hl["@keyword.import"] = { fg = "#bb9af7", italic = false }
              hl["@string.documentation"] = { fg = c.green }
              -- hl["@keyword.exception"] = { fg = c.yellow }
              -- hl["@function.builtin"] = { fg = c.yellow }
              hl["@keyword.operator"] = { fg = "#bb9af7", italic = false }
            end,
        },
    },
}
