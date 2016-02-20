#!/bin/bash
BASE_DIR=`pwd`

# Moka icons

sudo add-apt-repository ppa:moka/stable

# Ambiance blackout flat theme
sudo add-apt-repository ppa:ravefinity-project/ppa
sudo apt-get update

#Install i3 and i3blocks from https://github.com/Airblader/i3blocks-gaps https://github.com/Airblader/i3

sudo apt-get install rofi compton lxappearance feh scrot imagemagick arandr xfce4-power-manager thunar git cpanminus libgtk2-perl libgtk3-perl geany gsimplecal galculator suckless-tools libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev sysstat moka-icon-theme ambiance-blackout-flat-colors ruby-ronn
#sudo apt-get purge dunst
mkdir ~/.fonts

cd /tmp

# Fonts

curl -L -o awesome.zip https://fortawesome.github.io/Font-Awesome/assets/font-awesome-4.5.0.zip
curl -L -o sourcecodepro.zip https://github.com/adobe-fonts/source-code-pro/archive/2.010R-ro/1.030R-it.zip
curl -L -o ssf.zip https://github.com/supermarin/YosemiteSanFranciscoFont/archive/master.zip

# i3blocks contrib necessary?
curl -L -o i3blockscontrib.zip https://github.com/vivien/i3blocks-contrib/archive/master.zip

mkdir -p ~/.i3/scripts

unzip awesome.zip
unzip ssf.zip
unzip sourcecodepro.zip
unzip i3blockscontrib.zip 
mv  i3blocks-contrib-master/* ~/.i3/scripts

mv /tmp/font-awesome-4.5.0/fonts/fontawesome-webfont.ttf ~/.fonts
mv /tmp/YosemiteSanFranciscoFont-master/*.ttf ~/.fonts
mv /tmp/source-code-pro-2.010R-ro-1.030R-it/TTF/*.ttf ~/.fonts

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

# menutray
cpanm -n Linux::DesktopFiles --sudo
cpanm -n Data::Dump --sudo
git clone --depth 1 https://github.com/trizen/menutray
cd menutray
mv menutray ~/.i3
mkdir ~/.config/menutray
cp schema.pl ~/.config/menutray/

mkdir ~/.config/i3
cp $BASE_DIR/config ~/.config/i3/
cp $BASE_DIR/i3blocks.conf ~/.config/i3/
cp $BASE_DIR/i3exit ~/.config/i3/
cp -r $BASE_DIR/scripts/* ~/.i3/scripts
cp $BASE_DIR/.gtkrc-2.0 ~
cp -r $BASE_DIR/.config ~
