
set -v
sudo docker stop cocalc-test
sudo docker rm cocalc-test
sudo docker push  sagemathinc/cocalc-no-agpl
