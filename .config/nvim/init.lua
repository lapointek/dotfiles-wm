require('config.options')
require('config.keybinds')
require('config.autocmds')
require('core.lazy')
require('core.lsp')

-- Colorscheme settings
require("rose-pine").setup({
    variant = "main",
    dark_variant = "main",
    dim_inactive_windows = false,
    extend_background_behind_borders = true,
    styles = {
        bold = true,
        italic = false,
        transparency = false,
    },
    highlight_groups = {
        Comment = { italic = true }
    },
})

vim.cmd("colorscheme rose-pine")

