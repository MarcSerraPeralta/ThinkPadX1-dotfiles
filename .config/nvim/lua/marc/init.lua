require("marc.remap")
require("marc.set")
require("marc.lazy_init") -- needs to be loaded after remap because it contains the leader keys

vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- set colorscheme from the ones described in lazy
vim.cmd[[colorscheme tokyonight]]
-- change context line color (needs to be done after loading colorscheme to avoid overwritting)
vim.cmd.highlight("TreesitterContext guibg=#2e3347") 
vim.cmd.highlight("TreesitterContextLineNumber guibg=#2e3347")  
