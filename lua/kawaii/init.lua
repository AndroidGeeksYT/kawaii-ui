local api = vim.api
local config = require "kawaii"
local new_cmd = api.nvim_create_user_command

if config.ui.statusline.enabled then
  vim.o.statusline = "%!v:lua.require('kawaii.stl." .. config.ui.statusline.theme .. "')()"
  require("kawaii.stl.utils").autocmds()
end

if config.ui.tabufline.enabled then
  require "kawaii.tabufline.lazyload"
end

-- Command to toggle KawaiiDash
new_cmd("Kawaiidash", function()
  if vim.g.kawaiidash_displayed then
    require("kawaii.tabufline").close_buffer(vim.g.kawaiidash_buf)
  else
    require("kawaii.kawaiidash").open()
  end
end, {})

new_cmd("KwCheatsheet", function()
  if vim.g.kwcheatsheet_displayed then
    vim.cmd "bw"
  else
    require("kawaii.cheatsheet." .. config.cheatsheet.theme)()
  end
end, {})

vim.schedule(function()
  require "kawaii.au"
end)
