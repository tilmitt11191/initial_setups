#!/usr/bin/env bash

echo "####`basename $0` start."
INITIALDIR=`sudo pwd`
cd `dirname $0`


source $PYENV_ROOT/versions/anaconda/bin/activate py2.7 || echo "you should conda create --name py.2.7 python=2.7 anaconda && activate"
export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
sudo apt -y install  apt-transport-https 
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt -y update && sudo apt -y install google-cloud-sdk | tee -a ~/tmp/tmp.txt

##必要に応じて、次の追加コンポーネントをインストールします。
##
##    google-cloud-sdk-app-engine-python
##    google-cloud-sdk-app-engine-python-extras
##    google-cloud-sdk-app-engine-java
##    google-cloud-sdk-app-engine-go
##    google-cloud-sdk-datalab
##    google-cloud-sdk-datastore-emulator
##    google-cloud-sdk-pubsub-emulator
##    google-cloud-sdk-cbt
##    google-cloud-sdk-cloud-build-local
##	  google-cloud-sdk-bigtable-emulator
##    kubectl

gcloud init

cd $INITIALDIR
exit 0

: <<'#__CO__'
#__CO__
