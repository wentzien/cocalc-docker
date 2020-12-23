build:
	DOCKER_BUILDKIT=0  docker build --progress=plain -t cocalc .

build-full:
	DOCKER_BUILDKIT=0  docker build --progress=plain --no-cache -t cocalc .

minimal:
	DOCKER_BUILDKIT=0  docker build --progress=plain -t cocalc-minimal -f Dockerfile.minimal .

