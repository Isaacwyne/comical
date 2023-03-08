local map = vim.keymap.set

vim.g.mapleader = " "

map("n", "x", '"_x')

-- copy & paste to/from systemclipboard ('+' register)
map({ "n", "v" }, "<leader>y", [["+y]])
map("n", "<leader>Y", [["+Y]])
map({ "n", "v" }, "<leader>d", [["_d]])

-- select all
map("n", "<leader>a", "gg<S-v>G")

map("n", "J", "mzJ`z")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

------ => VISUAL ------
-- stay in visual mode while indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Telescope
map("n", "<leader>pf", "<cmd>Telescope find_files<cr>", { silent = true })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { silent = true })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { silent = true })
map("n", "<leader>ht", "<cmd>Telescope help_tags<cr>", { silent = true })
