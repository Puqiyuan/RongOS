(TeX-add-style-hook
 "thesis"
 (lambda ()
   (TeX-run-style-hooks
    "latex2e"
    "swfcthesis"
    "swfcthesis10")
   (LaTeX-add-labels
    "cha:leading-knowledge-1"
    "sec:mouse"
    "sec:leap-road-32"
    "sec:data-structure"
    "tbl:intcall"
    "tbl:memlayout"
    "fig:flpy1.png"
    "fig:flowchart-of-boot-loader"
    "fig:iplRes"
    "sec:dis-boo-inf"
    "sec:rea-sec-sec"
    "sec:rea-two-sid"
    "sec:the-nex-cyl")
   (LaTeX-add-bibliographies))
 :latex)

