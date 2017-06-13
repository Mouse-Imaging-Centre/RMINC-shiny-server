DOCKER_REPO ?= cfhammill/rminc-shiny-server
TAG ?= latest
TAG_ARGS := -t ${DOCKER_REPO}:$(shell echo ${TAG} | sed "s|:| -t ${DOCKER_REPO}:|g") 
RMINC ?= "master"


build:
	docker build --build-arg RMINC_ref=${RMINC} ${TAG_ARGS} .


run:
	docker run -i -t -p 4001:3838 \
		${DOCKER_REPO}

push:
	docker push ${DOCKER_REPO}:${TAG}

.PHONY: build run push
