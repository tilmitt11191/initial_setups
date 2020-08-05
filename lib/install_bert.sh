#!/usr/bin/env bash
# -*- coding: utf-8 -*-
export LANG=C

## refer https://qiita.com/takahashi_yukou/items/b81319b8ef6cee13cb1b

echo "####$(basename "$0") start."
INITIALDIR=$(pwd)
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")" || exit 1; pwd)
cd "$SCRIPT_DIR" || exit 1

unameOut="$(uname -a)"
IS_CYGWIN=""
IS_MAC=""
IS_LINUX=""
IS_UBUNTU=""
case "$unameOut" in
	CYGWIN*) echo "##this is Cygwin" && IS_CYGWIN=true;;
	Darwin*) echo "##this is macos" && IS_MAC=true;;
	Linux*) echo "##this is Linux" && IS_LINUX=true;;
	FreeBSD*) echo "##this is Linux" && IS_LINUX=true;;
	*) echo "##this is neither Cygwin nor Linux. exit 1" && exit 1;;
esac
case "$unameOut" in
	*Ubuntu*) echo "##this is Ubuntu" && IS_UBUNTU=true;;
esac
## check Windows Subsystem for Linux
[ -e /proc/sys/fs/binfmt_misc/WSLInterop ] && IS_UBUNTU=true

if [ ! -d ./tmp ]; then
	mkdir ./tmp
fi

if [ $IS_UBUNTU ]; then

	## install JUMAN++
	# sudo apt install -y git libboost-all-dev google-perftools libgoogle-perftools-dev
	# wget "http://lotus.kuee.kyoto-u.ac.jp/nl-resource/jumanpp/jumanpp-1.02.tar.xz" -O ./tmp/jumanpp-1.02.tar.xz
	cd ./tmp/ || exit 1
	# tar xJvf jumanpp-1.02.tar.xz
	# cd jumanpp-1.02 || exit 1
	# ./configure
	# make
	# sudo make install
	# cd ../ || exit 1

	# pip3 install pyknp 

	## clone BERT code

	# git clone https://github.com/google-research/bert
	# [ -e bert/tokenization.py ] && mv bert/tokenization.py bert/org.tokenization.py
	# cp ../berttokenization.py bert/tokenization.py

	## install tensorflow
	sudo dpkg -i cuda-repo-ubuntu1804_10.0.130-1_amd64.deb
	sudo dpkg -i libcudnn7_7.6.0.64-1+cuda10.0_amd64.deb
	sudo dpkg -i libcudnn7-dev_7.6.0.64-1+cuda10.0_amd64.deb
	sudo dpkg -i libcudnn7-doc_7.6.0.64-1+cuda10.0_amd64.deb
	sudo apt install cuda cuda-drivers
	pip3 install tensorflow-gpu
fi


## validation
cd bert
export BERT_BASE_DIR="/some_path/bert/Japanese_L-12_H-768_A-12_E-30_BPE"
python3 ./extract_features.py \
	--input_file=/tmp/input.txt \
	--output_file=/tmp/output.jsonl \
	--vocab_file=$BERT_BASE_DIR/vocab.txt \
	--bert_config_file=$BERT_BASE_DIR/bert_config.json \
	--init_checkpoint=$BERT_BASE_DIR/bert_model.ckpt \
	--do_lower_case False \
	--layers -2
cd "$INITIALDIR" || exit 1
exit 0

: <<'#__CO__'
#__CO__
