var1=\input{electronic}
var2=\input{printable}

pdf: flowchart.tex
	sed -i "1s/.*/\\$(var1)/" flowchart.tex
	latexmk flowchart.tex
	mv flowchart.pdf flowcharte.pdf
	sed -i "1s/.*/\\$(var2)/" flowchart.tex
	latexmk flowchart.tex
	mv flowchart.pdf flowchartp.pdf

clean:
	rm *.aux *.fdb_latexmk *.fls *.log *.gz auto/ -rf
