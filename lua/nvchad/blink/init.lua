local M = {}
local hlcache = {}
local ui = require("nvconfig").ui.cmp
local atom_styled = ui.style == "atom" or ui.style == "atom_colored"

local menu_cols
if atom_styled or ui.icons_left then
  menu_cols = { { "kind_icon" }, { "label" }, { "kind" } }
else
  menu_cols = { { "label" }, { "kind_icon" }, { "kind" } }
end

M.components = {
  kind_icon = {
    text = function(ctx)
      local icons = require "nvchad.icons.lspkind"
      local icon = (icons[ctx.kind] or "󰈚")

      if atom_styled then
        icon = " " .. icon .. " "
      end

      if ui.format_colors.lsp and ctx.kind == "Color" then
        return ui.format_colors.icon
      end
      return icon
    end,
  },

  kind = {
    highlight = function(ctx)
      if ctx.kind == "Color" then
        return M.format_color_hl(ctx)
      end
      return atom_styled and "comment" or ctx.kind
    end,
  },
}

M.menu = {
  scrollbar = false,
  border = atom_styled and "none" or "single",
  draw = {
    columns = menu_cols,
    components = M.components,
  },
}

M.format_color_hl = function(ctx)
  local color = ctx.item.documentation

  if color and type(color) == "string" and color:match "^#%x%x%x%x%x%x$" then
    local hl = "hex-" .. color:sub(2)

    if not hlcache[hl] then
      vim.api.nvim_set_hl(0, hl, { fg = color })
      hlcache[hl] = true
    end

    return hl
  end
end

return M
