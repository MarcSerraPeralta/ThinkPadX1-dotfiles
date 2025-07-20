-- fat cursor in insert mode
vim.opt.guicursor = ""

-- activate line numbers and make then relative
vim.opt.nu = true
vim.opt.relativenumber = true

-- 4 space indenting
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- no line wrap
vim.opt.wrap = false

-- be able to do undo even after closing vim, but wihtout backups
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- do not highlight all terms when searching, but highlight only the first one
-- and do it incrementally (i.e. as typing)
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- have colors
vim.opt.termguicolors = true

-- never have less than 8 lines above or below the cursor
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- fast update time
vim.opt.updatetime = 50

-- add line at 80 characters
vim.opt.colorcolumn = "80"
