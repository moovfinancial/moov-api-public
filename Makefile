all: format compile

setup:
	npm i

format:
	npx tsp format "**/*.tsp"

compile:
	rm -rf ./openapi/
	npx tsp compile ./specification

watch:
	rm -rf ./openapi/
	npx tsp compile ./specification --watch
