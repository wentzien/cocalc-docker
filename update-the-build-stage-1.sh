
set -v
sudo docker stop cocalc
sudo docker rm cocalc
sudo docker push  sagemathinc/cocalc
