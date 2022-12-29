local api = vim.api
local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
  return
end

bufferline.setup {
  options = {
    mode = "buffers",
    numbers = "none",
    close_command = "bdelete! %d",
    right_mouse_command = "bdelete! %d",
    left_mouse_command = "buffer %d",
    middle_mouse_command = nil,
    indicator = "▎",
    buffer_close_icon = "",
    modified_icon = "●",
    close_icon = "",
    left_trunc_marker = "",
    right_truc_marker = "",
    max_name_length = 14,
    max_prefix_length = 13,
    tab_size = 20,
    diagnostics = false,
    diagnostics_update_in_insert = false,
    offsets = { {filetype = "NvimTree", text = "", padding = 1} },
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    persist_buffer_sort = true,
    separator_style = "thin",
    enforce_regular_tabs = true,
    always_show_bufferline = true,
  },
}

api.nvim_set_keymap("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", {})
api.nvim_set_keymap("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", {})
