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
  use { 'wbthomason/packer.nvim',
    opt = true,
  }
  use 'Mofiqul/vscode.nvim'
  use 'nvim-lualine/lualine.nvim'
  use {
    'ibhagwan/fzf-lua',
    requires = { 'vijaymarupudi/nvim-fzf' },
  }
  use 'ggandor/leap.nvim'
end)

--------- vscode.nvim ---------
vim.o.background = 'light'
local c = require('vscode.colors')
require('vscode').setup({
    italic_comments = true,
    disable_nvimtree_bg = true,
})
require('vscode').load()

--------- lua-line ---------
require('lualine').setup{
  options = {
    theme  = 'vscode',
    icons_enabled = false,
  },
}

--------- fzf-lua ---------
vim.api.nvim_set_keymap('n', '<c-P>',
  "<cmd>lua require('fzf-lua').files()<CR>",
  { noremap = true, silent = true })

--------- leap ---------
require('leap').set_default_keymaps()

-------------------- OPTIONS -------------------------------
opt.completeopt = {'menuone', 'noinsert', 'noselect'}  -- Completion options (for deoplete)
opt.expandtab = true                -- Use spaces instead of tabs
opt.hidden = true                   -- Enable background buffers
opt.ignorecase = true               -- Ignore case
opt.joinspaces = false              -- No double spaces with join
opt.list = true                     -- Show some invisible characters
opt.relativenumber = true           -- Show line numbers
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

-- Set indentation to 2 spaces
augroup('setIndent', { clear = true })
autocmd('Filetype', {
  group = 'setIndent',
  pattern = { 'xml', 'html', 'xhtml', 'css', 'scss', 'javascript', 'typescript',
    'yaml', 'lua', 'markdown'
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

-------------------- DEFAULTS -------------------------------

-- disable some builtin vim plugins
local default_plugins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "matchit",
  "tar",
  "tarPlugin",
  "rrhelper",
  "spellfile_plugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
  "tutor",
  "rplugin",
  "syntax",
  "synmenu",
  "optwin",
  "compiler",
  "bugreport",
  "ftplugin",
}

for _, plugin in pairs(default_plugins) do
  g["loaded_" .. plugin] = 1
end

