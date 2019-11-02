# slow build of Docker images that builds latest sagemath and pulls latest supporting packages
# suppress caching and force pull of latest linux packages
#   add --no-cache and --pull to docker build
# also force specific julia version

# Warning: takes about 3 x as long as default build
# Warning: sagemath build from github master sometimes fails

JULIA_VERSION=1.2.0

usage () {
  echo "usage: ./longbuild [agpl|no-agpl]"
  exit 1
}

TSTCMD () {
  echo "sample commands:"
  echo time sudo docker build --build-arg commit=`git ls-remote -h https://github.com/sagemathinc/cocalc master | awk '{print $1}'` --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') -t cocalc $@ .
  echo time sudo docker build --build-arg commit=`git ls-remote -h https://github.com/sagemathinc/cocalc master | awk '{print $1}'` --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') -t cocalc -f Dockerfile-no-agpl $@ .
  usage
}

case $1 in
  "") TSTCMD;;
  "no-agpl") CMD="update-the-build-stage-0-no-agpl.sh";;
  "agpl") CMD=update-the-build-stage-0.sh;;
  *) echo "bad arg $1"; usage;;
esac

./$CMD --no-cache --pull --build-arg JULIA=${JULIA_VERSION}
