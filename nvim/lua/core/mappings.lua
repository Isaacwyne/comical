local map = vim.keymap.set

vim.g.mapleader = " "

map("n", "x", '"_x')
map("n", "<leader>e", "<cmd>Lex<cr>", { silent = true })

-- copy & paste to/from systemclipboard ('+' register)
map({ "n", "v" }, "<leader>y", [["+y]])
map("n", "<leader>Y", [["+Y]])
map({ "n", "v" }, "<leader>d", [["_d]])

-- select all
map("n", "<leader>a", "gg<S-v>G")

map("n", "J", "mzJ`z")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- resize with the motion keys
map("n", "<C-k>", ":resize -2<cr>", { silent = true})
map("n", "<C-j>", ":resize +2<cr>", { silent = true})
map("n", "<C-h>", ":vertical resize -2<cr>", { silent = true})
map("n", "<C-l>", ":vertical resize +2<cr>", { silent = true})

-- greatest remap ever
map("x", "<leader>p", [["_dP]])

----- => VISUAL -----
-- stay in visual mode while indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Telescope
map("n", "<leader>pf", "<cmd>Telescope find_files<cr>", { silent = true })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { silent = true })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { silent = true })
map("n", "<leader>ht", "<cmd>Telescope help_tags<cr>", { silent = true })
