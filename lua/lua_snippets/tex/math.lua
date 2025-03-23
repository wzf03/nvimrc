local get_visual = require("utils.luasnip_helper").get_visual
local tex = require("utils.luasnip_helper").tex
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmta = require("luasnip.extras.fmt").fmta

local autosnippet = ls.extend_decorator.apply(s, { snippetType = "autosnippet" })

local function symbol_snippet(context, command, opts)
  opts = opts or {}
  if not context.trig then
    error("context doesn't include a `trig` key which is mandatory", 2)
  end
  context.dscr = context.dscr or command
  context.name = context.name or command:gsub([[\]], "")
  context.docstring = context.docstring or (command .. [[{0}]])
  context.wordTrig = context.wordTrig or false
  local j, _ = string.find(command, context.trig)
  if j == 2 then -- command always starts with backslash
    context.trigEngine = "ecma"
    context.trig = "(?<!\\\\)" .. "(" .. context.trig .. ")"
    context.hidden = true
  end
  return autosnippet(context, t(command), opts)
end

M = {
  -- SUPERSCRIPT
  autosnippet({ trig = "([%w%)%]%}])'", wordTrig = false, regTrig = true },
    fmta(
      "<>^{<>}",
      {
        f(function(_, snip) return snip.captures[1] end),
        d(1, get_visual),
      }
    ),
    { condition = tex.in_mathzone }
  ),
  -- SUBSCRIPT
  autosnippet({ trig = "([%w%)%]%}]);", wordTrig = false, regTrig = true },
    fmta(
      "<>_{<>}",
      {
        f(function(_, snip) return snip.captures[1] end),
        d(1, get_visual),
      }
    ),
    { condition = tex.in_mathzone }
  ),
  -- SUBSCRIPT AND SUPERSCRIPT
  autosnippet({ trig = "([%w%)%]%}])__", wordTrig = false, regTrig = true },
    fmta(
      "<>^{<>}_{<>}",
      {
        f(function(_, snip) return snip.captures[1] end),
        i(1),
        i(2),
      }
    ),
    { condition = tex.in_mathzone }
  ),
  -- TEXT SUBSCRIPT
  autosnippet({ trig = 'sd', wordTrig = false },
    fmta("_{\\mathrm{<>}}",
      { d(1, get_visual) }
    ),
    { condition = tex.in_mathzone }
  ),
  -- SUPERSCRIPT SHORTCUT
  autosnippet({ trig = '([%w%)%]%}])"([%w])', regTrig = true, wordTrig = false },
    fmta(
      "<>^{<>}",
      {
        f(function(_, snip) return snip.captures[1] end),
        f(function(_, snip) return snip.captures[2] end),
      }
    ),
    { condition = tex.in_mathzone }
  ),
  -- SUBSCRIPT SHORTCUT
  autosnippet({ trig = '([%w%)%]%}]):([%w])', regTrig = true, wordTrig = false },
    fmta(
      "<>_{<>}",
      {
        f(function(_, snip) return snip.captures[1] end),
        f(function(_, snip) return snip.captures[2] end),
      }
    ),
    { condition = tex.in_mathzone }
  ),
  -- EULER'S NUMBER SUPERSCRIPT SHORTCUT
  autosnippet({ trig = '([^%a])ee', regTrig = true, wordTrig = false },
    fmta(
      "<>e^{<>}",
      {
        f(function(_, snip) return snip.captures[1] end),
        d(1, get_visual)
      }
    ),
    { condition = tex.in_mathzone }
  ),
  -- ZERO SUBSCRIPT SHORTCUT
  autosnippet({ trig = '([%a%)%]%}])00', regTrig = true, wordTrig = false },
    fmta(
      "<>_{<>}",
      {
        f(function(_, snip) return snip.captures[1] end),
        t("0")
      }
    ),
    { condition = tex.in_mathzone }
  ),
  -- MINUS ONE SUPERSCRIPT SHORTCUT
  autosnippet({ trig = '([%a%)%]%}])11', regTrig = true, wordTrig = false },
    fmta(
      "<>_{<>}",
      {
        f(function(_, snip) return snip.captures[1] end),
        t("-1")
      }
    ),
    { condition = tex.in_mathzone }
  ),
  -- VECTOR, i.e. \vec
  autosnippet({ trig = "([^%a])vv", wordTrig = false, regTrig = true },
    fmta(
      "<>\\vec{<>}",
      {
        f(function(_, snip) return snip.captures[1] end),
        d(1, get_visual),
      }
    ),
    { condition = tex.in_mathzone }
  ),
  -- FRACTION
  autosnippet({ trig = "([^%a])ff", wordTrig = false, regTrig = true },
    fmta(
      "<>\\frac{<>}{<>}",
      {
        f(function(_, snip) return snip.captures[1] end),
        d(1, get_visual),
        i(2),
      }
    ),
    { condition = tex.in_mathzone }
  ),
  -- ANGLE
  autosnippet({ trig = "([^%a])gg", regTrig = true, wordTrig = false },
    fmta(
      "<>\\ang{<>}",
      {
        f(function(_, snip) return snip.captures[1] end),
        d(1, get_visual),
      }
    ),
    { condition = tex.in_mathzone }
  ),
  -- ABSOLUTE VALUE
  autosnippet({ trig = "([^%a])aa", regTrig = true, wordTrig = false },
    fmta(
      "<>\\abs{<>}",
      {
        f(function(_, snip) return snip.captures[1] end),
        d(1, get_visual),
      }
    ),
    { condition = tex.in_mathzone }
  ),
  -- SQUARE ROOT
  autosnippet({ trig = "([^%\\])sq", wordTrig = false, regTrig = true },
    fmta(
      "<>\\sqrt{<>}",
      {
        f(function(_, snip) return snip.captures[1] end),
        d(1, get_visual),
      }
    ),
    { condition = tex.in_mathzone }
  ),
  -- BINOMIAL SYMBOL
  autosnippet({ trig = "([^%\\])bnn", wordTrig = false, regTrig = true },
    fmta(
      "<>\\binom{<>}{<>}",
      {
        f(function(_, snip) return snip.captures[1] end),
        i(1),
        i(2),
      }
    ),
    { condition = tex.in_mathzone }
  ),
  -- LOGARITHM WITH BASE SUBSCRIPT
  autosnippet({ trig = "([^%a%\\])ll", wordTrig = false, regTrig = true },
    fmta(
      "<>\\log_{<>}",
      {
        f(function(_, snip) return snip.captures[1] end),
        i(1),
      }
    ),
    { condition = tex.in_mathzone }
  ),
  -- DERIVATIVE with denominator only
  autosnippet({ trig = "([^%a])dV", wordTrig = false, regTrig = true },
    fmta(
      "<>\\dvOne{<>}",
      {
        f(function(_, snip) return snip.captures[1] end),
        d(1, get_visual),
      }
    ),
    { condition = tex.in_mathzone }
  ),
  -- DERIVATIVE with numerator and denominator
  autosnippet({ trig = "([^%a])dvv", wordTrig = false, regTrig = true },
    fmta(
      "<>\\dv{<>}{<>}",
      {
        f(function(_, snip) return snip.captures[1] end),
        i(1),
        i(2)
      }
    ),
    { condition = tex.in_mathzone }
  ),
  -- DERIVATIVE with numerator, denominator, and higher-order argument
  autosnippet({ trig = "([^%a])ddv", wordTrig = false, regTrig = true },
    fmta(
      "<>\\dvN{<>}{<>}{<>}",
      {
        f(function(_, snip) return snip.captures[1] end),
        i(1),
        i(2),
        i(3),
      }
    ),
    { condition = tex.in_mathzone }
  ),
  -- PARTIAL DERIVATIVE with denominator only
  autosnippet({ trig = "([^%a])pV", wordTrig = false, regTrig = true },
    fmta(
      "<>\\pdvOne{<>}",
      {
        f(function(_, snip) return snip.captures[1] end),
        d(1, get_visual),
      }
    ),
    { condition = tex.in_mathzone }
  ),
  -- PARTIAL DERIVATIVE with numerator and denominator
  autosnippet({ trig = "([^%a])pvv", wordTrig = false, regTrig = true },
    fmta(
      "<>\\pdv{<>}{<>}",
      {
        f(function(_, snip) return snip.captures[1] end),
        i(1),
        i(2)
      }
    ),
    { condition = tex.in_mathzone }
  ),
  -- PARTIAL DERIVATIVE with numerator, denominator, and higher-order argument
  autosnippet({ trig = "([^%a])ppv", wordTrig = false, regTrig = true },
    fmta(
      "<>\\pdvN{<>}{<>}{<>}",
      {
        f(function(_, snip) return snip.captures[1] end),
        i(1),
        i(2),
        i(3),
      }
    ),
    { condition = tex.in_mathzone }
  ),
  -- SUM with lower limit
  autosnippet({ trig = "([^%a])sM", wordTrig = false, regTrig = true },
    fmta(
      "<>\\sum_{<>}",
      {
        f(function(_, snip) return snip.captures[1] end),
        i(1),
      }
    ),
    { condition = tex.in_mathzone }
  ),
  -- SUM with upper and lower limit
  autosnippet({ trig = "([^%a])smm", wordTrig = false, regTrig = true },
    fmta(
      "<>\\sum_{<>}^{<>}",
      {
        f(function(_, snip) return snip.captures[1] end),
        i(1),
        i(2),
      }
    ),
    { condition = tex.in_mathzone }
  ),
  -- INTEGRAL with upper and lower limit
  autosnippet({ trig = "([^%a])intt", wordTrig = false, regTrig = true },
    fmta(
      "<>\\int_{<>}^{<>}",
      {
        f(function(_, snip) return snip.captures[1] end),
        i(1),
        i(2),
      }
    ),
    { condition = tex.in_mathzone }
  ),
  -- INTEGRAL from positive to negative infinity
  autosnippet({ trig = "([^%a])intf", wordTrig = false, regTrig = true },
    fmta(
      "<>\\int_{\\infty}^{\\infty}",
      {
        f(function(_, snip) return snip.captures[1] end),
      }
    ),
    { condition = tex.in_mathzone }
  ),
  -- BOXED command
  autosnippet({ trig = "([^%a])bb", wordTrig = false, regTrig = true },
    fmta(
      "<>\\boxed{<>}",
      {
        f(function(_, snip) return snip.captures[1] end),
        d(1, get_visual)
      }
    ),
    { condition = tex.in_mathzone }
  ),
  -- TEXT command
  autosnippet({ trig = "([^%a])tt", wordTrig = false, regTrig = true },
    fmta(
      "<>\\text{<>}",
      {
        f(function(_, snip) return snip.captures[1] end),
        d(1, get_visual)
      }
    ),
    { condition = tex.in_mathzone }
  ),
}

