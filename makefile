build:
	DOCKER_BUILDKIT=0  docker build -t cocalc .

build-no-cache:
	DOCKER_BUILDKIT=0  docker build --no-cache -t cocalc .

personal:
	DOCKER_BUILDKIT=0  docker build -t cocalc-personal -f Dockerfile-personal .

personal-no-cache:
	DOCKER_BUILDKIT=0  docker build --no-cache -t cocalc-personal -f Dockerfile-personal .

