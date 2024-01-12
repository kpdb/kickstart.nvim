return {
    {
        "nvim-tree/nvim-web-devicons",
        dependencies = { "DaikyXendo/nvim-material-icon" },
        config = function()
            require("nvim-web-devicons").setup {
                override = require("nvim-material-icon").get_icons(),
            }
        end,
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            style = "moon",
            transparent = false,
            styles = {
                comments = { italic = true },
                keywords = { italic = true },
                sidebars = "transparent",
                floats = "transparent",
            },
        },
        config = function(_, opts)
            local tokyonight = require "tokyonight"
            tokyonight.setup(opts)
            tokyonight.load()
        end,
    },
    { "catppuccin/nvim", lazy = false, name = "catppuccin" },
    {
        "stevearc/dressing.nvim",
        event = "VeryLazy",
        opts = {},
    },
    {
        "folke/noice.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        event = "VeryLazy",
        enabled = true,
        opts = {
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            routes = {
                {
                    filter = {
                        event = "msg_show",
                        find = "%d+L, %d+B",
                    },
                    view = "mini",
                },
            },
            presets = {
                bottom_search = true,
                command_palette = true,
                long_message_to_split = true,
                inc_rename = true,
                lsp_doc_border = true,
            },
        },
        keys = {
            { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end,                 mode = "c",    desc = "Redirect Cmdline" },
            { "<c-f>",     function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end,  silent = true, expr = true,              desc = "Scroll forward" },
            { "<c-b>",     function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true,              desc = "Scroll backward" },
        },
    },
}
