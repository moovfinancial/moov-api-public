all: format compile

format:
	npx tsp format "**/*.tsp"

compile:
	rm -rf ./openapi/
	npx tsp compile ./specification

watch:
	rm -rf ./openapi/
	npx tsp compile ./specification --watch
