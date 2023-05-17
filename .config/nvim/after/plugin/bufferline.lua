local present, bufferline = pcall(require, "bufferline")

if not present then
  return
end

local opts = {
  options = {
    diagnostics = "nvim_lsp",
    always_show_bufferline = false,
    buffer_close_icon = '󰅖',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    offsets = {
      {
        filetype = "neo-tree",
        text = "Neo-tree",
        highlight = "Directory",
        text_align = "left",
      },
    },
  },
}

bufferline.setup(opts)
