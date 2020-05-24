CHALLENGE_LOCAL_IMAGE = akashkaveti/challenge-local
DETECTIFY_CHALLENGE_LOCAL_IMAGE = akashkaveti/detectify-challenge-local
GIT_INFO = $(git log -1 --format=%h)

default: build

build: build-challenge-local build-detectify-challenge-local

build-challenge-local:
	@echo building docker image=$(CHALLENGE_LOCAL_IMAGE):$(GIT_INFO)
	@docker build -t $(CHALLENGE_LOCAL_IMAGE) challenge.local/

build-detectify-challenge-local:
	@echo building docker image=$(DETECTIFY_CHALLENGE_LOCAL_IMAGE):$(GIT_INFO)
	@docker build -t $(DETECTIFY_CHALLENGE_LOCAL_IMAGE) detectify.challenge.local/