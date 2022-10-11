release: build-release push-release

build-release:
	@TARGET=prod TAG=main docker-compose -f docker-compose.yaml build

push-release:
	@TARGET=prod TAG=main docker-compose -f docker-compose.yaml push