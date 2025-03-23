local M = {}

local ls = require("luasnip")
local sn = ls.snippet_node
local i = ls.insert_node

local function env(name)
  local is_inside = vim.fn["vimtex#env#is_inside"](name)
  return (is_inside[1] > 0 and is_inside[2] > 0)
end

M.tex = {}
M.tex.in_mathzone = function()
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end
M.tex.in_text = function()
  return env("document") and not M.tex.in_mathzone()
end
M.tex.in_bullets = function()
  return env("itemize") or env("enumerate")
end
M.tex.in_align = function ()
  return env("align") or env("align*") or env("aligned")
end

function M.get_ISO_8601_date()
  return os.date("%Y-%m-%d")
end

function M.get_visual(_, parent)
  if (#parent.snippet.env.LS_SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else
    return sn(nil, i(1, ''))
  end
end

return M
