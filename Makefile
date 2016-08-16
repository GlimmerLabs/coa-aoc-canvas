# +----------+-------------------------------------------------------
# | Patterns |
# +----------+

%.page: %.html
	upload-page $*
	touch $@
Assignments/%.assignment: Assignments/%.html
	upload-assignment $* $^
	touch $@
Discussions/%.discussion: Discussions/%.html
	upload-discussion $* $^
	touch $@
Live/%.assignment: Live/%.html
	upload-assignment $* $^
	touch $@
Live/%.discussion: Live/%.html
	upload-discussion $* $^
	touch $@
%.html: %.mdhtml
	post-process $^ > $@
%.mdhtml: %.md
	Markdown.pl $^ > $@
%.module: %.template
	make-module $^ > $@

# Files that get included in most module introductions
# (for some reason, this doesn't work.  Do it manually.)
Introductions/%.html: Introductions/%-due.html

# Extract due dates for each introduction
Introductions/%-due.html: Modules/%.module
	make-due $^ > $@

# +---------+--------------------------------------------------------
# | Default |
# +---------+

default:
	echo "Foo!"

module01: Discussions/*.html Pages/*.html \



# Pages/getting-started-due.html: Modules/getting-started.module

Pages/getting-started.html: Pages/getting-started-due.html
Pages/getting-started-with-processing.html: Pages/getting-started-with-processing-due.html
