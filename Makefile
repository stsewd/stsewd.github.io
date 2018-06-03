clean:
	rm -rf cache output .doit.db .doit.db.*

serve:
	nikola auto

deploy:
	nikola github_deploy

.PHONY: clean serve deploy
