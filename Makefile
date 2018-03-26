clean:
	rm -rf cache output 

clean-build: clean
	nikola build
	nikola serve

.PHONY: clean clean-build
