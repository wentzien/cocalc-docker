build:
	DOCKER_BUILDKIT=0  docker build -t cocalc .

build-full:
	DOCKER_BUILDKIT=0  docker build --no-cache -t cocalc .


# WARNING: this minimal is a work in progress that does NOT work yet.
minimal:
	DOCKER_BUILDKIT=0  docker build -t cocalc-minimal -f Dockerfile.minimal .

