local api = vim.api
local config = require "kawaii"
local new_cmd = api.nvim_create_user_command

if config.ui.statusline.enabled then
  vim.o.statusline = "%!v:lua.require('nvchad.stl." .. config.ui.statusline.theme .. "')()"
  require("nvchad.stl.utils").autocmds()
end

if config.ui.tabufline.enabled then
  require "nvchad.tabufline.lazyload"
end

-- Command to toggle KawaiiDash
new_cmd("Kawaiidash", function()
  if vim.g.kawaiidash_displayed then
    require("nvchad.tabufline").close_buffer(vim.g.kawaiidash_buf)
  else
    require("nvchad.kawaiidash").open()
  end
end, {})

new_cmd("NvCheatsheet", function()
  if vim.g.nvcheatsheet_displayed then
    vim.cmd "bw"
  else
    require("nvchad.cheatsheet." .. config.cheatsheet.theme)()
  end
end, {})

vim.schedule(function()
  require "nvchad.au"
end)
