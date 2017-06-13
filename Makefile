DOCKER_REPO ?= cfhammill/rminc-shiny-server
TAG ?= latest
TAG_ARGS := -t ${DOCKER_REPO}:$(shell echo ${TAG} | sed "s|:| -t ${DOCKER_REPO}:|g") 
RMINC ?= "master"

## Usage: make build
## Configure with vars -->
## DOCKER_REPO: The username and repo for the docker image, defaults to
##   cfhammill/rminc-shiny-server
## TAG: A colon delimited list of tags to name the image, defaults to latest
##   multiple tags are mostly useful for an image that is 
##   latest:{R_VERS}_{RMINC_VERS}
## RMINC: A github reference to the version of RMINC you'd like to use
##   typical tags may be master, develop, v1.4.4.0, etc. See github
##   for available branches and tags
## example make TAGS=dev_version RMINC=develop build

build:
	docker build --build-arg RMINC_ref=${RMINC} ${TAG_ARGS} .


run:
	docker run -i -t -p 4001:3838 \
		${DOCKER_REPO}

push:
	docker push ${DOCKER_REPO}:${TAG}

.PHONY: build run push
