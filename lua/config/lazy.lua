-- install lazy.nvim
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

-- configure lazy.nvim
require("lazy").setup {
    spec = {
        { import = "base" },
        { import = "pde" },
    },
    defaults = { lazy = true, version = nil },
    install = { missing = true, colorscheme = { "tokyonight", "catppuccin" } },
    checker = { enabled = true },
    performance = {
        cache = {
            enabled = true,
        },
        rtp = {
            disabled_plugins = {
                "gzip",
                "tarPlugin",
                "tohtml",
                "zipPlugin",
            },
        },
    },
}
