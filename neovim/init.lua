-------------------- SETUP ---------------------------------
-- git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

-------------------- HELPERS -------------------------------
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local augroup = vim.api.nvim_create_augroup   -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd   -- Create autocommand

-------------------- PLUGINS -------------------------------
vim.cmd [[packadd packer.nvim]]

require('packer').startup(function()
  use {'wbthomason/packer.nvim', opt = true}
   use { "catppuccin/nvim", as = "catppuccin" }
  use { 'ibhagwan/fzf-lua',
   requires = { 'vijaymarupudi/nvim-fzf' }
  }
  use {
    'nvim-lualine/lualine.nvim',
  }
  use "kyazdani42/nvim-tree.lua"
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }
  use {"ellisonleao/glow.nvim"}
end)

--------- catpuccin.nvim ---------
vim.g.catppuccin_flavour = "frappe"
require("catppuccin").setup()
vim.cmd [[colorscheme catppuccin]]

--------- lua-line ---------
require('lualine').setup{
  options = {
    theme  = 'catppuccin',
    icons_enabled = false,
  },
}

--------- fzf-lua ---------
vim.api.nvim_set_keymap('n', '<c-P>',
  "<cmd>lua require('fzf-lua').files()<CR>",
  { noremap = true, silent = true })

--------- nvim-tree ---------

vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
  sort_by = "case_sensitive",
  renderer = {
    icons = {
      show = {
        file = false,
        folder = false,
        folder_arrow = false,
        git = false,
      },
    },
  },
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  filters = {
    dotfiles = true,
  },
})

map('n', '<C-n>', ':NvimTreeToggle<CR>')            -- open/close

-------------------- OPTIONS -------------------------------
opt.completeopt = {'menuone', 'noinsert', 'noselect'}  -- Completion options (for deoplete)
opt.expandtab = true                -- Use spaces instead of tabs
opt.hidden = true                   -- Enable background buffers
opt.ignorecase = true               -- Ignore case
opt.joinspaces = false              -- No double spaces with join
opt.list = true                     -- Show some invisible characters
opt.number = true                   -- Show line numbers
opt.relativenumber = true           -- Relative line numbers
opt.scrolloff = 4                   -- Lines of context
opt.shiftround = true               -- Round indent
opt.shiftwidth = 4                  -- Size of an indent
opt.sidescrolloff = 8               -- Columns of context
opt.smartcase = true                -- Do not ignore case with capitals
opt.smartindent = true              -- Insert indents automatically
opt.splitbelow = true               -- Put new windows below current
opt.splitright = true               -- Put new windows right of current
opt.tabstop = 2                     -- Number of spaces tabs count for
opt.termguicolors = true            -- True color support
opt.wildmode = {'list', 'longest'}  -- Command-line completion mode
opt.wrap = false                    -- Disable line wrap
opt.lazyredraw = true               -- Faster scrolling

-- escape
map('i', 'jk', '<Esc>')
map('i', 'jj', '<Esc>')

-- navigate panes
map('n', '<c-j>', '<c-w>j')
map('n', '<c-h>', '<c-w>h')
map('n', '<c-k>', '<c-w>k')
map('n', '<c-l>', '<c-w>l')

-------------------- AUTOCMDS -------------------------------

-- Highlight yanked area
augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
  group = 'YankHighlight',
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = '1000' })
  end
})

-- Remove whitespace on save
autocmd('BufWritePre', {
  pattern = '',
  command = ":%s/\\s\\+$//e"
})

-- Set indentation to 2 spaces
augroup('setIndent', { clear = true })
autocmd('Filetype', {
  group = 'setIndent',
  pattern = { 'xml', 'html', 'xhtml', 'css', 'scss', 'javascript', 'typescript',
    'yaml', 'lua'
  },
  command = 'setlocal shiftwidth=2 tabstop=2'
})

-- Wrap lines in markdown
augroup('wrapLines', { clear = true })
autocmd('Filetype', {
  group = 'wrapLines',
  pattern = { 'markdown' },
  command = 'setlocal wrap linebreak'
})
