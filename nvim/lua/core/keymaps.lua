-- functional wrapper for keymaps
local map = function (mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- better up/down navigation
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

map("n", "x", '"_x')
-- new file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New file" })

-- copy & paste to/from systemclipboard ('+' register)
map({ "n", "v" }, "<leader>y", [["+y]])
map("n", "<leader>Y", [["+Y]])
map({ "n", "v" }, "<leader>d", [["_d]])

-- select all
map("n", "<leader>a", "gg<S-v>G")

map("n", "J", "mzJ`z")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- better indenting (without leaving visual mode)
map("v", "<", "<gv")
map("v", ">", ">gv")

-- windows
map("n", "<leader>ww", "<C-W>p", { desc = "Other window" })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete window" })
map("n", "<leader>-", "<C-W>s", { desc = "Split window below" })
map("n", "<leader>\\", "<C-W>v", { desc = "Split window right" })

-- Telescope
map("n", "<leader>fo", "<cmd>Telescope find_files<cr>", { silent = true })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { silent = true })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { silent = true })
map("n", "<leader>ht", "<cmd>Telescope help_tags<cr>", { silent = true })
