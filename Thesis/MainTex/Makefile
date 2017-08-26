pdf: thesis.tex
	sed -i 's/flowchartp.pdf/flowcharte.pdf/g' thesis.tex
	sed -i 's/swfcthesisp/swfcthesise/g' thesis.tex
	latexmk thesis.tex
	mv thesis.pdf thesise.pdf
	sed -i 's/flowcharte.pdf/flowchartp.pdf/g' thesis.tex
	sed -i 's/swfcthesise/swfcthesisp/g' thesis.tex
	latexmk thesis.tex
	mv thesis.pdf thesisp.pdf

clean:
	rm thesis.aux thesis.bcf thesis.bbl thesis.blg thesis.fdb_latexmk \
	thesis.fls thesis.lof thesis.log thesis.lot thesis.out thesis.run.xml \
	thesis.synctex.gz thesis.toc auto/ _minted-thesis/ -rf
