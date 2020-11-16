REPO ?= christianwohlert/linstor-csi-arm64
TAG ?= $(shell cd ./linstor-csi && git describe --exact-match $(git rev-parse --short HEAD))

all: build upload

build:
	docker buildx build --platform linux/arm64 . -t $(REPO):$(TAG)

upload:
	docker push $(REPO):$(TAG)
