PANDOC             = pandoc
PANDOC_LATEX_FLAGS = -M cref=true -f markdown -t latex --filter pandoc-mermaid --filter=pandoc-crossref --filter=pandoc-citeproc --bibliography references.bib --biblatex
MARKDOWN_FILES     = $(shell find src -type f -name '*.md')
TEX_FILES          = $(patsubst src/%.md,tex/%.tex,$(MARKDOWN_FILES))

report.pdf: report.tex references.bib $(TEX_FILES)
	@xelatex -interaction=nonstopmode report.tex
	biber report
	xelatex -interaction=nonstopmode report.tex

tex/%.tex: src/%.md tex
	$(PANDOC) $(PANDOC_LATEX_FLAGS) -o $@ $<

.PHONY: tex
tex:
	@mkdir -p tex
	@mkdir -p tex/chapter-1
