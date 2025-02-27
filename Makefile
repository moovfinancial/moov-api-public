NODE_IMAGE=node:22.14.0
WORKDIR=/workspace

all: format compile

docker: docker-format docker-compile

docker-format:
	docker run --rm -v $(PWD):$(WORKDIR) -w $(WORKDIR) $(NODE_IMAGE) npx tsp format "npm i && **/*.tsp"

docker-compile:
	docker run --rm -v $(PWD):$(WORKDIR) -w $(WORKDIR) $(NODE_IMAGE) sh -c "npm i && rm -rf ./openapi/ && npx tsp compile ./specification"

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
