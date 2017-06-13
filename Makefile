DOCKER_REPO ?= cfhammill/RMINC-shiny-server
TAG ?= latest


build:
	docker build -t ${DOCKER_REPO}:${TAG} .


run:
	docker run -i -t -p 4001:3838 \
		${DOCKER_REPO}

push:
	docker push ${DOCKER_REPO}:${TAG}

.PHONY: build run push
