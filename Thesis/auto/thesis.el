(TeX-add-style-hook
 "thesis"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("inputenc" "utf8")))
   (add-to-list 'LaTeX-verbatim-environments-local "lstlisting")
   (add-to-list 'LaTeX-verbatim-environments-local "pythoncode*")
   (add-to-list 'LaTeX-verbatim-environments-local "pythoncode")
   (add-to-list 'LaTeX-verbatim-environments-local "nasmcode*")
   (add-to-list 'LaTeX-verbatim-environments-local "nasmcode")
   (add-to-list 'LaTeX-verbatim-environments-local "gascode*")
   (add-to-list 'LaTeX-verbatim-environments-local "gascode")
   (add-to-list 'LaTeX-verbatim-environments-local "latexcode*")
   (add-to-list 'LaTeX-verbatim-environments-local "latexcode")
   (add-to-list 'LaTeX-verbatim-environments-local "ccode*")
   (add-to-list 'LaTeX-verbatim-environments-local "ccode")
   (add-to-list 'LaTeX-verbatim-environments-local "minted")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "lstinline")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperref")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "lstinline")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (TeX-run-style-hooks
    "latex2e"
    "swfcthesis"
    "swfcthesis10"
    "xcolor"
    "hyperref"
    "inputenc"
    "listings"
    "verbatim")
   (LaTeX-add-labels
    "sec:devel-envir"
    "sec:tools"
    "sec:install"
    "tab:hello"
    "sec:chose-disk"
    "sec:struct-floppy-disk"
    "fig:flpy1.png"
    "sec:source-codes-comm")
   (LaTeX-add-bibliographies))
 :latex)

