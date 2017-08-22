(TeX-add-style-hook
 "swfcthesis"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("book" "a4paper" "12pt" "oneside")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("graphicx" "xetex") ("footmisc" "bottom") ("libertine" "tt=false") ("xeCJK" "CJKmath=true" "AutoFakeSlant=true") ("setspace" "doublespacing")))
   (add-to-list 'LaTeX-verbatim-environments-local "minted")
   (add-to-list 'LaTeX-verbatim-environments-local "ccode")
   (add-to-list 'LaTeX-verbatim-environments-local "ccode*")
   (add-to-list 'LaTeX-verbatim-environments-local "latexcode")
   (add-to-list 'LaTeX-verbatim-environments-local "latexcode*")
   (add-to-list 'LaTeX-verbatim-environments-local "gascode")
   (add-to-list 'LaTeX-verbatim-environments-local "gascode*")
   (add-to-list 'LaTeX-verbatim-environments-local "nasmcode")
   (add-to-list 'LaTeX-verbatim-environments-local "nasmcode*")
   (add-to-list 'LaTeX-verbatim-environments-local "pythoncode")
   (add-to-list 'LaTeX-verbatim-environments-local "pythoncode*")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperref")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (TeX-run-style-hooks
    "latex2e"
    "book"
    "bk12"
    "ifxetex"
    "indentfirst"
    "tabu"
    "longtable"
    "multicol"
    "multirow"
    "array"
    "graphicx"
    "titlesec"
    "footmisc"
    "fancyhdr"
    "enumitem"
    "caption"
    "subcaption"
    "xcolor"
    "hyperref"
    "amsmath"
    "amsfonts"
    "amssymb"
    "latexsym"
    "marvosym"
    "pifont"
    "libertine"
    "xltxtra"
    "xeCJK"
    "xpinyin"
    "setspace"
    "minted")
   (TeX-add-symbols
    '("pdfbookmark" ["argument"] 2)
    '("codec" 1)
    '("Subject" 1)
    '("enUniv" 1)
    '("Univ" 1)
    '("enSchool" 1)
    '("School" 1)
    '("Acknowledgments" 1)
    '("enKeywords" 1)
    '("Keywords" 1)
    '("enAbstract" 1)
    '("Abstract" 1)
    '("Year" 1)
    '("Month" 1)
    '("AdvisorInfo" 1)
    '("AdvisorTitle" 1)
    '("Advisor" 1)
    '("Degree" 1)
    '("Docname" 1)
    '("enAuthor" 1)
    '("Author" 1)
    '("enTitle" 1)
    '("Title" 1)
    '("ziju" 1)
    '("Appendix" 1)
    "Ca"
    "Cb"
    "Cc"
    "Cd"
    "Ce"
    "Cf"
    "Cg"
    "Ch"
    "Ci"
    "Cj"
    "Ck"
    "Cl"
    "Cm"
    "Cn"
    "Cp"
    "Cs"
    "Cv"
    "Cx"
    "Cy"
    "Cslash"
    "Se"
    "Md"
    "Mv"
    "Mx"
    "MEnter"
    "Tab"
    "Enter"
    "Caps"
    "Ctrl"
    "SWFCtitlepage"
    "abstractpage"
    "enabstractpage"
    "acknowledgmentspage"
    "advisorinfopage"
    "makepreliminarypages"
    "cite")
   (LaTeX-add-environments
    '("pythoncode*" LaTeX-env-args (TeX-arg-key-val LaTeX-minted-key-val-options-local))
    '("pythoncode")
    '("nasmcode*" LaTeX-env-args (TeX-arg-key-val LaTeX-minted-key-val-options-local))
    '("nasmcode")
    '("gascode*" LaTeX-env-args (TeX-arg-key-val LaTeX-minted-key-val-options-local))
    '("gascode")
    '("latexcode*" LaTeX-env-args (TeX-arg-key-val LaTeX-minted-key-val-options-local))
    '("latexcode")
    '("ccode*" LaTeX-env-args (TeX-arg-key-val LaTeX-minted-key-val-options-local))
    '("ccode")))
 :latex)

