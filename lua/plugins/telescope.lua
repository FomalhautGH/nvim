vim.pack.add({ 
  { src = "https://github.com/nvim-lua/plenary.nvim" }, 
  { src = "https://github.com/nvim-telescope/telescope.nvim" } 
})

local builtin = require('telescope.builtin')

-- Related keymaps
vim.keymap.set('n', '<leader>fi', builtin.find_files, { desc = "Find Files" })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live Grep" })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Find Buffers" })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Find Help" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "TelescopePrompt",
  callback = function()
    vim.opt_local.complete:remove('o')
    vim.opt_local.autocomplete = false
  end,
})
