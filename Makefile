MAIN=main
OUTDIR=out
MODE=errorstopmode
OKWORDS=okwords.txt
BADWORDS=badwords.txt

pdf:
	pdflatex --output-directory $(OUTDIR) $(MAIN).tex
	TEXMFOUTPUT=$(OUTDIR) bibtex $(OUTDIR)/$(MAIN)
	pdflatex --output-directory $(OUTDIR) $(MAIN).tex
	pdflatex --output-directory $(OUTDIR) $(MAIN).tex

all:
	latexmk -shell-escape -xelatex -bibtex -outdir=$(OUTDIR) -auxdir=$(OUTDIR) $(MAIN).tex

pv:
	latexmk -shell-escape -xelatex -bibtex -pvc -interaction=$(MODE) -outdir=$(OUTDIR) -auxdir=$(OUTDIR) $(MAIN).tex

spellcheck: 
	@test -e $(OKWORDS) || touch $(OKWORDS)
	@find . -type f -name "*.tex" -exec hunspell -t -l -p $(OKWORDS) {} \; | sort -f | uniq > $(BADWORDS)
	@cat $(BADWORDS)

.PHONY: clean
clean:
	rm -rf $(OUTDIR)/*
