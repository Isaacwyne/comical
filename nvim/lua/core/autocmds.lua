local autocmd = vim.api.nvim_create_autocmd

local function augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

-- highlight on yank
autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 40,
    })
  end,
})

-- go to the last location when opening a buffer
autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- wrap and check for spell in text filetype
autocmd("Filetype", {
  group = augroup("wrap_spell"),
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})
