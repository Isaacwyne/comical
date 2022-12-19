local present, treesitter = pcall(require, "nvim-treesitter.configs")
if not present then
    return
end

local swap_next, swap_prev = (function ()
  local swap_objects = {
    p = "@parameter.inner",
    f = "@function.outer",
    e = "@element",
  }

  local n, p = {}, {}
  for key, obj in pairs(swap_objects) do
    n[string.format("<M-Space><M-%s>", key)] = obj
    p[string.format("<M-BS><M-%s>", key)] = obj
  end

  return n, p
end)()

treesitter.setup {
    ensure_installed = {
        "javascript",
        "c",
        "lua",
        "python",
        "rust",
        "vim",
    },

    -- install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    highlight = {
        enable = true,
        disable = { "help" },
    },

    refactor = {
      highlight_definitions = { enable = true },
      highlight_current_scope = { enable = false },

      smart_rename = {
        enable = false,
        keymaps = {
          -- mapping to rename reference under cursor
          smart_rename = "grr",
        },
      },

      navigation = {
        enable = false,
        keymaps = {
          goto_definition = "gnd",
          list_definition = "gnD",
        },
      },
    },

    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<M-w>",
        node_incremental = "<M-w>",             -- increment to the upper named parent
        node_decremental = "<M-C-w>",           -- decrement to the previous node
        scope_incremental = "<M-e>",
      },
    },

    context_commentstring = {
      enable = true,
      -- with Comment.nvim, we don't need to run this on the autocmd.
      -- only run it in pre-hook
      enable_autocmd = false,

      config = {
        c = "// %s",
        lua = "-- %s",
      },
    },

    textobjects = {
      move = {
        enable = true,
        set_jumps = true,
      },
    },

    select = {
      enable = true,
      lookahead = true,
    },

    swap = {
      enable = true,
      swap_next = swap_next,
      swap_previous = swap_prev,
    },
}
