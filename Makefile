# convenience function for getting parent directory, will eventually return ./
#     $(call get_parent_dir,somewhere/on/earth/) -> somewhere/on/
get_parent_dir=$(dir $(patsubst %/,%,$1))

# function to create directory targets.
# All directories have order-only-prerequisites on their parent directories
# https://www.gnu.org/software/make/manual/html_node/Prerequisite-Types.html#Prerequisite-Types
TARGET_DIRS:=
define make_dirs_recursively
TARGET_DIRS+=$1
$1: | $(if $(subst ./,,$(call get_parent_dir,$1)),$(call get_parent_dir,$1))
		mkdir $1
endef

# function to recursively get all directories
#     $(call get_all_dirs,things/and/places/) -> things/ things/and/ things/and/places/
#     $(call get_all_dirs,things/and/places) -> things/ things/and/
get_all_dirs=$(if $(subst ./,,$(dir $1)),$(call get_all_dirs,$(call get_parent_dir,$1)) $1)

# function to turn all targets into directories
#     $(call get_all_target_dirs,obj/a.o obj/three/b.o) -> obj/ obj/three/
get_all_target_dirs=$(sort $(foreach target,$1,$(call get_all_dirs,$(dir $(target)))))

# create target dirs
create_dirs=$(foreach dirname,$(call get_all_target_dirs,$1),$(eval $(call make_dirs_recursively,$(dirname))))

# configure constants
PANDOC             = pandoc
PANDOC_LATEX_FLAGS = -M cref=true -f markdown -t latex --filter pandoc-mermaid --filter=pandoc-crossref --filter=pandoc-citeproc --bibliography references.bib --biblatex
MARKDOWN_FILES     = $(shell find src -type f -name '*.md')
TEX_FILES          = $(patsubst src/%.md,tex/%.tex,$(MARKDOWN_FILES))

# main production - make report
report.pdf: tex report.tex report.blg $(TEX_FILES)
	xelatex -interaction=nonstopmode report.tex

# keep references up to date
report.blg: references.bib
	@xelatex -interaction=nonstopmode report.tex
	biber report

# ensure directories are created
$(call create_dirs,$(TEX_FILES))

# convert single markdown file to latex
tex/%.tex: src/%.md | $(TARGET_DIRS)
	$(PANDOC) $(PANDOC_LATEX_FLAGS) -o $@ $<
