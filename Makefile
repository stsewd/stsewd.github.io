clean:
	rm -rf cache output 

build:
	nikola build
	nikola serve

clean-build: clean build

.PHONY: clean build clean-build
