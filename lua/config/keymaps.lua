-- For NetRW
vim.keymap.set("n", "<leader>nw", vim.cmd.Ex, { noremap = true })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  callback = function()
    vim.keymap.set("n", "J", "<CR>", { remap = true, buffer = true })
  end,
})

-- Center while scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Commodities
vim.keymap.set("n", "H", "^")
vim.keymap.set("n", "L", "$")
vim.keymap.set("n", "cn", "<cmd>:cnext<CR>")
vim.keymap.set("n", "cp", "<cmd>:cprev<CR>")

-- Remove highlighting search with Esc
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
