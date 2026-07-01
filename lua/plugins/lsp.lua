vim.pack.add({ { src = "https://github.com/mason-org/mason.nvim" } })
vim.pack.add({ { src = "https://github.com/mason-org/mason-lspconfig.nvim" } })
vim.pack.add({ { src = "https://github.com/neovim/nvim-lspconfig" } }) -- For automatic LSPs configuration

require("mason").setup()
require("mason-lspconfig").setup({})

-- Autosuggestion native (Neovim 0.12+)
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method("textDocument/completion") and vim.bo[args.buf].filetype ~= "TelescopePrompt" then
      -- Disable default autotrigger to prevent popup on spaces or empty lines
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = false })

      -- Trigger completion only when the character before the cursor is not whitespace
      vim.api.nvim_create_autocmd("TextChangedI", {
        buffer = args.buf,
        callback = function()
          local col = vim.api.nvim_win_get_cursor(0)[2]
          if vim.api.nvim_get_current_line():sub(col, col):match("%S") then
            vim.lsp.completion.get()
          end
        end,
      })
    end

    local opts = { buffer = args.buf }
    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)

    -- Diagnostic keymaps
    vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1 }) end, opts)
    vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1 }) end, opts)
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
  end,
})

-- Automatic enabling of installed LSPs with Mason
for _, server in ipairs(require("mason-lspconfig").get_installed_servers()) do
  vim.lsp.enable(server)
end

-- Always activate suggestions
vim.opt.complete:append('o')

-- Diagnostic configuration (Error Lens effect)
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '✘',
      [vim.diagnostic.severity.WARN] = '▲',
      [vim.diagnostic.severity.HINT] = '⚑',
      [vim.diagnostic.severity.INFO] = '»',
    },
  },
  virtual_text = true,
  underline = true,
})

vim.opt.completeopt = { 'menuone', 'noinsert' }

-- Autocompletion and Snippets navigation
vim.keymap.set({ "i", "s" }, "<Tab>", function()
  if vim.snippet.active({ direction = 1 }) then
    return "<Cmd>lua vim.snippet.jump(1)<CR>"
  elseif vim.fn.pumvisible() == 1 then
    return "<C-n>"
  else
    return "<Tab>"
  end
end, { expr = true, noremap = true })

vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
  if vim.snippet.active({ direction = -1 }) then
    return "<Cmd>lua vim.snippet.jump(-1)<CR>"
  elseif vim.fn.pumvisible() == 1 then
    return "<C-p>"
  else
    return "<S-Tab>"
  end
end, { expr = true, noremap = true })
