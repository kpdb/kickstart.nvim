-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "rust-analyzer",
      },
    },
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^3",
    ft = { 'rust' },
    init = function()
      vim.g.rustaceanvim = {
        tools = {},
        server = {
          on_attach = function(client, bufnr)
            -- put keymaps here
          end,
          settings = {
            ['rust-analyzer'] = {},
          },
        },
        dap = {},
      }
    end,
  },
}
