local get_visual = function(args, parent)
  if (#parent.snippet.env.SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
  else
    return sn(nil, i(1, ''))
  end
end

-- Math context detection
local tex = {}
tex.in_mathzone = function() return vim.fn['vimtex#syntax#in_mathzone']() == 1 end
tex.in_text = function() return not tex.in_mathzone() end

-- Return snippet tables
return
{
  -- GENERIC ENVIRONMENT
  s({trig="^([%s]*)new", regTrig = true, snippetType="autosnippet"},
    fmta(
      [[
        <>\begin{<>}
        <>    <>
        <>\end{<>}<>
      ]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        i(1, ""),
        f( function(_, snip) return snip.captures[1] end ),
        d(2, get_visual),
        f( function(_, snip) return snip.captures[1] end ),
        rep(1),
        i(0),
      }
    )
  ),
  -- TCBTHEOREM ENVIRONMENT with two environment extra arguments
  s({trig="^([%s]*)n3", regTrig = true, snippetType="autosnippet"},
    fmta(
      [[
        <>\begin{<>}{<>}{<>}
        <>    <>
        <>\end{<>}<>
      ]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        i(1, ""),
        i(2, ""),
        i(3, ""),
        f( function(_, snip) return snip.captures[1] end ),
        d(4, get_visual),
        f( function(_, snip) return snip.captures[1] end ),
        rep(1),
        i(0),
      }
    )
  ),
  -- TOPIC ENVIRONMENT (my custom tcbtheorem environment)
  s({trig="^([%s]*)nt", regTrig = true, snippetType="autosnippet"},
    fmta(
      [[
        <>\begin{topic}{<>}{<>}
        <>    <>
        <>\end{topic}<>
      ]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        i(1, ""),
        i(2, ""),
        f( function(_, snip) return snip.captures[1] end ),
        d(3, get_visual),
        f( function(_, snip) return snip.captures[1] end ),
        i(0),
      }
    )
  ),
  -- EQUATION
  s({trig="^([%s]*)nn", regTrig = true, snippetType="autosnippet"},
    fmta(
      [[
        <>\begin{equation*}
        <>    <>
        <>\end{equation*}<>
      ]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        f( function(_, snip) return snip.captures[1] end ),
        i(1, ""),
        f( function(_, snip) return snip.captures[1] end ),
        i(0),
      }
    )
  ),
  -- SPLIT EQUATION
  s({trig="^([%s]*)ns", regTrig = true, snippetType="autosnippet"},
    fmta(
      [[
        <>\begin{equation*}
        <>    \begin{split}
        <>        <>
        <>    \end{split}
        <>\end{equation*}<>
      ]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        f( function(_, snip) return snip.captures[1] end ),
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual),
        f( function(_, snip) return snip.captures[1] end ),
        f( function(_, snip) return snip.captures[1] end ),
        i(0),
      }
    )
  ),
  -- ALIGN
  s({trig="^([%s]*)all", regTrig = true, snippetType="autosnippet"},
    fmta(
      [[
        <>\begin{align*}
        <>    <>
        <>\end{align*}<>
      ]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        f( function(_, snip) return snip.captures[1] end ),
        i(1, ""),
        f( function(_, snip) return snip.captures[1] end ),
        i(0),
      }
    )
  ),
  -- ITEMIZE
  s({trig="^([%s]*)itt", regTrig = true, snippetType="autosnippet"},
    fmta(
      [[
        <>\begin{itemize}

        <>    \item <>

        <>\end{itemize}
      ]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        f( function(_, snip) return snip.captures[1] end ),
        i(0, ""),
        f( function(_, snip) return snip.captures[1] end ),
      }
    )
  ),
  -- ENUMERATE
  s({trig="^([%s]*)enn", regTrig = true, snippetType="autosnippet"},
    fmta(
      [[
        <>\begin{enumerate}

        <>    \item <>

        <>\end{enumerate}
      ]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        f( function(_, snip) return snip.captures[1] end ),
        i(0, ""),
        f( function(_, snip) return snip.captures[1] end ),
      }
    )
  ),
  -- INLINE MATH
  s({trig = "([^%l])mm", regTrig = true, wordTrig = false, snippetType="autosnippet"},
    fmta(
      "<>$<>$",
      {
        f( function(_, snip) return snip.captures[1] end ),
        i(1, ""),
    })),
  -- INLINE MATH ON NEW LINE
  s({trig = "^mm", regTrig = true, wordTrig = false, snippetType="autosnippet"},
    fmta(
      "$<>$",
      {
        i(1, ""),
    })),
}