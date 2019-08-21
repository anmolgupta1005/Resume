DOC = deedy_resume_Anmol.tex
PDFLATEX = pdflatex
BIBTEX = bibtex
LUALATEX = lualatex
XELATEX = xelatex
RERUN = "(There were undefined references|Rerun to get (cross-references|the bars) right)"
RERUNBIB = "No file.*\.bbl|Citation.*undefined"
TARDIR = $(DOC:.tex=-src)
.PHONY: pdf clean

pdf: $(DOC:.tex=.pdf)
all: pdf

%.pdf: %.tex
	${XELATEX} $<
	egrep -c $(RERUNBIB) $*.log && ($(BIBTEX) $*;$(PDFLATEX) $<) ; true
	egrep $(RERUN) $*.log && ($(LUALATEX) $<) ; true
	egrep $(RERUN) $*.log && ($(LUALATEX) $<) ; true
	egrep -i "(Reference|Citation).*undefined" $*.log ; true

clean:
	@\rm -f \
        $(DOC:.tex=.aux) \
        $(DOC:.tex=.log) \
        $(DOC:.tex=.out) \
        $(DOC:.tex=.dvi) \
        $(DOC:.tex=.pdf) \
        $(DOC:.tex=.ps)  \
        $(DOC:.tex=.bbl) \
        $(DOC:.tex=.blg) \
		$(DOC:.tex=-src.tar.gz)

veryclean: clean
	@\rm -f *~ *.log
