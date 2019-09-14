mkdir -p $HOME/lib && sudo apt -y install git && git clone https://github.com/tilmitt11191/initial_setups $HOME/lib/initial_setups  
bash -x $HOME/lib/initial_setups/install.sh


if use VirtualBox,  
sudo apt install -y gcc make perl  
mkdir -p ~/lib/GuestAdditionCD/  
cp -r /media/***/VBox_GAs_***  
cd ~/lib/GuestAdditionCD//VBox_GAs_***/  
sudo ./VBoxLinuxAdditons.run  
sudo adduser ユーザ名 vboxsf  
sudo reboot  