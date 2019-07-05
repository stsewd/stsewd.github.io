clean:
	rm -rf cache output .doit.db .doit.db.*

serve:
	nikola auto

deploy:
	NIKOLA_DEPLOY=stsewd.dev nikola github_deploy

.PHONY: clean serve deploy
