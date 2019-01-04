#!/usr/bin/env bash

echo "####`basename $0` start."
INITIALDIR=`pwd`
cd `dirname $0`



wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-196.0.0-linux-x86_64.tar.gz?hl=ja -O $HOME/lib/google-cloud-sdk-196.0.0-linux-x86_64.tar.gz
cd $HOME/lib/
tar zxvf google-cloud-sdk-196.0.0-linux-x86_64.tar.gz
cd google-cloud-sdk
$HOME/lib/google-cloud-sdk/bin/gcloud auth activate-service-account erico-py-git@avian-curve-221823.iam.gserviceaccount.com --key-file $HOME/etc/erico-f0857fe9c486.json
# set 
: <<'#__CO__'
if [ $FLAG_GOOGLE_CLOUD_SDK ];then
	# The next line updates PATH for the Google Cloud SDK.
	if [ -f '$HOME/lib/google-cloud-sdk/path.zsh.inc' ]; then . '$HOME/lib/google-cloud-sdk/path.zsh.inc'; fi

	# The next line enables shell command completion for gcloud.
	if [ -f '$HOME/lib/google-cloud-sdk/completion.zsh.inc' ]; then . '$HOME/lib/google-cloud-sdk/completion.zsh.inc'; fi
fi
#__CO__
# source ~/.zshrc

cd $INITIALDIR
exit 0

: <<'#__CO__'
#__CO__
