%.upload: %.html
	# uploadPage $*
	touch $@
%.html: %.md
	Markdown.pl $^ > $@
