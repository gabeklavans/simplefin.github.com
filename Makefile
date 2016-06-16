
.PHONY: all watch

all: protocol.html diagrams

protocol.html: protocol.md style.css pandoc_template.html
	cat protocol.md | pandoc \
		-s -S -c style.css \
		--toc --toc-depth=2 \
		-t html5 \
		--highlight-style zenburn \
		--columns=10000 \
		--template pandoc_template.html > $@

diagrams: $(patsubst %,img/%.svg, $(basename $(notdir $(wildcard diag/*.seqdiag))))

img/%.svg: diag/%.seqdiag
	seqdiag $^ -o $@ -Tsvg -a

watch:
	watchmedo shell-command \
		--recursive \
		--wait \
		--drop \
		--command='make' \
		.