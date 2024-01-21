s:
	# server locally with minify
	hugo server --minify --theme hugo-book --baseURL=http://localhost:1313/notes/
d:
	# build draft
	hugo server --buildDrafts
p:
	# public site
	hugo

stop:
	@echo "Stopping Hugo server..."
	-@pkill -f "hugo server" || true
	@sleep 1
	@echo "Hugo server stopped."

open:
	@if ! pgrep -x "firefox" > /dev/null ; then \
		firefox http://localhost:1313/notes/ ; \
	else \
		firefox --new-tab http://localhost:1313/notes/ ; \
	fi
