-- Set leader key
vim.g.mapleader = " "

vim.g.have_nerd_font = true
vim.wo.relativenumber = true
vim.wo.number = true
vim.opt.cursorline = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 10
vim.opt.inccommand = 'split'
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- LSP independent neovim autocomplete
vim.o.autocomplete = false

-- Sync system clipboard with neovim one
vim.opt.clipboard = "unnamedplus"

-- Reserve space in the gutter for git signs and diagnostics
vim.opt.signcolumn = 'yes'

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Creating cmd for updating packages
vim.api.nvim_create_user_command('PackUpdate', function()
  vim.pack.update()
end, {})
