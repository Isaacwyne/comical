local present, treesitter = pcall(require, "nvim-treesitter.configs")
if not present then
  return
end

local opts = {
  ensure_installed = {
    "javascript",
    "c",
    "lua",
    "python",
    "rust",
    "vim",
  },

  highlight = {
    enable = true,
    disable = { "help" },
  },
  indent = {
    enable = true
  },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<M-w>",
      node_incremental = "<M-w>",     -- increment to the upper named parent
      node_decremental = "<M-C-w>",   -- decrement to the previous node
      scope_incremental = "<M-e>",
    },
  },
}

---@param opts TSConfig
if type(opts.ensure_installed) == "table" then
  ---@type table<string, boolean>
  local added = {}
  opts.ensure_installed = vim.tbl_filter(function(lang)
    if added[lang] then
      return false
    end
    added[lang] = true
    return true
  end, opts.ensure_installed)
end

treesitter.setup(opts)
