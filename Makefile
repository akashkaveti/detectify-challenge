CHALLENGE_LOCAL_IMAGE = akashkaveti/challenge-local
DETECTIFY_CHALLENGE_LOCAL_IMAGE = akashkaveti/detectify-challenge-local
GIT_INFO = $(git log -1 --format=%h)
NAMESPACE=default

default: build

build: build-challenge-local build-detectify-challenge-local

build-challenge-local:
	@echo building docker image=$(CHALLENGE_LOCAL_IMAGE):$(GIT_INFO)
	@docker build -t $(CHALLENGE_LOCAL_IMAGE) challenge.local/

build-detectify-challenge-local:
	@echo building docker image=$(DETECTIFY_CHALLENGE_LOCAL_IMAGE):$(GIT_INFO)
	@docker build -t $(DETECTIFY_CHALLENGE_LOCAL_IMAGE) detectify.challenge.local/

push: push-challenge-local push-detectify-challenge-local

push-challenge-local:
	@echo pushing docker image=$(CHALLENGE_LOCAL_IMAGE):$(GIT_INFO)
	@docker push $(CHALLENGE_LOCAL_IMAGE):$(GIT_INFO)

push-detectify-challenge-local:
	@echo pushing docker image=$(DETECTIFY_CHALLENGE_LOCAL_IMAGE):$(GIT_INFO)
	@docker push $(DETECTIFY_CHALLENGE_LOCAL_IMAGE):$(GIT_INFO)

deploy:
	@echo deploying application to kubernetes
	@helm upgrade --install detectify-challenge --namespace $(NAMESPACE) detectify-challenge/ --set challengeApp.image=$(CHALLENGE_LOCAL_IMAGE):$(GIT_INFO) --set detectifyChallengeApp.image=$(DETECTIFY_CHALLENGE_LOCAL_IMAGE):$(GIT_INFO)