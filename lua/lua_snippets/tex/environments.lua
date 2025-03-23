local tex = require("utils.luasnip_helper").tex
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local extras = require("luasnip.extras")
local rep = extras.rep
local fmta = require("luasnip.extras.fmt").fmta


local make_condition = require("luasnip.extras.conditions").make_condition
local in_bullets_cond = make_condition(tex.in_bullets)
local line_begin = require("luasnip.extras.conditions.expand").line_begin
local autosnippet = ls.extend_decorator.apply(s, { snippetType = "autosnippet" })


-- Generating functions for Matrix/Cases - thanks L3MON4D3!
local generate_matrix = function(_, snip)
  local rows = tonumber(snip.captures[2])
  local cols = tonumber(snip.captures[3])
  local nodes = {}
  local ins_indx = 1
  for j = 1, rows do
    table.insert(nodes, r(ins_indx, tostring(j) .. "x1", i(1)))
    ins_indx = ins_indx + 1
    for k = 2, cols do
      table.insert(nodes, t(" & "))
      table.insert(nodes, r(ins_indx, tostring(j) .. "x" .. tostring(k), i(1)))
      ins_indx = ins_indx + 1
    end
    table.insert(nodes, t({ "\\\\", "" }))
  end
  -- fix last node.
  nodes[#nodes] = t("\\\\")
  return sn(nil, nodes)
end

-- update for cases
local generate_cases = function(_, snip)
  local rows = tonumber(snip.captures[1]) or 2 -- default option 2 for cases
  local cols = 2                               -- fix to 2 cols
  local nodes = {}
  local ins_indx = 1
  for j = 1, rows do
    table.insert(nodes, r(ins_indx, tostring(j) .. "x1", i(1)))
    ins_indx = ins_indx + 1
    for k = 2, cols do
      table.insert(nodes, t(" & "))
      table.insert(nodes, r(ins_indx, tostring(j) .. "x" .. tostring(k), i(1)))
      ins_indx = ins_indx + 1
    end
    table.insert(nodes, t({ "\\\\", "" }))
  end
  -- fix last node.
  table.remove(nodes, #nodes)
  return sn(nil, nodes)
end


return {
  s({ trig = 'beg', name = 'begin/end', dscr = 'begin/end environment (generic)' },
    fmta([[
    \begin{<>}
    <>
    \end{<>}
    ]],
      { i(1), i(0), rep(1) }
    ), { condition = tex.in_text, show_condition = tex.in_text }),

  s({ trig = "-i", name = "itemize", dscr = "bullet points (itemize)" },
    fmta([[
    \begin{itemize}
    \item <>
    \end{itemize}
    ]],
      { c(1, { i(0), sn(nil, fmta(
        [[
        [<>] <>
        ]],
        { i(1), i(0) })) })
      }
    ),
    { condition = tex.in_text, show_condition = tex.in_text }),

  -- requires enumitem
  s({ trig = "-e", name = "enumerate", dscr = "numbered list (enumerate)" },
    fmta([[
    \begin{enumerate}<>
    \item <>
    \end{enumerate}
    ]],
      { c(1, { t(""), sn(nil, fmta(
        [[
        [label=<>]
        ]],
        { c(1, { t("(\\alph*)"), t("(\\roman*)"), i(1) }) })) }),
        c(2, { i(0), sn(nil, fmta(
          [[
        [<>] <>
        ]],
          { i(1), i(0) })) })
      }
    ),
    { condition = tex.in_text, show_condition = tex.in_text }),

  -- generate new bullet points
  autosnippet({ trig = "--", hidden = true }, { t("\\item") },
    { condition = in_bullets_cond * line_begin, show_condition = in_bullets_cond * line_begin }
  ),
  autosnippet({ trig = "!-", name = "bullet point", dscr = "bullet point with custom text" },
    fmta([[
    \item [<>]<>
    ]],
      { i(1), i(0) }),
    { condition = in_bullets_cond * line_begin, show_condition = in_bullets_cond * line_begin }
  ),

  -- SNIPPETS FOR MATH ENVIRONMENT
  -- Math modes
  autosnippet({ trig = "mk", name = "$..$", dscr = "inline math" },
    fmta([[
    $<>$<>
    ]],
      { i(1), i(0) })),

  autosnippet({ trig = "dm", name = "\\[...\\]", dscr = "display math" },
    fmta([[
    \[
    <>
    \]
    <>]],
      { i(1), i(0) }),
    { condition = line_begin, show_condition = line_begin }),

  autosnippet({ trig = "ali", name = "align(|*|ed)", dscr = "align math" },
    fmta([[
    \begin{align<>}
    <>
    \end{align<>}
    ]],
      { c(1, { t("*"), t(""), t("ed") }), i(2), rep(1) }), -- in order of least-most used
    { condition = line_begin, show_condition = line_begin }),

  autosnippet({ trig = '==', name = '&= align', dscr = '&= align' },
    fmta([[
    &<> <> \\
    ]],
      { c(1, { t("="), t("\\leq"), i(1) }), i(2) }
    ), { condition = tex.in_align, show_condition = tex.in_align }),

  autosnippet({ trig = "gat", name = "gather(|*|ed)", dscr = "gather math" },
    fmta([[
    \begin{gather<>}
    <>
    \end{gather<>}
    ]],
      { c(1, { t("*"), t(""), t("ed") }), i(2), rep(1) }),
    { condition = line_begin, show_condition = line_begin }),

  autosnippet({ trig = "eqn", name = "equation(|*)", dscr = "equation math" },
    fmta([[
    \begin{equation<>}
    <>
    \end{equation<>}
    ]],
      { c(1, { t("*"), t("") }), i(2), rep(1) }),
    { condition = line_begin, show_condition = line_begin }),

  -- Matrices and Cases
  autosnippet({ trig = "([bBpvV])mat(%d+)x(%d+)([ar])", name = "[bBpvV]matrix", dscr = "matrices", regTrig = true, hidden = true },
    fmta([[
    \begin{<>}<>
    <>
    \end{<>}]],
      { f(function(_, snip)
        return snip.captures[1] .. "matrix"
      end),
        f(function(_, snip)
          if snip.captures[4] == "a" then
            local out = string.rep("c", tonumber(snip.captures[3]) - 1)
            return "[" .. out .. "|c]"
          end
          return ""
        end),
        d(1, generate_matrix),
        f(function(_, snip)
          return snip.captures[1] .. "matrix"
        end)
      }),
    { condition = tex.in_math, show_condition = tex.in_math }),

  autosnippet({ trig = "(%d?)cases", name = "cases", dscr = "cases", regTrig = true, hidden = true },
    fmta([[
    \begin{cases}
    <>
    \end{cases}
    ]],
      { d(1, generate_cases) }),
    { condition = tex.in_math, show_condition = tex.in_math }),
}
