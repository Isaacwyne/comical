-- functional wrapper for keymaps
local map = function (mode, keymap, cmd, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, keymap, cmd, options)
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

-- NeoTree
map("n", "<leader>e", "<cmd>Neotree toggle<cr>")
map("n", "<leader>o", function()
  if vim.bo.filetype == "neo-tree" then
    vim.cmd.wincmd "p"
  else
    vim.cmd.Neotree "focus"
  end
end)

-- better indenting (without leaving visual mode)
map("v", "<", "<gv")
map("v", ">", ">gv")

-- windows
map("n", "<leader>ww", "<C-W>p")
map("n", "<leader>wd", "<C-W>c")
map("n", "<leader>-", "<C-W>s")
map("n", "<leader>\\", "<C-W>v")

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { silent = true })
map("n", "<leader>fa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true <cr>", { silent = true })
map("n", "<leader>fw", "<cmd>Telescope live_grep <cr>", { silent = true })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { silent = true })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { silent = true })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", { silent = true })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find <cr>", { silent = true })
-- using telescope with git
map("n", "<leader>cm", "<cmd>Telescope git_commits <cr>", { silent = true })
map("n", "<leader>gt", "<cmd>Telescope git status <cr>", { silent = true })

-- package manager (language servers)
map("n", "<leader>pm", "<cmd>Mason<cr>")
map("n", "<leader>pM", "<cmd>MasonUpdateAll<cr>")
