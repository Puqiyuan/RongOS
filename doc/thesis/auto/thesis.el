(TeX-add-style-hook
 "thesis"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("enumitem" "inline")))
   (TeX-run-style-hooks
    "latex2e"
    "swfcthesis"
    "swfcthesis10"
    "todonotes"
    "enumitem")
   (TeX-add-symbols
    '("inlineitem" ["argument"] 0))
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
    "sec:top-level-design"
    "sec:detailed-design"
    "sec:boot-loader"
    "fig:working-flow-boot-loader"
    "sec:32-bit-mode"
    "sec:chose-disk"
    "sec:struct-floppy-disk"
    "fig:flpy1.png"
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

