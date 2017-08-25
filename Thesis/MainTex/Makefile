pdf: thesis.tex
	sed -i 's/flowchart_p.pdf/flowchart_e.pdf/g' thesis.tex
	sed -i 's/swfcthesis_p/swfcthesis_e/g' thesis.tex
	latexmk thesis.tex
	mv thesis.pdf thesis_e.pdf
	sed -i 's/flowchart_e.pdf/flowchart_p.pdf/g' thesis.tex
	sed -i 's/swfcthesis_e/swfcthesis_p/g' thesis.tex
	latexmk thesis.tex
	mv thesis.pdf thesis_p.pdf

clean:
	rm thesis.aux thesis.bcf thesis.bbl thesis.blg thesis.fdb_latexmk \
	thesis.fls thesis.lof thesis.log thesis.lot thesis.out thesis.run.xml \
	thesis.synctex.gz thesis.toc auto/ _minted-thesis/ -rf
