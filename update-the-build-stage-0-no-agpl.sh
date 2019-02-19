set -v
sudo docker stop cocalc-test
sudo docker rm cocalc-test
set -e
git pull
time sudo docker build --build-arg commit=`git ls-remote -h https://github.com/sagemathinc/cocalc master | awk '{print $1}'` -t cocalc -f Dockerfile-no-agpl .
sudo docker tag cocalc:latest sagemathinc/cocalc-no-agpl
sudo docker run --name=cocalc-test -d -v ~/cocalc-test:/projects -p 4043:443 sagemathinc/cocalc-no-agpl
