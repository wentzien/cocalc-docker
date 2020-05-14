set -x
sudo docker stop cocalc-test
sudo docker rm cocalc-test
set -e
git pull
commit=`git ls-remote -h https://github.com/sagemathinc/cocalc master | awk '{print $1}'`
echo $commit | cut -c-12 > current_commit
#time sudo docker build --no-cache --build-arg commit=$commit --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') -t cocalc $@ .
time sudo docker build --build-arg commit=$commit --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') -t cocalc $@ .
sudo docker tag cocalc:latest sagemathinc/cocalc:latest
sudo docker tag cocalc:latest sagemathinc/cocalc:`cat current_commit`
sudo docker run --name=cocalc-test -d -v ~/cocalc-test:/projects -p 4043:443 sagemathinc/cocalc
