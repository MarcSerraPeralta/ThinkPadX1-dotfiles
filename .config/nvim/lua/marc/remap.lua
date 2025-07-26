vim.g.mapleader = " "
vim.g.maplocalleader = "\\" -- needed for lazy.nvim

-- enter Ex mode (file/directory edition commands)
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- move selected lines up and down in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- cursor stays at the beginning of line when J
vim.keymap.set("n", "J", "mzJ`z")
-- cursor stays in the middle of the screen
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- copy to system's clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- paste on selected lines without changing buffer (so I can still paste again)
vim.keymap.set("x", "<leader>p", [["_dP]])
-- delete selected lines without changing buffer (so I don't loose my yanked text)
vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d")

-- opens a "substitute" command to find and replace the word where the cursor is
vim.keymap.set("n", "<leader>s", [[:%s/\\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- makes the current file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
