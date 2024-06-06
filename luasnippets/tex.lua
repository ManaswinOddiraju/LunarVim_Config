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
    i(1, "Title"),       -- Placeholder for the document title
    t({ "}", "\\author{" }),
    i(2, "Manaswin Oddiraju"), -- Placeholder for the author name
    t({ "}", "\\date{" }),
    i(3, "\\today }"),     -- Placeholder for the date, defaulting to \today
    t({ "", "", "\\begin{document}", "", "\\maketitle", "", "" , "\\end{document}"}),
    i(0)                 -- Final position for the cursor after the snippet is expanded
  })
}
