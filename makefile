build:
	DOCKER_BUILDKIT=0  docker build -t cocalc .

build-full:
	DOCKER_BUILDKIT=0  docker build --no-cache -t cocalc .

minimal:
	DOCKER_BUILDKIT=0  docker build -t cocalc-minimal -f Dockerfile.minimal .

