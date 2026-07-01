vim.pack.add({ { src = "https://github.com/folke/tokyonight.nvim" } })

local ok, matugen = pcall(require, "config.colors")
if not ok then matugen = {} end

require("tokyonight").setup({
  style = "night",
  transparent = true,
  on_colors = function(c)
    if matugen.surface then
      c.bg = matugen.surface
      c.bg_dark = matugen.surface_container
      c.bg_highlight = matugen.surface_container
      c.fg = matugen.on_surface
      c.fg_dark = matugen.outline
      c.fg_gutter = matugen.outline
      c.blue = matugen.tertiary
      c.cyan = matugen.on_tertiary_container
      c.magenta = matugen.primary
      c.purple = matugen.on_primary_container
      c.orange = matugen.secondary
      c.yellow = matugen.on_secondary_container
      c.green = matugen.tertiary_fixed or matugen.tertiary
      c.red = matugen.error
      c.error = matugen.error
      c.warning = matugen.secondary -- Yellowish, clearly a warning, not an error
      c.info = matugen.tertiary -- Cyan/Greenish
      c.hint = matugen.on_tertiary_container
      c.comment = matugen.outline
      c.border = matugen.outline
    end
  end,
})

vim.cmd[[colorscheme tokyonight]]
