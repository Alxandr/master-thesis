PANDOC             = pandoc
PANDOC_LATEX_FLAGS = -M cref=true -f markdown -t latex --filter pandoc-mermaid --filter=pandoc-crossref --filter=pandoc-citeproc --bibliography references.bib --biblatex
MARKDOWN_FILES     = $(shell find src -type f -name '*.md')
TEX_FILES          = $(patsubst src/%.md,tex/%.tex,$(MARKDOWN_FILES))

report.pdf: tex report.tex report.bbl $(TEX_FILES)
	xelatex -interaction=nonstopmode report.tex

report.bbl: references.bib
	@xelatex -interaction=nonstopmode report.tex
	biber report

tex/%.tex: src/%.md
	$(PANDOC) $(PANDOC_LATEX_FLAGS) -o $@ $<
