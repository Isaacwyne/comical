local present, colorscheme = pcall(require, "kanagawa")
if not present then
  return
end

-- Default options:
colorscheme.setup({
    undercurl = true,           -- enable undercurls
    commentStyle = { italic = true },
    transparent = true,
    colors = {
      theme = {
        all = {
          ui = {
            bg_gutter = "none",
          },
        },
      },
    },
})

-- setup must be called before loading
vim.cmd("colorscheme kanagawa")
