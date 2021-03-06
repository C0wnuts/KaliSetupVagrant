#!/bin/bash

TIMEZONE="Europe/Paris"

function gitCloneBulk()
{
	git clone https://github.com/superkojiman/onetwopunch.git /opt/onetwopunch
	git clone https://github.com/21y4d/nmapAutomator.git /opt/nmapAutomator
	git clone https://github.com/vulnersCom/nmap-vulners.git /opt/nmap-vulners

	git clone https://github.com/drwetter/testssl.sh.git /opt/web/testssl
	git clone https://github.com/rastating/joomlavs.git /opt/web/joomlavs
	git clone https://github.com/aboul3la/Sublist3r.git /opt/web/Sublist3r
	git clone https://github.com/Screetsec/Sudomy.git /opt/web/Sudomy
	git clone https://github.com/maurosoria/dirsearch.git /opt/web/dirsearch
	git clone https://github.com/C0wnuts/webExploitPages.git /opt/web/webExploitPages
	git clone https://github.com/internetwache/GitTools.git /opt/web/gitTools
	git clone https://github.com/ticarpi/jwt_tool.git /opt/web/jwt_tool
	git clone https://github.com/00theway/Ghostcat-CNVD-2020-10487.git /opt/web/Ghostcat
	git clone https://github.com/immunIT/drupwn.git /opt/web/drupwn
	git clone https://github.com/anouarbensaad/vulnx.git /opt/web/vulnx

	git clone https://github.com/trustedsec/unicorn.git /opt/internal/unicorn
	git clone https://github.com/SecureAuthCorp/impacket.git /opt/internal/impacket
	
	git clone https://github.com/m8r0wn/CrossLinked.git /opt/osint/crosslinked
	git clone https://github.com/initstring/linkedin2username.git /opt/osint/linkedin2username

	git clone https://github.com/k4m4/dymerge.git /opt/wordlist/dymerge
	git clone https://github.com/1N3/IntruderPayloads.git /opt/wordlist/IntruderPayloads
	git clone https://github.com/C0wnuts/FinalDics.git /opt/wordlist/FinalDics
	git clone https://github.com/fuzzdb-project/fuzzdb.git /opt/wordlist/fuzzdb
	git clone https://github.com/danielmiessler/SecLists.git /opt/wordlist/SecList

	git clone https://github.com/mzet-/linux-exploit-suggester.git /opt/privEscTools/linux-exploit-suggester-sh
	git clone https://github.com/jondonas/linux-exploit-suggester-2.git /opt/privEscTools/linux-exploit-suggester-pl
	git clone https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite.git /opt/privEscTools/privilege-escalation-awesome-scripts-suite
	git clone https://github.com/diego-treitos/linux-smart-enumeration.git /opt/privEscTools/linux-smart-enumeration
	git clone https://github.com/rebootuser/LinEnum.git /opt/privEscTools/LinEnum
	git clone https://github.com/AlessandroZ/BeRoot.git /opt/privEscTools/BeRoot
	git clone https://github.com/sleventyeleven/linuxprivchecker.git /opt/privEscTools/linuxprivchecker
	git clone https://github.com/pentestmonkey/unix-privesc-check.git /opt/privEscTools/unix-privesc-check
	git clone https://github.com/TH3xACE/SUDO_KILLER.git /opt/privEscTools/SUDO_KILLER
}

function runAptGetUpgrade()
{
    sudo DEBIAN_FRONTEND=noninteractive apt -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" -y full-upgrade

    apt-get autoremove -y
    apt-get clean
    apt-get autoclean
}

function runAptGetInstall()
{
    DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install $1
}

function pipInstallBulk()
{
	pip3 install pipenv pycryptodomex termcolor cprint pycryptodomex requests colorama droopescan
	pip3 install pylnk3 --force
	pip3 install -r /opt/osint/crosslinked/requirements.txt --force
	pip3 install -r /opt/osint/linkedin2username/requirements.txt --force
	pip3 install -r /opt/web/Sublist3r/requirements.txt --force
	pip3 install -r /opt/web/Sudomy/requirements.txt --force
	pip3 install -r /opt/web/drupwn/requirements.txt --force
	pip3 install -r /opt/web/dirsearch/requirements.txt --force
	pip3 install -r /opt/internal/impacket/requirements.txt --force
}

