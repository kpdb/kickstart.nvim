local Util = require("lazyvim.util")

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
    },
    opts = {
      ensure_installed = {
        "arduino",
        "bash",
        "c",
        "cmake",
        "cpp",
        "css",
        "csv",
        "dockerfile",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "go",
        "graphql",
        "html",
        "htmldjango",
        "http",
        "javascript",
        "json",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "ocaml",
        "python",
        "rust",
        "scss",
        "sql",
        "svelte",
        "yaml",
      },

      -- matchup = {
      -- 	enable = true,
      -- },

      -- https://github.com/nvim-treesitter/playground#query-linter
      query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
      },

      playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = true, -- Whether the query persists across vim sessions
        keybindings = {
          toggle_query_editor = "o",
          toggle_hl_groups = "i",
          toggle_injected_languages = "t",
          toggle_anonymous_nodes = "a",
          toggle_language_display = "I",
          focus_language = "f",
          unfocus_language = "F",
          update = "R",
          goto_node = "<cr>",
          show_help = "?",
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)

      -- MDX
      vim.filetype.add({
        extension = {
          mdx = "mdx",
        },
      })
      vim.treesitter.language.register("markdown", "mdx")
    end,
  },

  -- Fuzzy finder.
  -- The default key bindings to find files will use Telescope's
  -- `find_files` or `git_files` depending on whether the
  -- directory is a git repo.
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false, -- telescope did only one release, so use HEAD for now
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        enabled = vim.fn.executable("make") == 1,
        config = function()
          Util.on_load("telescope.nvim", function()
            require("telescope").load_extension("fzf")
          end)
        end,
      },
      {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = {
          "nvim-telescope/telescope.nvim",
          "nvim-lua/plenary.nvim",
          "nvim-tree/nvim-web-devicons",
        },
      },
    },
    keys = function()
      return {
        {
          "<leader>,",
          "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
          desc = "Switch Buffer",
        },
        { "<leader>/", Util.telescope("live_grep"), desc = "Grep (root dir)" },
        { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
        { "<leader><space>", Util.telescope("files"), desc = "Find Files (root dir)" },
        -- find
        { "<leader>fb", "<cmd>Telescope file_browser<cr>", desc = "Browse files (root dir)" },
        { "<leader>fB", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>", desc = "Browse files (cwd)" },
        { "<leader>fc", Util.telescope.config_files(), desc = "Find Config File" },
        { "<leader>ff", Util.telescope("files"), desc = "Find Files (root dir)" },
        { "<leader>fF", Util.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
        { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
        { "<leader>fR", Util.telescope("oldfiles", { cwd = vim.loop.cwd() }), desc = "Recent (cwd)" },
        -- git
        { "<leader>fg", "<cmd>Telescope git_files<CR>", desc = "Git Files (root dir)" },
        { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
        { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
        -- search
        { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
        { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
        { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
        { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
        { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
        { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
        { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
        { "<leader>sg", Util.telescope("live_grep"), desc = "Grep (root dir)" },
        { "<leader>sG", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
        { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
        { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
        { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
        { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
        { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
        { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
        { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
        { "<leader>sw", Util.telescope("grep_string", { word_match = "-w" }), desc = "Word (root dir)" },
        { "<leader>sW", Util.telescope("grep_string", { cwd = false, word_match = "-w" }), desc = "Word (cwd)" },
        { "<leader>sw", Util.telescope("grep_string"), mode = "v", desc = "Selection (root dir)" },
        { "<leader>sW", Util.telescope("grep_string", { cwd = false }), mode = "v", desc = "Selection (cwd)" },
        { "<leader>uC", Util.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
        {
          "<leader>ss",
          function()
            require("telescope.builtin").lsp_document_symbols({
              symbols = require("lazyvim.config").get_kind_filter(),
            })
          end,
          desc = "Goto Symbol",
        },
        {
          "<leader>sS",
          function()
            require("telescope.builtin").lsp_dynamic_workspace_symbols({
              symbols = require("lazyvim.config").get_kind_filter(),
            })
          end,
          desc = "Goto Symbol (Workspace)",
        },
      }
    end,
    opts = function()
      local actions = require("telescope.actions")
      local fb_actions = require("telescope").extensions.file_browser.actions

      local open_with_trouble = function(...)
        return require("trouble.providers.telescope").open_with_trouble(...)
      end
      local open_selected_with_trouble = function(...)
        return require("trouble.providers.telescope").open_selected_with_trouble(...)
      end
      local find_files_no_ignore = function()
        local action_state = require("telescope.actions.state")
        local line = action_state.get_current_line()
        Util.telescope("find_files", { no_ignore = true, default_text = line })()
      end
      local find_files_with_hidden = function()
        local action_state = require("telescope.actions.state")
        local line = action_state.get_current_line()
        Util.telescope("find_files", { hidden = true, default_text = line })()
      end

      return {
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          -- open files in the first window that is an actual file.
          -- use the current window if no other window is available.
          get_selection_window = function()
            local wins = vim.api.nvim_list_wins()
            table.insert(wins, 1, vim.api.nvim_get_current_win())
            for _, win in ipairs(wins) do
              local buf = vim.api.nvim_win_get_buf(win)
              if vim.bo[buf].buftype == "" then
                return win
              end
            end
            return 0
          end,
          mappings = {
            i = {
              ["<c-t>"] = open_with_trouble,
              ["<a-t>"] = open_selected_with_trouble,
              ["<a-i>"] = find_files_no_ignore,
              ["<a-h>"] = find_files_with_hidden,
              ["<C-Down>"] = actions.cycle_history_next,
              ["<C-Up>"] = actions.cycle_history_prev,
              ["<C-f>"] = actions.preview_scrolling_down,
              ["<C-b>"] = actions.preview_scrolling_up,
            },
            n = {
              ["q"] = actions.close,
            },
          },
          extensions = {
            file_browser = {
              path = vim.loop.cwd(),
              cwd = vim.loop.cwd(),
              cwd_to_path = false,
              grouped = false,
              files = true,
              add_dirs = true,
              depth = 1,
              auto_depth = false,
              select_buffer = false,
              hidden = { file_browser = false, folder_browser = false },
              respect_gitignore = vim.fn.executable("fd") == 1,
              no_ignore = false,
              follow_symlinks = false,
              browse_files = require("telescope._extensions.file_browser.finders").browse_files,
              browse_folders = require("telescope._extensions.file_browser.finders").browse_folders,
              hide_parent_dir = false,
              collapse_dirs = false,
              prompt_path = false,
              quiet = false,
              dir_icon = "",
              dir_icon_hl = "Default",
              display_stat = { date = true, size = true, mode = true },
              hijack_netrw = true,
              use_fd = true,
              git_status = true,
              mappings = {
                ["i"] = {
                  ["N"] = fb_actions.create,
                  ["<S-CR>"] = fb_actions.create_from_prompt,
                  ["<A-r>"] = fb_actions.rename,
                  ["<A-m>"] = fb_actions.move,
                  ["<A-y>"] = fb_actions.copy,
                  ["<A-d>"] = fb_actions.remove,
                  ["<C-o>"] = fb_actions.open,
                  ["<C-g>"] = fb_actions.goto_parent_dir,
                  ["<C-e>"] = fb_actions.goto_home_dir,
                  ["<C-w>"] = fb_actions.goto_cwd,
                  ["<C-t>"] = fb_actions.change_cwd,
                  ["<C-f>"] = fb_actions.toggle_browser,
                  ["<C-h>"] = fb_actions.toggle_hidden,
                  ["<C-s>"] = fb_actions.toggle_all,
                  ["<bs>"] = fb_actions.backspace,
                },
                ["n"] = {
                  ["c"] = fb_actions.create,
                  ["r"] = fb_actions.rename,
                  ["m"] = fb_actions.move,
                  ["y"] = fb_actions.copy,
                  ["d"] = fb_actions.remove,
                  ["o"] = fb_actions.open,
                  ["g"] = fb_actions.goto_parent_dir,
                  ["e"] = fb_actions.goto_home_dir,
                  ["w"] = fb_actions.goto_cwd,
                  ["t"] = fb_actions.change_cwd,
                  ["f"] = fb_actions.toggle_browser,
                  ["h"] = fb_actions.toggle_hidden,
                  ["s"] = fb_actions.toggle_all,
                },
              },
            },
          },
        },
      }
    end,
  },
  {
    "laytan/cloak.nvim",
    config = function()
      require("cloak").setup({
        enabled = true,
        cloak_character = "*",
        highlight_group = "Comment",
        patterns = {
          {
            file_pattern = {
              ".env",
            },
            cloak_pattern = "=.*",
          },
        },
      })
    end,
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup({})

      -- basic telescope configuration
      local conf = require("telescope.config").values
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require("telescope.pickers")
          .new({}, {
            prompt_title = "Harpoon",
            finder = require("telescope.finders").new_table({
              results = file_paths,
            }),
            previewer = conf.file_previewer({}),
            sorter = conf.generic_sorter({}),
          })
          :find()
      end

      vim.keymap.set("n", "<leader>hf", function()
        toggle_telescope(harpoon:list())
      end, { desc = "List Harpoon files" })
      vim.keymap.set("n", "<leader>ha", function()
        if harpoon:list():length() >= 3 then
          harpoon:list():removeAt(1)
        end
        harpoon:list():append()
      end, { desc = "Add file to harpoon" })
      vim.keymap.set("n", "<leader>hr", function()
        harpoon:list():select(1)
      end, { desc = "Harpoon first file" })
      vim.keymap.set("n", "<leader>hs", function()
        harpoon:list():select(2)
      end, { desc = "Harpoon second file" })
      vim.keymap.set("n", "<leader>ht", function()
        harpoon:list():select(3)
      end, { desc = "Harpoon third file" })
      vim.keymap.set("n", "<leader>he", function()
        harpoon:list():prev()
      end, { desc = "Harpoon previous file" })
      vim.keymap.set("n", "<leader>hi", function()
        harpoon:list():prev()
      end, { desc = "Harpoon next file" })
      vim.keymap.set("n", "<leader>ho", function()
        harpoon:list():clear()
      end, { desc = "Clear all harpoons" })
    end,
  },
}
