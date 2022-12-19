local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    return
end

telescope.setup({
    defaults = {
        layout_config = {
            width = 0.8,
            height = 0.85,
            preview_cutoff = 120,
        },
        horizontal = {
            preview_width = 0.6,
            results_width = 0.8,
        },
        vertical = {
            mirror = false,
        },
        flex = {
            horizontal = {
                preview_width = 0.9,
            },
        },
        find_command = {
            "rg",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
        },
        prompt_prefix = "$ ",
        selection_caret = " ",
        entry_prefix = " ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "descending",
        layout_strategy = "horizontal",
        file_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        file_ignore_patterns = {},
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        path_display = { "truncate" },
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        use_less = true,
        set_env = { ["COLORTERM"] = "truecolor" },
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
    },
})
