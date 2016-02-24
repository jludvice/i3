#!/bin/bash
BASE_DIR=`pwd`

# Moka icons

sudo add-apt-repository ppa:moka/stable

# Ambiance blackout flat theme
sudo add-apt-repository ppa:ravefinity-project/ppa

# Arc theme
sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/Horst3180/xUbuntu_15.10/ /' >> /etc/apt/sources.list.d/arc-theme.list"
wget http://download.opensuse.org/repositories/home:Horst3180/xUbuntu_15.10/Release.key
sudo apt-key add - < Release.key
sudo apt-get update

sudo apt-get install rofi compton lxappearance feh scrot imagemagick arandr xfce4-power-manager thunar git cpanminus libgtk2-perl libgtk3-perl geany gsimplecal galculator suckless-tools libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev sysstat moka-icon-theme ambiance-blackout-flat-colors ruby-ronn arc-theme acpi

cd /tmp

# Fonts

curl -L -o awesome.zip https://fortawesome.github.io/Font-Awesome/assets/font-awesome-4.5.0.zip
curl -L -o sourcecodepro.zip https://github.com/adobe-fonts/source-code-pro/archive/2.010R-ro/1.030R-it.zip
curl -L -o ssf.zip https://github.com/supermarin/YosemiteSanFranciscoFont/archive/master.zip

unzip awesome.zip
unzip ssf.zip
unzip sourcecodepro.zip
unzip i3blockscontrib.zip 

mkdir ~/.fonts

mv /tmp/font-awesome-4.5.0/fonts/fontawesome-webfont.ttf ~/.fonts/
mv /tmp/YosemiteSanFranciscoFont-master/*.ttf ~/.fonts/
mv /tmp/source-code-pro-2.010R-ro-1.030R-it/TTF/*.ttf ~/.fonts/

# i3gaps
git clone https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps
git checkout gaps && git pull
make
sudo make install

# i3blocks-gaps
cd /tmp
git clone https://github.com/Airblader/i3blocks-gaps i3blocks-gaps
cd i3blocks-gaps
make clean all
sudo make install

mkdir -pv ~/.config/i3

# menutray
cpanm -n Linux::DesktopFiles --sudo
cpanm -n Data::Dump --sudo
git clone --depth 1 https://github.com/trizen/menutray
cd menutray
mv menutray ~/.config/i3
mkdir ~/.config/menutray
cp schema.pl ~/.config/menutray/

cp $BASE_DIR/config ~/.config/i3/
cp $BASE_DIR/i3blocks.conf ~/.config/i3/
cp $BASE_DIR/cpu_usage ~/.config/i3/
cp $BASE_DIR/battery.py ~/.config/i3/
cp $BASE_DIR/*.sh ~/.config/i3/
cp $BASE_DIR/.gtkrc-2.0 ~
cp -r $BASE_DIR/.config ~
