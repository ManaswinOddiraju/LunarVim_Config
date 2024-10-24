return {
  s("default_header", {
    t({
      "\\documentclass{article}",
      "\\usepackage[utf8]{inputenc}",
      "\\usepackage{amsmath}",
      "\\usepackage{amsfonts}",
      "\\usepackage{amssymb}",
      "\\usepackage{graphicx}",
      "\\usepackage[letterpaper,margin=1in]{geometry}",
      "\\title{"
    }),
    i(1, "Title"),             -- Placeholder for the document title
    t({ "}", "\\author{" }),
    i(2, "Manaswin Oddiraju"), -- Placeholder for the author name
    t({ "}", "\\date{" }),
    i(3, "\\today }"),         -- Placeholder for the date, defaulting to \today
    t({ "", "", "\\begin{document}", "", "\\maketitle", "", "", "\\end{document}" }),
    i(0)                       -- Final position for the cursor after the snippet is expanded
  }),

  s("ppt_header", {

    t({
      "\\documentclass [xcolor=svgnames, t] {beamer}",
      "\\usepackage[utf8]{inputenc}",
      "\\usepackage{booktabs, comment}",
      "\\usepackage[absolute, overlay]{textpos}",
      "\\usepackage{pgfpages}",
      "\\usepackage[font=footnotesize]{caption}",
      "\\useoutertheme{infolines}",
      "\\usepackage[backend=biber]{biblatex}",
      "\\AtEveryCitekey{\\iffootnote{\\color{red}\\scriptsize}{\\color{blue}}}",
      "\\definecolor{gold}{RGB}{254, 206, 0}",
      "\\setbeamercolor{title in head/foot}{bg=blue, fg=blue}",
      "\\setbeamercolor{author in head/foot}{bg=myuniversity}",
      "\\setbeamertemplate{page number in head/foot}{}",
      "\\usepackage{csquotes}",
      "\\usepackage{amsmath}",
      "\\usepackage[makeroom]{cancel}",
      "\\usepackage{subcaption}",
      "\\usepackage{textpos}",
      "\\usepackage{tikz}",
      "\\usetheme{Madrid}",
      "\\definecolor{myuniversity}{RGB}{0, 85, 150}",
      "\\usecolortheme[named=myuniversity]{structure}",
      "\\usepackage{tikz}",
      "\\title[RUNNING TITLE]{Presentation}",
      "\\author{"
    }),
    i(2, "Manaswin Oddiraju"), -- Placeholder for the author name
    t({ "}", "\\date{" }),
    i(3, "\\today }"),         -- Placeholder for the date, defaulting to \today
    t({
      "",
      "\\addtobeamertemplate{navigation symbols}{\\includegraphics[width=0.15\\linewidth]{Figures/Adams_logo2}\\hspace{0.47\\linewidth} }",
      "{",
      "\\usebeamerfont{footline}%",
      "\\usebeamercolor[fg]{footline}%",
      "\\hspace{1em}%",
      "\\insertframenumber/\\inserttotalframenumber",
      "}",
      "\\begin{document}",
      "\\begin{frame}",
      "\\maketitle",
      "\\end{frame}",
      "\\begin{frame}{",
    }),
    i(0), -- Final position for the cursor after the snippet is expanded
    t({
      "}",
      "\\end{frame}",
      "\\end{document}"
    }),
  })
}
