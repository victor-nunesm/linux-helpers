#!/bin/bash
echo 'GOVERNOR="powersave"' | sudo tee /etc/default/cpufrequtils

echo 'Upading system'
sudo apt-get -qq -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" update
sudo apt-get -qq -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade
sudo apt-get -qq -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install software-properties-common apt-transport-https wget curl

echo 'Installing multimidia softwares'
sudo apt-get -qq -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install -y lsp-plugins
sudo add-apt-repository ppa:mikhailnov/pulseeffects
sudo apt-get -qq -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install pulseaudio pulseeffects --install-recommends
sudo apt-get -qq -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install pavucontrol
bash -c "$(curl -fsSL https://raw.githubusercontent.com/JackHack96/PulseEffects-Presets/master/install.sh)"
echo "[Desktop Entry] Hidden=true" > /tmp/1
find /usr -name "*lsp_plug*desktop" 2>/dev/null | cut -f 5 -d '/' | xargs -I {} cp /tmp/1 ~/.local/share/applications/{}
bash -c "$(curl -fsSL https://raw.githubusercontent.com/JackHack96/PulseEffects-Presets/master/install.sh)"
mkdir -p $HOME/media
sudo mount --bind /media $HOME/media
sudo chown -R $USER:root $HOME/media
sudo chmod -R 777 $HOME/media
snap install --classic spotify

echo 'Installing docker and docker-compose'
sudo apt-get -qq -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" remove docker docker-engine docker.io containerd runc
sudo apt-get -qq -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get -qq -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" update
sudo apt-get -qq -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install docker-ce docker-ce-cli containerd.io
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
sudo groupadd docker
sudo usermod -aG docker ${USER}

echo "Installing Javascript development environment"
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
source ~/.profile
nvm install --lts
npm i -g -g --quiet --no-progress cordova
npm i -g -g --quiet --no-progress cordova-res --unsafe-perm
npm i -g -g --quiet --no-progress @angular/cli @ionic/cli express express-generator native-run
sudo snap install code --classic
wget -qO- https://raw.githubusercontent.com/cra0zy/code-nautilus/master/install.sh | bash

echo "Installing Android Studio and its dependencies"
sudo snap install android-studio --classic
mkdir -p $HOME/.android/avd
wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1tkn20W0rBNANGYuqM5PqAixILvbr6L2m' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1tkn20W0rBNANGYuqM5PqAixILvbr6L2m" -O jdk-8u251-linux-x64.tar.gz && rm -rf /tmp/cookies.txt
sudo mkdir /usr/lib/jvm && sudo mv jdk-8u251-linux-x64.tar.gz /usr/lib/jvm && cd /usr/lib/jvm
sudo tar -xvzf jdk-8u251-linux-x64.tar.gz
sudo update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/jdk1.8.0_251/bin/java" 0
sudo update-alternatives --install "/usr/bin/javac" "javac" "/usr/lib/jvm/jdk1.8.0_251/bin/javac" 0
sudo update-alternatives --set java /usr/lib/jvm/jdk1.8.0_251/bin/java
sudo update-alternatives --set javac /usr/lib/jvm/jdk1.8.0_251/bin/javac
sudo add-apt-repository ppa:cwchien/gradle
sudo apt-get -qq -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" update
sudo apt-get -qq -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install gradle
mkdir -p $HOME/.android/avd

echo "Please, type your Github global name and press ENTER"
read GITHUB_NAME
git config --global user.name "$GITHUB_NAME"
echo "Now, type your Github global email address and press ENTER"
read GITHUB_EMAIL
git config --global user.email $GITHUB_EMAIL

echo "Installing utils"
sudo apt-get -qq -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install baobab

echo "Reducing journalctl vacuum time to 10 days"
sudo journalctl --vacuum-time=10d

echo "Updating environment variables"
echo 'PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/lib/jvm/jdk1.8.0_251/bin:/usr/lib/jvm/jdk1.8.0_251/db/bin:/usr/lib/jvm/jdk1.8.0_251/jre/bin"' > /etc/environment
echo 'J2SDKDIR="/usr/lib/jvm/jdk1.8.0_251"' >> /etc/environment
echo 'J2REDIR="/usr/lib/jvm/jdk1.8.0_251/jre"' >> /etc/environment
echo 'JAVA_HOME="/usr/lib/jvm/jdk1.8.0_251"' >> /etc/environment
echo 'DERBY_HOME="/usr/lib/jvm/jdk1.8.0_251/db"' >> /etc/environment

echo 'export ANDROID_HOME=/home/victor/Android/Sdk' >> $HOME/.bashrc
echo 'export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools' >> $HOME/.bashrc
echo 'export JAVA_HOME="/usr/lib/jvm/jdk1.8.0_251"' >> $HOME/.bashrc
echo 'export PATH=$PATH:$JAVA_HOME/bin' >> $HOME/.bashrc
