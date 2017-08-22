(TeX-add-style-hook
 "thesis1"
 (lambda ()
   (add-to-list 'LaTeX-verbatim-environments-local "minted")
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
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperref")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (TeX-run-style-hooks
    "latex2e"
    "swfcthesis"
    "swfcthesis10")
   (LaTeX-add-labels
    "fig:hello"
    "tab:hello"
    "lst:hello")
   (LaTeX-add-bibliographies
    "thesis"))
 :latex)

