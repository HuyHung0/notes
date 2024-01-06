all:
	# server locally with minify
	hugo server --minify --theme hugo-book
d:
	# build draft
	hugo server --buildDrafts
p:
	# public site
	hugo