local symbol_specs = {
  -- operators
  ["!="] = { context = { name = "!=" }, command = [[\neq]] },
  ["<="] = { context = { name = "≤" }, command = [[\leq]] },
  [">="] = { context = { name = "≥" }, command = [[\geq]] },
  ["<<"] = { context = { name = "<<" }, command = [[\ll]] },
  [">>"] = { context = { name = ">>" }, command = [[\gg]] },
  ["~~"] = { context = { name = "~" }, command = [[\sim]] },
  ["~="] = { context = { name = "≈" }, command = [[\approx]] },
  ["~-"] = { context = { name = "≃" }, command = [[\simeq]] },
  ["-~"] = { context = { name = "⋍" }, command = [[\backsimeq]] },
  ["-="] = { context = { name = "≡" }, command = [[\equiv]] },
  ["=~"] = { context = { name = "≅" }, command = [[\cong]] },
  [":="] = { context = { name = "≔" }, command = [[\coloneq]] },
  ["**"] = { context = { name = "·", priority = 100 }, command = [[\cdot]] },
  ["xx"] = { context = { name = "×" }, command = [[\times]] },
  ["!+"] = { context = { name = "⊕" }, command = [[\oplus]] },
  ["!*"] = { context = { name = "⊗" }, command = [[\otimes]] },
  ["||"] = { context = { name = "∥", }, command = [[\parallel]] },
  -- sets
  ["NN"] = { context = { name = "ℕ" }, command = [[\mathbb{N}]] },
  ["ZZ"] = { context = { name = "ℤ" }, command = [[\mathbb{Z}]] },
  ["QQ"] = { context = { name = "ℚ" }, command = [[\mathbb{Q}]] },
  ["RR"] = { context = { name = "ℝ" }, command = [[\mathbb{R}]] },
  ["CC"] = { context = { name = "ℂ" }, command = [[\mathbb{C}]] },
  ["OO"] = { context = { name = "∅" }, command = [[\emptyset]] },
  ["pwr"] = { context = { name = "P" }, command = [[\powerset]] },
  ["cc"] = { context = { name = "⊂" }, command = [[\subset]] },
  ["cq"] = { context = { name = "⊆" }, command = [[\subseteq]] },
  ["qq"] = { context = { name = "⊃" }, command = [[\supset]] },
  ["qc"] = { context = { name = "⊇" }, command = [[\supseteq]] },
  ["\\\\\\"] = { context = { name = "⧵" }, command = [[\setminus]] },
  ["Nn"] = { context = { name = "∩" }, command = [[\cap]] },
  ["UU"] = { context = { name = "∪" }, command = [[\cup]] },
  ["::"] = { context = { name = ":" }, command = [[\colon]] },
  -- quantifiers and logic stuffs
  ["AA"] = { context = { name = "∀" }, command = [[\forall]] },
  ["EE"] = { context = { name = "∃" }, command = [[\exists]] },
  ["inn"] = { context = { name = "∈" }, command = [[\in]] },
  ["notin"] = { context = { name = "∉" }, command = [[\not\in]] },
  ["!-"] = { context = { name = "¬" }, command = [[\lnot]] },
  ["VV"] = { context = { name = "∨" }, command = [[\lor]] },
  ["WW"] = { context = { name = "∧" }, command = [[\land]] },
  ["!W"] = { context = { name = "∧" }, command = [[\bigwedge]] },
  ["=>"] = { context = { name = "⇒" }, command = [[\implies]] },
  ["=<"] = { context = { name = "⇐" }, command = [[\impliedby]] },
  ["iff"] = { context = { name = "⟺" }, command = [[\iff]] },
  ["->"] = { context = { name = "→", priority = 250 }, command = [[\to]] },
  ["!>"] = { context = { name = "↦" }, command = [[\mapsto]] },
  ["<-"] = { context = { name = "↦", priority = 250 }, command = [[\gets]] },
  -- differentials
  ["dp"] = { context = { name = "∂" }, command = [[\partial]] },
  -- arrows
  ["-->"] = { context = { name = "⟶", priority = 500 }, command = [[\longrightarrow]] },
  ["<->"] = { context = { name = "↔", priority = 500 }, command = [[\leftrightarrow]] },
  ["2>"] = { context = { name = "⇉", priority = 400 }, command = [[\rightrightarrows]] },
  ["upar"] = { context = { name = "↑" }, command = [[\uparrow]] },
  ["dnar"] = { context = { name = "↓" }, command = [[\downarrow]] },
  -- etc
  ["ooo"] = { context = { name = "∞" }, command = [[\infty]] },
  ["lll"] = { context = { name = "ℓ" }, command = [[\ell]] },
  ["dag"] = { context = { name = "†" }, command = [[\dagger]] },
  ["+-"] = { context = { name = "†" }, command = [[\pm]] },
  ["-+"] = { context = { name = "†" }, command = [[\mp]] },
  ["cdd"] = { context = { name = "···" }, command = [[\cdots]] },
  ["ldd"] = { context = { name = "···" }, command = [[\ldots]] },
  ["..."] = { context = { name = "..." }, command = [[\dots]] },
  ["in1"] = { context = { name = "∫", }, command = [[\int]] },
  ["in2"] = { context = { name = "∬", }, command = [[\iint]] },
  ["in3"] = { context = { name = "∭", }, command = [[\iiint]] },
  ["oi1"] = { context = { name = "∮", }, command = [[\oint]] },
  ["oi2"] = { context = { name = "∯", }, command = [[\oiint]] },
}

local symbol_snippets = {}
for k, v in pairs(symbol_specs) do
  table.insert(
    symbol_snippets,
    symbol_snippet(vim.tbl_deep_extend("keep", { trig = k }, v.context), v.command, { condition = tex.in_math })
  )
end
vim.list_extend(M, symbol_snippets)

return M
