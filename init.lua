-- init.lua for Neovim configuration
-- Plugin management is handled declaratively in home.nix via `programs.neovim`

local o = vim.opt
local fn = vim.fn
local cmd = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- ----------------------------
-- General Settings
-- ----------------------------
o.number = true                      -- show absolute line numbers
o.relativenumber = true              -- show relative line numbers
o.mouse = 'a'                        -- enable mouse support
o.clipboard = 'unnamedplus'          -- use system clipboard
o.scrolloff = 8                     -- keep context when scrolling
o.guifont = 'FiraCode Nerd Font Mono:h11'  -- GUIs only

-- Command-line completion
o.wildmenu = true                    -- enable menu completion among matches
o.wildmode = 'longest:full,full'     -- completion mode

-- Persistent undo
o.undofile = true
local undodir = fn.stdpath('data')..'/undo'
if fn.isdirectory(undodir) == 0 then fn.mkdir(undodir, 'p') end
o.undodir = undodir

-- ----------------------------
-- Keybindings
-- ----------------------------
cmd('n', '<C-a>', '^', opts)                     -- go to line start
cmd('n', '<C-s>', ':w<CR>', opts)                -- save file
cmd('n', '<C-f>', '/', opts)                     -- search forward
cmd('n', '<C-o>', ':edit ', { noremap = true })  -- open file
cmd('n', '<C-w>', ':bd<CR>', opts)               -- close buffer

-- ----------------------------
-- Plugin Configurations
-- ----------------------------
-- Dashboard
require('dashboard').setup {
  theme = 'hyper',
  config = {
    header = { 'Welcome to Neovim' },
    center = {
      { icon = '', desc = ' Find File           ', action = 'Telescope find_files' },
      { icon = '', desc = ' Recent Files        ', action = 'Telescope oldfiles'   },
      { icon = '', desc = ' Edit Config         ', action = 'edit ~/.config/nvim/init.lua' },
      { icon = '', desc = ' Quit                ', action = 'quit'               },
    },
    footer = { 'Happy coding with Neovim!' },
  }
}

-- Telescope
require('telescope').setup {}
cmd('n', '<leader>ff', '<cmd>Telescope find_files<CR>', opts)
cmd('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', opts)
cmd('n', '<leader>fb', '<cmd>Telescope buffers<CR>', opts)
cmd('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', opts)

-- Which-key
require('which-key').setup { timeout = 300 }

-- Project.nvim
require('project_nvim').setup {}
cmd('n', '<leader>pp', '<cmd>Telescope projects<CR>', opts)

-- Move-text equivalent (vim-move)
vim.g.move_key_vertical = '<M-Up>'
vim.g.move_key_vertical = '<M-Down>'

-- Lualine
require('lualine').setup { options = { theme = 'auto' } }
