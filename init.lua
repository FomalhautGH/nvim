require("config.options")
require("config.keymaps")

-- Plugins
require("plugins.tmux-navigator")
require("plugins.lsp") -- Contains mason, mason-lspconfig and nvim-lspconfig
require("plugins.autopairs")
require("plugins.telescope")
require("plugins.cord")
require("plugins.gitsigns")

-- Language-specific plugins
require("plugins.languages.vala")

local theme = vim.fn.hostname() == "fedora" and "kanagawa" or "tokyonight"
require("plugins." .. theme)
