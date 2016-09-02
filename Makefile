# +----------+-------------------------------------------------------
# | Patterns |
# +----------+

# Normal conversions

%.html: %.mdhtml
	post-process $^ > $@
%.mdhtml: %.md
	Markdown.pl $^ > $@
%.module: %.template
	make-module $^ > $@

# Hacks to upload things.

%.page: %.html
	upload-page $*
	touch $@
%.assignment: %.html
	upload-assignment $* $^
	touch $@
%.discussion: %.html
	upload-discussion $* $^
	touch $@

# Temp and Live directories.

BPHOT/%.module: Modules/%.template
	make-module $^ > $@
Live/%.module: Modules/%.template
	make-module $^ > $@

# Extract due dates for each introduction
%-due.html: %.module
	make-due $^ > $@

# Extract toc for each module to use in introduction
%-toc.html: %.module
	make-toc $^ > $@

# +---------+--------------------------------------------------------
# | Default |
# +---------+

default:
	echo "Please specify what to make."

# +------------------+-----------------------------------------------
# | Special Patterns |
# +------------------+

BPHOT/getting-started.html: BPHOT/getting-started-due.html
BPHOT/getting-started-with-processing.html: BPHOT/getting-started-with-processing-due.html
