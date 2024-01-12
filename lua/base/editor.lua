return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        cmd = "Telescope",
        -- stylua: ignore
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
            { "<leader>fg", "<cmd>Telescope git_files<cr>",  desc = "Git Files" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>",    desc = "Buffers" },
            { "<leader>fh", "<cmd>Telescope help_tags<cr>",  desc = "Help" },
        },
        opts = {
            defaults = {
                mappings = {
                    i = {
                        ["<C-j>"] = function(...)
                            require("telescope.actions").move_selection_next(...)
                        end,
                        ["<C-k>"] = function(...)
                            require("telescope.actions").move_selection_previous(...)
                        end,
                        ["<C-n>"] = function(...)
                            require("telescope.actionc").cycle_history_next(...)
                        end,
                        ["<C-p>"] = function(...)
                            require("telescope.actions").cycle_history_prev(...)
                        end,
                    },
                },
            },
        },
        config = function(_, opts)
            local telescope = require "telescope"
            telescope.setup(opts)
            telescope.load_extension "fzf"
        end,
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            setup = {
                show_help = true,
                plugins = { spelling = true },
                key_labels = { ["<leader>"] = "SPC" },
                triggers = "auto",
                window = {
                    border = "single",
                    position = "bottom",
                    margin = { 1, 0, 1, 0 },
                    padding = { 1, 1, 1, 1 },
                    winblind = 0,
                },
                layout = {
                    height = { min = 4, max = 25 },
                    width = { min = 20, max = 50 },
                    spacing = 3,
                    align = "left",
                },
            },
            defaults = {
                mode = { "n", "v" },
                ["<leader>f"] = { name = "+File" },
                ["<leader>q"] = { name = "+Quit/Session" },
                ["<leader>qq"] = { cmd = "<cmd>q<cr>", name = "Quit" },
                ["<leader>w"] = { cmd = "<cmd>update!<cr>", name = "Save" },
            },
        },
        config = function(_, opts)
            local wk = require "which-key"
            wk.setup(opts.setup)
            wk.register(opts.defaults)
        end,
    },
    {
        "anuvyklack/hydra.nvim",
        event = "VeryLazy",
        opts = {
            spec = {},
        },
        config = function(_, opts)
            local hydra = require "hydra"
            for s, _ in pairs(opts.specs) do
                hydra(opts.specs[s]())
            end
        end,
    },
    {
        "folke/edgy.nvim",
        event = "VeryLazy",
        opts = {
            left = {
                { ft = "hydra_hint", title = "Hydra", size = { height = 0.5 }, pinned = true },
            },
        },
    },
}
