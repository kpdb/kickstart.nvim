-- [[ Setting options ]]
require 'config.options'

-- [[ Basic Keymaps ]]
require 'config.keymaps'

-- [[ Install `lazy.nvim` plugin manager ]]
require 'config.lazy'

-- [[ Configure plugins ]]
--require 'lazy-plugins'

-- [[ Configure Telescope ]]
-- (fuzzy finder)
require 'config.telescope'

-- [[ Harpoon using Telescope ]]
require 'config.harpoon'

-- [[ Configure Treesitter ]]
-- (syntax parser for highlighting)
require 'config.treesitter'

-- [[ Configure LSP ]]
-- (Language Server Protocol)
require 'config.lsp'

-- [[ Configure nvim-cmp ]]
-- (completion)
require 'config.completions'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
