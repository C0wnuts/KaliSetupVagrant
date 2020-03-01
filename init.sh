#!/bin/bash

function gitCloneBulk()
{
	git clone https://github.com/superkojiman/onetwopunch.git
	git clone https://github.com/drwetter/testssl.sh.git /opt/testssl
	git clone https://github.com/rastating/joomlavs.git
	git clone https://github.com/aboul3la/Sublist3r.git
	git clone https://github.com/trustedsec/unicorn
	git clone https://github.com/Screetsec/Sudomy.git
	git clone https://github.com/m8r0wn/crosslinked
	git clone https://github.com/droope/droopescan.git
	git clone https://github.com/maurosoria/dirsearch.git
	git clone https://github.com/k4m4/dymerge.git
	git clone https://github.com/1N3/IntruderPayloads /opt/wordlist/IntruderPayloads
	git clone https://github.com/C0wnuts/FinalDics.git /opt/wordlist/FinalDics
	git clone https://github.com/fuzzdb-project/fuzzdb.git /opt/wordlist/fuzzdb
	git clone --recursive https://github.com/byt3bl33d3r/CrackMapExec /opt/CrackMapExec
	git clone https://github.com/EmpireProject/Empire.git /opt/Empire
	git clone https://github.com/byt3bl33d3r/DeathStar /opt/DeathStar
	git clone https://github.com/mzet-/linux-exploit-suggester.git /opt/privEscTools/linux-exploit-suggester-sh
	git clone https://github.com/jondonas/linux-exploit-suggester-2.git /opt/privEscTools/linux-exploit-suggester-pl
	git clone https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite.git /opt/privEscTools/privilege-escalation-awesome-scripts-suite
	git clone https://github.com/diego-treitos/linux-smart-enumeration.git /opt/privEscTools/linux-smart-enumeration
	git clone https://github.com/rebootuser/LinEnum.git /opt/privEscTools/LinEnum
	git clone https://github.com/AlessandroZ/BeRoot.git /opt/privEscTools/BeRoot
	git clone https://github.com/sleventyeleven/linuxprivchecker.git /opt/privEscTools/linuxprivchecker
	git clone https://github.com/pentestmonkey/unix-privesc-check.git /opt/privEscTools/unix-privesc-check
	git clone https://github.com/TH3xACE/SUDO_KILLER.git /opt/privEscTools/SUDO_KILLER
	git clone https://github.com/C0wnuts/webExploitPages.git
}

function runAptGetUpgrade()
{
    DEBIAN_FRONTEND='noninteractive' apt-get -y -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold' full-upgrade

    apt-get autoremove -y
    apt-get clean
    apt-get autoclean
}

function runAptGetInstall()
{
    DEBIAN_FRONTEND='noninteractive' apt-get -y -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold' install $1
}

function pipInstallBulk()
{
	pip install pipenv 
	pip3 install -r /opt/crosslinked/requirements.txt
	pip install -r /opt/droopescan/requirements.txt
	pip install -r /opt/Sublist3r/requirements.txt
	pip install -r /opt/Sudomy/requirements.txt
	pip3 install -r /opt/Sudomy/requirements.txt
	pip3 install -r /opt/DeathStarrequirements.txt
	pip install -r /opt/CrackMapExec/cme/thirdparty/impacket/requirements.txt
}

function changeKeyboard()
{
	echo 'setxkbmap fr' >> /root/.bashrc
	echo '# KEYBOARD CONFIGURATION FILE' > /etc/default/keyboard
	echo '' >> /etc/default/keyboard
	echo '# Consult the keyboard(5) manual page.' >> /etc/default/keyboard
	echo '' >> /etc/default/keyboard
	echo 'XKBMODEL="pc105"' >> /etc/default/keyboard
	echo 'XKBLAYOUT="fr"' >> /etc/default/keyboard
	echo 'XKBVARIANT="oss"' >> /etc/default/keyboard
	echo 'XKBOPTIONS=""' >> /etc/default/keyboard
	echo '' >> /etc/default/keyboard
	echo 'BACKSPACE="guess"' >> /etc/default/keyboard
}

function installApkTool()
{
	wget https://raw.githubusercontent.com/iBotPeaches/Apktool/master/scripts/linux/apktool -P /opt/
	wget https://bitbucket.org/iBotPeaches/apktool/downloads/apktool_2.4.0.jar -P /opt/
	mv /opt/apktool_2.4.0.jar /opt/apktool.jar
	mv /opt/apktool* /usr/local/bin
	chmod +x /usr/local/bin/apktool*
}

i=0
while ((i!=1))
do
	if ping -q -c 1 -W 1 8.8.8.8 >/dev/null; then
	  echo "IPv4 is up"
	  i=1
	else
	  echo "IPv4 is down"
	  sleep 5
	fi
done

sleep 10
echo "Kill apt process"
killall apt apt-get > /dev/null 2>&1
echo "deb http://http.kali.org/kali kali-rolling main non-free contrib" > /etc/apt/sources.list
echo "deb-src http://http.kali.org/kali kali-rolling main non-free contrib" >> /etc/apt/sources.list
apt-get update
runAptGetUpgrade
dpkg --configure -a --force-confnew
runAptGetInstall "aha xalan geany python-pip golang jq phantomjs gdebi"
mkdir /opt
cd /opt
wget https://github.com/gnunn1/tilix/releases/download/1.9.3/tilix.zip
sudo unzip tilix.zip -d /
sudo glib-compile-schemas /usr/share/glib-2.0/schemas/
rm tilix.zip
mkdir /opt/wordlist
mkdir /opt/privEscTools
gitCloneBulk
cd /opt/wordlist
gzip -d /usr/share/wordlists/rockyou.txt.gz
mv /usr/share/wordlists/rockyou.txt ./
cd /opt/joomlavs/
runAptGetInstall "libssl-dev libffi-dev python-dev build-essential patch ruby-dev zlib1g-dev liblzma-dev libcurl4-openssl-dev"
gem install bundler && bundle install
pipInstallBulk
systemctl start postgresql
systemctl enable postgresql
msfdb init
go get github.com/evilsocket/dnssearch
cd /root/go/src/github.com/evilsocket/dnssearch/
go build -o dnssearch main.go
go get -u github.com/tomnomnom/httprobe
go get -u github.com/OJ/gobuster
cd /opt/Empire
./setup/install.sh
cd CrackMapExec && pipenv install
pipenv run python setup.py install
ln -s /opt/joomlavs/joomlavs.rb /usr/bin/joomlavs
ln -s /opt/testssl/testssl.sh /usr/bin/testssl
ln -s /opt/Sublist3r/sublist3r.py /usr/bin/sublist3r
runAptGetInstall "apt-transport-https ca-certificates curl gnupg2 software-properties-common"
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
echo 'deb [arch=amd64] https://download.docker.com/linux/debian buster stable' > /etc/apt/sources.list.d/docker.list
apt-get update
runAptGetInstall "docker-ce docker-ce-cli containerd.io"
echo 'export PATH=$PATH:/root/go/bin' >> /root/.bashrc
systemctl enable docker
installApkTool
changeKeyboard
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
chsh -s $(which zsh)
echo "Reboot machine"
reboot