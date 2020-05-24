IMAGE_TAG = latest


default: build

build: build-challenge-local build-detectify-challenge-local

build-challenge-local:
	@echo building docker image=$(CHALLENGE_LOCAL_IMAGE):$(IMAGE_TAG)
	@docker build -t $(CHALLENGE_LOCAL_IMAGE) challenge.local/

build-detectify-challenge-local:
	@echo building docker image=$(DETECTIFY_CHALLENGE_LOCAL_IMAGE):$(IMAGE_TAG)
	@docker build -t $(DETECTIFY_CHALLENGE_LOCAL_IMAGE) detectify.challenge.local/

push: push-challenge-local push-detectify-challenge-local

push-challenge-local:
	@echo pushing docker image=$(CHALLENGE_LOCAL_IMAGE):$(IMAGE_TAG)
	@docker push $(CHALLENGE_LOCAL_IMAGE):$(IMAGE_TAG)

push-detectify-challenge-local:
	@echo pushing docker image=$(DETECTIFY_CHALLENGE_LOCAL_IMAGE):$(IMAGE_TAG)
	@docker push $(DETECTIFY_CHALLENGE_LOCAL_IMAGE):$(IMAGE_TAG)

deploy:
	@echo deploying application to kubernetes
	@helm upgrade --install detectify-challenge --namespace $(NAMESPACE) detectify-challenge/ --set challengeApp.image=$(CHALLENGE_LOCAL_IMAGE):$(IMAGE_TAG) --set detectifyChallengeApp.image=$(DETECTIFY_CHALLENGE_LOCAL_IMAGE):$(IMAGE_TAG)