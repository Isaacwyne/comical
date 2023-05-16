local present, lspconfig = pcall(require, "lspconfig")
if not present then
  return
end

local mason = require("mason")
mason.setup({
  ensure_installed = {
    "lua-language-server",
    "bash-language-server",
    "python-lsp-server"
  },

  ui = {
    icons = {
      package_pending = " ",
      package_installed = "󰄳 ",
      package_uninstalled = " 󰚌",
    },

    keymaps = {
      toggle_server_expand = "<CR>",
      install_server = "i",
      update_server = "u",
      check_server_version = "c",
      update_all_servers = "U",
      check_outdated_servers = "C",
      uninstall_server = "X",
      cancel_installation = "<C-c>",
    },
  },
})

local on_attach = function(client, bufnr)
  local keymap = vim.keymap.set
  local bufopts = { buffer = bufnr, remap = false }

  keymap("n", "gd", vim.lsp.buf.definition, bufopts)
  keymap("n", "K", vim.lsp.buf.hover, bufopts)
  keymap("n", "ga", vim.lsp.buf.code_action, bufopts)
  keymap("n", "gD", vim.lsp.buf.declaration, bufopts)
  keymap("n", "gT", vim.lsp.buf.type_definition, bufopts)
  keymap("n", "gi", vim.lsp.buf.implementation, bufopts)
  keymap("n", "gr", vim.lsp.buf.references, bufopts)
  keymap("n", "<leader>dn", vim.diagnostic.goto_next, bufopts)
  keymap("n", "<leader>dp", vim.diagnostic.goto_prev, bufopts)
  keymap("n", "<leader>r", vim.lsp.buf.rename, bufopts)
  keymap("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", bufopts)
  keymap("n", "<leader>lf", function()
    vim.lsp.buf.format({ async = true })
  end, bufopts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

local signs = {
  Error = '✘',
  Warn = '',
  Hint = '',
  Info = ''
}
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- snippets
local luasnip = require("luasnip")

luasnip.config.set_config({
  -- this tells `luasnip` to remember to keep around the last snippet
  -- you can jump back into it even if you move outside of the selection
  history = false,

  -- autosnippets
  enable_autosnippets = true,

  region_check_events = "InsertEnter",
  delete_check_events = "InsertLeave",

  -- <c-k> is the expansion key
  -- this will expand the current item or jump to the next item within the snippet
  vim.keymap.set({ "i", "s" }, "<c-k>", function ()
    if luasnip.expand_or_jumpable() then
      luasnip.expand_or_jump()
    end
  end, { silent = true }),

  -- <c-j> is the jump backwards key
  -- this always moves to the previous item within the snippet
  vim.keymap.set({ "i", "s" }, "<c-j>", function ()
    if luasnip.jumpable(-1) then
      luasnip.jump(-1)
    end
  end, { silent = true }),
})
require("luasnip.loaders.from_vscode").lazy_load()

-- Lsp server client customizations
lspconfig.lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ";"),
      },
      diagnostics = {
        -- get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      maxPreload = 100000,
      preloadFileSize = 10000,
      -- don't send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

-- bash (scripts)
lspconfig.bashls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    bashIde = {
      globPattern = "*@(.sh|.inc|.bash|.command)"
    },
  },
}

-- python
lspconfig.pylsp.setup {
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = {'W391'},
          maxLineLength = 100
        },
      },
    },
  },
}
