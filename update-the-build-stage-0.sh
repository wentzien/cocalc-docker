set -v
sudo docker stop cocalc
sudo docker rm cocalc
set -e
git pull
time sudo docker build --build-arg commit=$1 -t cocalc .
sudo docker tag cocalc:latest sagemathinc/cocalc
sudo docker run --name=cocalc -d -v ~/cocalc:/projects -p 443:443 sagemathinc/cocalc
