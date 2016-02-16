#!/bin/bash
BASE_DIR=`pwd`

sudo apt-get install i3 i3blocks rofi compton lxappearance feh scrot imagemagick arandr xfce4-power-manager thunar git cpanminus libgtk2-perl libgtk3-perl geany gsimplecal galculator
#sudo apt-get purge dunst
mkdir ~/.fonts

cd /tmp

# Fonts

curl -L -o awesome.zip https://fortawesome.github.io/Font-Awesome/assets/font-awesome-4.5.0.zip
curl -L -o sourcecodepro.zip https://github.com/adobe-fonts/source-code-pro/archive/2.010R-ro/1.030R-it.zip
curl -L -o ssf.zip https://github.com/supermarin/YosemiteSanFranciscoFont/archive/master.zip

# i3blocks contrib
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

# Moka icons

sudo add-apt-repository ppa:moka/stable
sudo apt-get update && sudo apt-get install moka-icon-theme

# Ambiance blackout flat theme

sudo add-apt-repository ppa:ravefinity-project/ppa
sudo apt-get update
sudo apt-get install ambiance-blackout-flat-colors

# menutray
cpanm -n Linux::DesktopFiles --sudo
cpanm -n Data::Dump --sudo
git clone --depth 1 https://github.com/trizen/menutray
cd menutray
mv menutray ~/.i3
mkdir ~/.config/menutray
cp schema.pl ~/.config/menutray/

cp $BASE_DIR/config ~/.i3
cp $BASE_DIR/i3blocks.conf ~/.i3
cp $BASE_DIR/i3exit ~/.i3
cp -r $BASE_DIR/scripts/* ~/.i3/scripts
cp $BASE_DIR/.gtkrc-2.0 ~
cp -r $BASE_DIR/.config ~
