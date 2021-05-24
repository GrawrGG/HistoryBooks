--[[
Config file for luacheck: https://github.com/mpeterv/luacheck
We lean on the WoW API + Lua VS Code extensions for globals, otherwise we have to configure a few thousand excludes here.
Configure exclusions for unknown globals in .vscode/settings.json.
--]]
ignore = {
  "11", -- Disable read/write warnings for globals
  "211/logger" -- Sometimes we define a local 'logger' var before we actually want to use it.
}
max_line_length = 160
max_code_line_length = 160
max_string_line_length = 160
max_comment_line_length = 160
self = false -- Disable 'unused argument self'