function changeKeyboard()
{
	echo 'setxkbmap fr' >> /root/.bashrc
	echo 'setxkbmap fr' >> /home/vagrant/.bashrc
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

function installPhantomjs()
{
	runAptGetInstall build-essential chrpath libssl-dev libxft-dev
	runAptGetInstall libfreetype6 libfreetype6-dev
	runAptGetInstall libfontconfig1 libfontconfig1-dev
	cd ~
	wget https://github.com/Medium/phantomjs/archive/2.1.14.tar.gz
	tar xvf 2.1.14.tar.gz
	mv phantomjs-2.1.14 /usr/local/share/
	ln -sf /usr/local/share/phantomjs-2.1.14/bin/phantomjs /usr/local/bin
	echo 'export OPENSSL_CONF=/etc/ssl/' >> /root/.bashrc
	echo 'export OPENSSL_CONF=/etc/ssl/' >> /home/vagrant/.bashrc
	rm 2.1.14.tar.gz
}

function zshSetup()
{
	sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
	chsh -s $(which zsh)
	mkdir /home/vagrant/.ssh
	chmod 0700 /home/vagrant/.ssh
	git clone git://github.com/robbyrussell/oh-my-zsh.git /home/vagrant/.oh-my-zsh
	chmod 0755 /home/vagrant/.oh-my-zsh
	cp /home/vagrant/.oh-my-zsh/templates/zshrc.zsh-template /home/vagrant/.zshrc
	chmod 0755 /home/vagrant/.zshrc
	chown -R vagrant:vagrant /home/vagrant
	chsh --shell /bin/zsh vagrant

	sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="bira"/' /root/.zshrc
	sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="bira"/' /home/vagrant/.zshrc
	sed -i 's/plugins=(git)/plugins=(git z)/' /root/.zshrc
	sed -i 's/plugins=(git)/plugins=(git z)/' /home/vagrant/.zshrc

	echo 'setxkbmap fr' >> /root/.zshrc
	echo 'setxkbmap fr' >> /home/vagrant/.zshrc
	echo 'export OPENSSL_CONF=/etc/ssl/' >> /root/.zshrc
	echo 'export OPENSSL_CONF=/etc/ssl/' >> /home/vagrant/.zshrc
	echo 'export PATH=$PATH:/root/go/bin' >> /root/.zshrc
	echo 'export PATH=$PATH:/root/go/bin' >> /home/vagrant/.zshrc
	echo 'zsh setup'
}

function nmapAutomatorSetup()
{
	chmod +x /opt/nmapAutomator.sh
	cd /opt/nmap-vulners
	cp *.nse /usr/share/nmap/scripts
	nmap --script-updatedb
	cd /opt
	rm -rf /opt/nmap-vulners
}

function symbolicLinkSetup()
{
	ln -s /opt/nmapAutomator/nmapAutomator.sh /usr/bin/nmapAutomator
	ln -s /opt/web/joomlavs/joomlavs.rb /usr/bin/joomlavs
	ln -s /opt/web/testssl/testssl.sh /usr/bin/testssl
}

function SimpleHTTPServerGolang()
{
	mkdir /opt/swego
	cd /opt/swego
	wget https://github.com/nodauf/Swego/releases/download/v0.9/webserver-linux-amd64
	chmod +x webserver-linux-amd64
}

function deathStar()
{
	python3 -m pip install pipx
	python3 -m pipx install deathstar-empire
	python3 -m pipx ensurepath
	sudo python3 -m pipx ensurepath
}

function initopt()
{
	mkdir /opt /opt/web /opt/internal /opt/privEscTools /opt/wordlist /opt/osint
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

timedatectl set-timezone $TIMEZONE
sleep 10
echo "Kill apt process"
killall apt apt-get > /dev/null 2>&1
echo "deb http://http.kali.org/kali kali-rolling main non-free contrib" > /etc/apt/sources.list
echo "deb-src http://http.kali.org/kali kali-rolling main non-free contrib" >> /etc/apt/sources.list
unset UCF_FORCE_CONFFOLD
export UCF_FORCE_CONFFNEW=YES
ucf --purge /boot/grub/menu.lst
export DEBIAN_FRONTEND=noninteractive
apt-get update
runAptGetUpgrade
runAptGetInstall "aha xalan geany golang jq gdebi tree keepass2 gcc-9-base gcc python3-pip remmina npm chromium parallel moreutils"
npm chromium parallel
installPhantomjs
initopt
cd /opt
wget https://github.com/gnunn1/tilix/releases/download/1.9.3/tilix.zip
sudo unzip tilix.zip -d /
sudo glib-compile-schemas /usr/share/glib-2.0/schemas/
rm tilix.zip
gitCloneBulk
deathStar
gzip -d /usr/share/wordlists/rockyou.txt.gz
cp /usr/share/wordlists/rockyou.txt /opt/wordlist/
cd /opt/web/joomlavs/
runAptGetInstall "libssl-dev libffi-dev python-dev build-essential patch ruby-dev zlib1g-dev liblzma-dev libcurl4-openssl-dev python3-venv"
pip install wheel
bundle update --bundler
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
SimpleHTTPServerGolang
nmapAutomatorSetup
runAptGetInstall "apt-transport-https ca-certificates curl gnupg2 software-properties-common enum4linux powershell-empire ffuf"
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
echo 'deb [arch=amd64] https://download.docker.com/linux/debian buster stable' > /etc/apt/sources.list.d/docker.list
apt-get update
runAptGetInstall "docker-ce docker-ce-cli containerd.io docker-compose"
echo 'export PATH=$PATH:/root/go/bin' >> /root/.bashrc
echo 'export PATH=$PATH:/root/go/bin' >> /home/vagrant/.bashrc
systemctl enable docker
installApkTool
symbolicLinkSetup
changeKeyboard
zshSetup
echo "poweroff machine"
poweroff