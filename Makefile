# ---------------------------------------
# Un makefile simple pour produire la thèse
# Auteur: Sylvain Hallé et Éric Laberge
# ---------------------------------------
.DEFAULT_GOAL := all

ifeq ($(OS),Windows_NT)
  RM = cmd /C del /Q /F
  RRM = cmd /C rmdir /Q /S
  CP = cmd /C cp
else
  RM = rm -f
  RRM = rm -f -r
  CP = cp
endif

FILENAME = these
INSTALLDIR=tex/latex/uqac-these

SRC=$(wildcard *.tex)

$(FILENAME).pdf: $(FILENAME).tex $(SRC)
	pdflatex $(FILENAME).tex

help:
	@echo "Makefile pour compiler la thèse de l'UQAC                              "
	@echo "                                                                       "
	@echo "Usage:                                                                 "
	@echo "   make once                        compile la thèse une fois          "
	@echo "   make all                         compile au complet (3x avec BibTeX)"
	@echo "   make clean                       efface les fichiers temporaires    "
	@echo "   make flush                       clean + efface le pdf de la thèse  "
	@echo "   make install                     installe la classe dans l'arbre    "
	@echo "                                      texmf local                      "
	@echo "   make file=chapX.tex aspell       passe le correcteur Aspell sur le  "
	@echo "                                      fichier chapX.tex                "
	@echo "   make file=chapX.tex textidote    passe TeXtidote sur le fichier     "
	@echo "                                      chapX.tex                        "
	@echo "   make pdfa                        convertit these.pdf au format PDF/A"
	@echo "                                                                       "

all: $(SRC)
	pdflatex -interaction=batchmode $(FILENAME).tex
	bibtex $(FILENAME)
	pdflatex -interaction=batchmode $(FILENAME).tex
	pdflatex -interaction=batchmode $(FILENAME).tex

once: $(SRC)
	pdflatex -interaction=batchmode $(FILENAME).tex

install:
	TEXHOME:=$(shell kpsewhich --var-value=TEXMFHOME)
	-mkdir $(TEXHOME)/$(INSTALLDIR)
	cp uqac-these.cls theseuqam.bst logo-uqac.pdf $(TEXHOME)/$(INSTALLDIR)/

clean:
	$(RM) *.aux *.log *.blg *.bbl *.dvi *.spl *.out *.toc *.lof *.lot *.lol *.idx *~ *.bak

aspell:
	aspell --home-dir=. --lang=fr --mode=tex --add-tex-command="nsc p" --add-tex-command="citep op" --add-tex-command="citet op" check $(file)

textidote:
	textidote --check fr --read-all $(file)

#Tweak of https://www.math.cmu.edu/~gautam/sj/blog/20221217-pdfa-conversion.html
pdfa: $(FILENAME).pdf $(FILENAME).xmpdata
	gs -dBATCH -dNOPAUSE -dNOOUTERSAVE \
   -sDEVICE=pdfwrite \
   -dPDFA=3 \
   -dCompatibilityLevel=1.7 \
   -dPDFACompatibilityPolicy=1 \
   -dEmbedAllFonts=true \
   -dUseCIEColor=true \
   -sColorConversionStrategy=UseDeviceIndependentColor \
   -sProcessColorModel=DeviceRGB \
   -sPDFAICCProfile=./sRGB_IEC61966-2-1.icc \
   -sOutputFile=$(FILENAME)-pdfa3b.pdf \
   $(FILENAME).pdf

flush: clean
	$(RM) $(FILENAME).pdf

.PHONY : all clean once install flush help aspell textidote pdfa
