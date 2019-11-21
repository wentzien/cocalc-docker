
set -v
sudo docker stop cocalc-no-agpl-test
sudo docker rm cocalc-no-agpl-test
sudo docker push  sagemathinc/cocalc-no-agpl
sudo docker push  sagemathinc/cocalc-no-agpl:`cat current_commit_noagpl`
