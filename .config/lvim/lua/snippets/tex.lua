-- ----------------------------------------------------------------------------
-- See https://www.egmastnak.com/tutorials/vim-latex/luasnip.html#tldr-hello-world-example
-- Summary: If `SELECT_RAW` is populated with a visual selection, the function
-- returns an insert node whose initial text is set to the visual selection.
-- If `SELECT_RAW` is empty, the function simply returns an empty insert node.
local get_visual = function(args, parent)
  if (#parent.snippet.env.SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
  else -- If SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end
-- ----------------------------------------------------------------------------

-- Some LaTeX-specific conditional expansion functions (requires VimTeX)

local tex_utils = {}
tex_utils.in_mathzone = function()
  --[[ return vim.fn['vimtex#syntax#in_mathzone']() == 1 ]]
  return vim.api.nvim_eval('vimtex#syntax#in_mathzone()') == 1
end

tex_utils.in_env = function(name)
  local is_inside = vim.fn['vimtex#env#is_inside'](name)
  return (is_inside[1] > 0 and is_inside[2] > 0)
end

tex_utils.in_tikz = function()
  return tex_utils.in_env("tikzpicture")
end

tex_utils.in_itemize = function()
  return tex_utils.in_env("itemize")
end

-- ----------------------------------------------------------------------------
return {
  -- Pure Lua snippets
  -- inline Math shortcuts

  s({ trig = "$", wordTrig = true, snippetType = 'autosnippet', dscr = 'Inline Math' },
    fmta(
      "$ <> $<>",
      {
        i(1),
        i(0)
      }
    ),
    { condition = tex_utils.in_mathzone, show_condition = tex_utils.in_mathzone }
  ),
  s({ trig = "ip", wordTrig = true, snippetType = 'autosnippet', dscr = 'Inner product' },
    fmta(
      "\\langle <>, <> \\rangle <>",
      {
        i(1),
        i(2),
        i(0)
      }
    ),
    { condition = tex_utils.in_mathzone, show_condition = tex_utils.in_mathzone }
  ),

  s({ trig = "//", wordTrig = true, snippetType = 'autosnippet', dscr = '\frac{}{}' },
    fmta(
      "\\frac{<>}{<>} <>",
      {
        i(1),
        i(2),
        i(0)
      }
    ),
    { condition = tex_utils.in_mathzone, show_condition = tex_utils.in_mathzone }
  ),

  s({ trig = "^", wordTrig = false, snippetType = 'autosnippet', dscr = 'superscript box' },
    fmta(
      "^{<>}<>",
      {
        i(1),
        i(0)
      }
    ),
    { condition = tex_utils.in_mathzone, show_condition = tex_utils.in_mathzone }
  ),

  s({ trig = "_", wordTrig = false, snippetType = 'autosnippet', dscr = 'subscript box' },
    fmta(
      "_{<>}<>",
      {
        i(1),
        i(0)
      }
    ),
    { condition = tex_utils.in_mathzone, show_condition = tex_utils.in_mathzone }
  ),
  s({ trig = "defi", wordTrig = true, snippetType = 'autosnippet', dscr = 'definition_' },
    fmta(
      "\\coloneqq <>",
      {
        i(0),
      }
    ),
    { condition = tex_utils.in_mathzone, show_condition = tex_utils.in_mathzone }
  ),

  s({ trig = "mbr", wordTrig = true, snippetType = 'autosnippet', dscr = '\\mathbf{R}{$1}' },
    fmta(
      "\\mathbb{R}^{<>} <>",
      {
        i(1),
        i(0)
      }
    ),
    { condition = tex_utils.in_mathzone, show_condition = tex_utils.in_mathzone }
  ),

  s({ trig = "mbb", wordTrig = true, snippetType = 'autosnippet', dscr = '\\mathbb{$1}$0 ' },
    fmta(
      "\\mathbb{<>}<>",
      {
        i(1),
        i(0)
      }
    ),
    { condition = tex_utils.in_mathzone, show_condition = tex_utils.in_mathzone }
  ),

  s({ trig = "mcal", wordTrig = true, snippetType = 'autosnippet', dscr = '\\mathcal{$1}$0 ' },
    fmta(
      "\\mathcal{<>}<>",
      {
        i(1),
        i(0)
      }
    ),
    { condition = tex_utils.in_mathzone, show_condition = tex_utils.in_mathzone }
  ),
  s({ trig = "grad", wordTrig = true, snippetType = 'autosnippet', dscr = 'gradient' },
    fmta(
      "\\grad <>",
      {
        i(0)
      }
    ),
    { condition = tex_utils.in_mathzone, show_condition = tex_utils.in_mathzone }
  ),
  s({ trig = "div", wordTrig = true, snippetType = 'autosnippet', dscr = 'Divergence' },
    fmta(
      "\\div <>",
      {
        i(0)
      }
    ),
    { condition = tex_utils.in_mathzone, show_condition = tex_utils.in_mathzone }
  ),

  s({ trig = "xdiv", wordTrig = true, snippetType = 'autosnippet', dscr = 'xDivergence' },
    fmta(
      "\\xdiv <>",
      {
        i(0)
      }
    ),
    { condition = tex_utils.in_mathzone, show_condition = tex_utils.in_mathzone }
  ),
  s({ trig = "ydiv", wordTrig = true, snippetType = 'autosnippet', dscr = 'yDivergence' },
    fmta(
      "\\ydiv <>",
      {
        i(0)
      }
    ),
    { condition = tex_utils.in_mathzone, show_condition = tex_utils.in_mathzone }
  ),
  s({ trig = "lap", wordTrig = true, snippetType = 'autosnippet', dscr = 'Laplacian' },
    fmta(
      "\\Lap <>",
      {
        i(0)
      }
    ),
    { condition = tex_utils.in_mathzone, show_condition = tex_utils.in_mathzone }
  ),

  s({ trig = "...", wordTrig = true, snippetType = 'autosnippet', dscr = 'ldots' },
    fmta(
      "\\ldots <>",
      {
        i(0)
      }
    ),
    { condition = tex_utils.in_mathzone, show_condition = tex_utils.in_mathzone }
  ),
  s({ trig = "**", wordTrig = true, snippetType = 'autosnippet', dscr = 'ldots' },
    fmta(
      "\\cdot <>",
      {
        i(0)
      }
    ),
    { condition = tex_utils.in_mathzone, show_condition = tex_utils.in_mathzone }
  ),

  s({ trig = "norm", wordTrig = true, snippetType = 'autosnippet', dscr = 'norm' },
    fmta(
      [[\norm{<>}_{<>}<>]],
      {
        i(1),
        i(2),
        i(0)
      }
    ),
    { condition = tex_utils.in_mathzone, show_condition = tex_utils.in_mathzone }
  ),

  s({ trig = "abs", wordTrig = true, snippetType = 'autosnippet', dscr = 'abs' },
    fmta(
      [[\abs{<>}^{<>} <>]],
      {
        i(1),
        i(2),
        i(0)
      }
    ),
    { condition = tex_utils.in_mathzone, show_condition = tex_utils.in_mathzone }
  ),
  s({ trig = "log", wordTrig = true, snippetType = 'autosnippet', dscr = 'abs' },
    fmta(
      [[\log(<>)<>]],
      {
        i(1),
        i(0)
      }
    ),
    { condition = tex_utils.in_mathzone, show_condition = tex_utils.in_mathzone }
  ),
  s({ trig = "indicator", wordTrig = true, snippetType = 'autosnippet', dscr = 'indicator function' },
    fmta(
      [[\indicator{<>} <>]],
      {
        i(1),
        i(0)
      }
    ),
    { condition = tex_utils.in_mathzone, show_condition = tex_utils.in_mathzone }
  ),

  s({ trig = "ll1", wordTrig = false, snippetType = 'autosnippet', dscr = 'll1' },
    fmta(
      [[\left( <> \right) <>]],
      {
        i(1),
        i(0)
      }
    ),
    { condition = tex_utils.in_mathzone, show_condition = tex_utils.in_mathzone }
  ),
  s({ trig = "ll2", wordTrig = false, snippetType = 'autosnippet', dscr = 'll2' },
    fmta(
      [[\left\{ <> \right\} <>]],
      {
        i(1),
        i(0)
      }
    ),
    { condition = tex_utils.in_mathzone, show_condition = tex_utils.in_mathzone }
  ),
  s({ trig = "ll3", wordTrig = false, snippetType = 'autosnippet', dscr = 'll3' },
    fmta(
      [[\left[ <> \right] <>]],
      {
        i(1),
        i(0)
      }
    ),
    { condition = tex_utils.in_mathzone, show_condition = tex_utils.in_mathzone }
  ),
  s({ trig = "sum", wordTrig = true, snippetType = 'autosnippet', dscr = 'sum' },
    fmta(
      [[\sum_{<>}^{<>} <>]],
      {
        i(1),
        i(2),
        i(0)
      }
    ),
    { condition = tex_utils.in_mathzone, show_condition = tex_utils.in_mathzone }
  ),
  s({ trig = "int", wordTrig = true, snippetType = 'autosnippet', dscr = 'int' },
    fmta(
      [[\int_{<>}^{<>} <> \dx{<>}<>]],
      {
        i(1),
        i(2),
        i(3),
        i(4),
        i(0)
      }
    ),
    { condition = tex_utils.in_mathzone, show_condition = tex_utils.in_mathzone }
  ),
  s({ trig = "lim", wordTrig = true, snippetType = 'autosnippet', dscr = 'lim' },
    fmta(
      [[\lim_{<>}^{<>} <>]],
      {
        i(1),
        i(2),
        i(0)
      }
    ),
    { condition = tex_utils.in_mathzone, show_condition = tex_utils.in_mathzone }
  ),
  s({ trig = "inf", wordTrig = true, snippetType = 'autosnippet', dscr = 'infinity' },
    fmta(
      [[\infty<>]],
      {
        i(0)
      }
    ),
    { condition = tex_utils.in_mathzone, show_condition = tex_utils.in_mathzone }
  ),
  --[[ \dfrac{\mathup{d}{#1}}{\mathup{dt}} ]]
  --
  parse({ trig = "partial_derivative", wordTrig = true, dscr = 'partial derivative' },
    [[\frac{\partial ${1:f(x)}}{\partial ${2:x}} $0]]),

  s({ trig = "hr", dscr = "The hyperref package's href{}{} command (for url links)" },
    fmta(
      [[\href{<>}{<>}]],
      {
        i(1, "url"),
        i(2, "display name"),
      }
    )
  ),
  s({ trig = "blabel", wordTrig = true, snippetType = 'autosnippet', dscr = "label" },
    fmta(
      [[\label{<>:<>} <>]],
      {
        i(1),
        i(2),
        i(0)
      }
    )
  ),


  s({ trig = "emph", dscr = "\\emph{$VISUAL}" },
    fmta("\\emph{<>}",
      {
        d(1, get_visual),
      }
    )
  ),

  s({ trig = "textbf", dscr = "\\textbf{$VISUAL}" },
    fmta("\\textbf{<>}",
      {
        d(1, get_visual),
      }
    )
  ),

  s({ trig = "textit", dscr = "\\textit{$VISUAL}" },
    fmta("\\textit{<>}",
      {
        d(1, get_visual),
      }
    )
  ),

  s({ trig = "bm", dscr = "bold math \\bm{$VISUAL}" },
    fmta("\\bm{<>}",
      {
        d(1, get_visual),
      }
    )
  ),

  --[[ \newcommand{\intO}[1]{\int_{\R^d} #1 \dx{x}} ]]
  --[[ \newcommand{\iintO}[1]{\int_{\R^{2d}} #1 \dx{x} \dx{y}} ]]
  --[[ \newcommand{\intTO}[1]{\int_0^T\!\! \int_{\R^d} #1 \dx{x}\dx{t}} ]]
  --[[ \newcommand{\iintTO}[1]{\int_0^T\!\!  \int_{\R^{2d}} #1 \dx{x}\dx{t}} ]]
  --[[ \newcommand{\m}[1]{\mathup{m}({#1})} ]]
  --[[ \newcommand{\dx}[1]{\mathop{}\!\mathup{d} \mathup{#1}} ]]
  --[[ \newcommand{\ddt}[1]{\dfrac{\mathup{d}{#1}}{\mathup{dt}}} ]]
  --[[ \renewcommand{\t}{\expandafter\mathrel\expandafter\text} ]]
  --[[ \newcommand{\dt}{\mathup{dt}} ]]
  --[[ \newcommand{\Dt}{\ddt} ]]
  --[[ \newcommand{\partialp}[1]{\frac{\partial #1}{\partial p}} ]]

  --[[ \newcommand{\stlim}[1]{\xrightarrow[#1]{}} ]]
  --[[ \newcommand{\wklim}[1]{\xrightharpoonup[#1]{}} ]]
  --[[ \newcommand{\partialt}[1]{\dfrac{\partial#1}{\partial t}} ]]
  --[[ \newcommand{\partialx}[1]{\dfrac{\partial#1}{\partial x}} ]]
  --[[ \newcommand{\partialxx}[1]{\dfrac{\partial^2 #1}{\partial x^2}} ]]
  --[[ \newcommand{\fpartial}[1]{\dfrac{\partial}{\partial #1}} ]]

  -- Environments
  s({ trig = "bb", wordTrig = true, snippetType = 'autosnippet', dscr = 'begin end environment' },
    fmta(
      [[
       \begin{<>}
           <>
       \end{<>}
       <>
     ]],
      { i(1), i(2), rep(1), i(0)
      }
    )
  ),
  s({ trig = "hh", wordTrig = true, snippetType = 'autosnippet', dscr = 'equation aligned env' },
    fmta(
      [[
      \begin{equation*}
       \begin{aligned}
           <>
       \end{aligned}
      \end{equation*}
       <>
     ]],
      { i(1), i(0)
      }
    )
  ),
  s({ trig = "kk", wordTrig = true, snippetType = 'autosnippet', dscr = 'begin end environment' },
    fmta(
      [[
      \begin{align*}
           <>
      \end{align*}
       <>
     ]],
      { i(1), i(0)
      }
    )
  ),

  s({ trig = "ff", wordTrig = true, snippetType = 'autosnippet', dscr = 'begin end environment' },
    fmta(
      [[
      \begin{equation*}
           <>
      \end{equation*}
       <>
     ]],
      { i(1), i(0)
      }
    )
  ),
  s({ trig = "blemma", wordTrig = true, snippetType = 'autosnippet', dscr = 'begin end environment' },
    fmta(
      [[
       \begin{lemma}[<>]\label{lem:<>}
           <>
       \end{lemma}
       <>
     ]],
      { i(1), rep(1), i(2), i(0)
      }
    )
  ),
  s({ trig = "bprop", wordTrig = true, snippetType = 'autosnippet', dscr = 'begin end environment' },
    fmta(
      [[
       \begin{proposition}[<>]\label{prop:<>}
           <>
       \end{proposition}
}
       <>
     ]],
      { i(1), rep(1), i(2), i(0)
      }
    )
  ),
  parse({ trig = "bitemize", wordTrig = true, dscr = 'begin itemize' },
    "\\begin{itemize} \n \\item $1 \n \\end{itemize}"),

  s({ trig = "it", wordTrig = true, snippetType = 'autosnippet', dscr = '\\item' },
    fmta(
      "\\item <>",
      { i(0), }
    ),
    { condition = tex_utils.in_itemize, show_condition = tex_utils.in_itemize }
  ),

  parse({ trig = "section", wordTrig = true, dscr = 'section' },
    "\\section{${1:NAME}} \n \\label{sec:$1}"),

  parse({ trig = "subsection", wordTrig = true, dscr = 'subsection' },
    "\\subsection{${1:NAME}} \n \\label{sec:$1}"),

  parse({ trig = "subsubsection", wordTrig = true, dscr = 'subsubsection' },
    "\\subsubsection{${1:NAME}} \n \\label{sec:$1}"),

  parse({ trig = "paragraph", wordTrig = true, dscr = 'paragraph' },
    "\\paragraph{${1:NAME}} \n $1"),



  parse({ trig = "baligned", wordTrig = true, dscr = 'begin aligned' },
    "\\begin{aligned} \n \t${1:$SELECT_DEDENT} \n \\end{aligned}"),

  parse({ trig = "bframe", wordTrig = true, dscr = 'begin frame' },
    "% Begin FRAME %%%%%%%%%%%%%%%%%%%%%%%%%%%%%% \n \
    \\begin{frame} \n \\frametitle{$1} \n $2 \n \\end{frame}"),

  parse({ trig = "benumerate", wordTrig = true, dscr = 'begin enumerate' },
    " \\begin{enumerate} \n \
      \\item  ${1} \n \
      \\end{enumerate}"),

  parse({ trig = "bmatrix", wordTrig = true, dscr = 'begin matrix' },
    " \\begin{bmatrix} \n \
        $1 & $2 \\\\ \
        $3 & $4 \
      \\end{bmatrix}"),

  parse({ trig = "float_img", wordTrig = true, dscr = 'tikz float_img' },
    " \\tikz[remember picture, overlay] \\node[anchor=center] \
      (img) at ($(current page.center)+(0,0)$) \
      {\\includegraphics[width=3.5cm]{$1}}; \n \
      \\tikz[remember picture, overlay] \\node (caption)\
      [below of=img, yshift=-0.6cm, xshift=0cm] {$0}; "),

  parse({ trig = "bfigure", wordTrig = true, dscr = 'begin figure' },
    " \\begin{figure}[${1:htpb}] \
        \\centering \
        ${2:\\includegraphics[width=0.8\\textwidth]{$3}} \
        \\caption{${4:${3}}} \
        \\label{fig:${5:${3}}} \
      \\end{figure} "),

  parse({ trig = "bsubfigure", wordTrig = true, dscr = 'begin subfigure' },
    " \\begin{figure}[${1:htpb}] \
         \\centering \
         \\begin{subfigure}[b]{0.3\\textwidth} \
             \\centering \
             \\includegraphics[width=\\textwidth]{${2:fig1}} \
             \\caption{${3:$2}} \
             \\label{fig:${4:$2}} \
         \\end{subfigure} \
         \\hfill \
         \\begin{subfigure}[b]{0.3\\textwidth} \
             \\centering \
             \\includegraphics[width=\\textwidth]{${5:fig2}} \
             \\caption{${6:$5}} \
             \\label{fig:${7:$5}} \
         \\end{subfigure} \
         \\hfill \
         \\begin{subfigure}[b]{0.3\\textwidth} \
             \\centering \
             \\includegraphics[width=\\textwidth]{${8:fig3}} \
             \\caption{${9:$8}} \
             \\label{fig:${10:$8}} \
         \\end{subfigure} \
            \\caption{${11:Three simple graphs}} \
            \\label{fig:${12:three graphs}} \
    \\end{figure} "),


  -- Some Templates ------------------------------------------
  parse({ trig = "template_standalone", wordTrig = true, dscr = 'standalone figure' },
    " \
    \\documentclass[varwidth, border=0cm]{standalone} \
\
    \\usepackage[export]{adjustbox} \
    \\usepackage{graphicx} \
    \\usepackage{array} \
    \\usepackage{tabu} \
    \\usepackage{multirow} \
    \\usepackage{multicol} \
    \\usepackage{makecell} \
 \
    \\newcommand{\\tabfigure}[2]{\\raisebox{-.5\\height}{\\includegraphics[#1]{#2}}} \
 \
    \\begin{document} \
 \
    \\begin{figure} \
    \\centering \
    \\setlength\tabcolsep{0pt} \
    \\def\\arraystretch{0.0} %  1 is the default, change whatever you need \
    \\begin{tabu}{c} \
      \\tabfigure{height=1cm, width=1cm}{$0} \
    \\end{tabu} \
    \\end{figure} \
    \\end{document} "),
  s({ trig = "template_letter", wordTrig = true, dscr = 'basic letter' },
    fmta([[
    \documentclass[a4paper, 11pt]{letter}
    \usepackage[colorlinks = true,
      linkcolor = blue,
      urlcolor  = blue,
      citecolor = blue,
      anchorcolor = blue]{hyperref}
    \usepackage{geometry}
    \geometry{
      a4paper,
      % total={170mm,257mm},
      left=1in,
      right=1in,
      top=1in,
      bottom=1in,}
\usepackage{pdfpages}

% font
\usepackage{lmodern}
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}

% Name of sender
\name{<>}

% Signature of sender
\signature{NAME}

% Address of sender
\address
{
  line 1 \\
  line 2 \\
}
\date{\today}


\begin{document}

\begin{letter}
  {
    To: \\
    The xyz \\
    line 1 \\
    line 2 \\
  }

  % Opening statement
  \opening{
  \textbf{Subject: something}\\[0.5cm]
  Dear Consular Officer,}

  % Letter body

  something ...

  Yours sincerely,\\

  xyz

  % \closing{Yours truly,}

\end{letter}
\end{document}
      ]], {
      i(0, "NAME"),
    })),

}
