(TeX-add-style-hook
 "thesis"
 (lambda ()
   (TeX-run-style-hooks
    "latex2e"
    "swfcthesis"
    "swfcthesis10")
   (LaTeX-add-labels
    "sec:background"
    "sec:devel-envir"
    "sec:tools"
    "sec:install"
    "sec:qemu"
    "sec:wine"
    "sec:debian-i386-support"
    "cha:leading-knowledge"
    "sec:instruction-set"
    "sec:register"
    "sec:interrupted-call"
    "tab:intcall"
    "sec:memory-map"
    "sec:floppy-disk"
    "fig:flpy1.png"
    "sec:top-level-design"
    "sec:32-bit-mode"
    "sec:flowch-boot-load"
    "fig:flowchart-of-boot-loader"
    "sec:running-result"
    "fig:iplRes"
    "sec:dis-boo-inf"
    "sec:rea-sec-sec"
    "sec:rea-two-sid"
    "sec:the-nex-cyl")
   (LaTeX-add-bibliographies))
 :latex)
