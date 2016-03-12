#!/bin/bash
BASE_DIR=`pwd`

# Moka icons

sudo add-apt-repository ppa:moka/stable

# Arc theme
sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/Horst3180/xUbuntu_15.10/ /' >> /etc/apt/sources.list.d/arc-theme.list"
wget http://download.opensuse.org/repositories/home:Horst3180/xUbuntu_15.10/Release.key
sudo apt-key add - < Release.key
sudo apt-get update

sudo apt-get install dunst rofi compton lxappearance feh scrot imagemagick arandr xfce4-power-manager thunar git cpanminus libgtk2-perl libgtk3-perl geany gsimplecal galculator suckless-tools libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev sysstat moka-icon-theme ruby-ronn arc-theme acpi autoconf libxcb-dpms0-dev libpam-dev libcairo-dev dunst libdbus-1-dev libdbus-glib-1-dev gtk+-2.0-dev

sudo apt-get remove notify-osd

# Fix nautilus
gsettings set org.gnome.desktop.background show-desktop-icons false

cd /tmp

# Fonts

curl -L -o awesome.zip https://fortawesome.github.io/Font-Awesome/assets/font-awesome-4.5.0.zip
curl -L -o sourcecodepro.zip https://github.com/adobe-fonts/source-code-pro/archive/2.010R-ro/1.030R-it.zip
curl -L -o ssf.zip https://github.com/supermarin/YosemiteSanFranciscoFont/archive/master.zip

unzip awesome.zip
unzip ssf.zip
unzip sourcecodepro.zip

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

# volnoti
cd /tmp
git clone git://github.com/davidbrazdil/volnoti.git volnoti
cd volnoti/src
rm -rf ./value-client-stub.h && make value-client-stub.h dbus-binding-tool --prefix=volume_object --mode=glib-client specs.xml > value-client-stub.h
rm -rf ./value-daemon-stub.h && make value-daemon-stub.h dbus-binding-tool --prefix=volume_object --mode=glib-server specs.xml > value-daemon-stub.h
./prepare.sh && ./configure --prefix=/usr && make && sudo make install

# Custom i3lock
cd /tmp
git clone https://github.com/Lixxia/i3lock
cd i3lock
make
sudo make install

mkdir -pv ~/.config/i3
mkdir -pv ~/.config/dunst

ln -s $BASE_DIR/config /home/avano/.config/i3/config
ln -s $BASE_DIR/i3blocks.conf /home/avano/.config/i3/i3blocks.conf
ln -s $BASE_DIR/cpu_usage /home/avano/.config/i3/cpu_usage
ln -s $BASE_DIR/battery.sh/home/avano/.config/i3/battery.sh
ln -s $BASE_DIR/date.sh /home/avano/.config/i3/date.sh
ln -s $BASE_DIR/memory.sh /home/avano/.config/i3/memory.sh
ln -s $BASE_DIR/toggle-xkbmap.sh /home/avano/.config/i3/toggle-xkbmap.sh
ln -s $BASE_DIR/volume /home/avano/.config/i3/volume
ln -s $BASE_DIR/volume_control.sh /home/avano/.config/i3/volume_control.sh
ln -s $BASE_DIR/i3lock.sh /home/avano/.config/i3/i3lock.sh
ln -s $BASE_DIR/dunstrc /home/avano/.config/dunst/dunstrc
ln -s $BASE_DIR/conkyrc /home/avano/.config/i3/conkyrc
ln -s $BASE_DIR/i3status.sh /home/avano/.config/i3/i3status.sh
cp $BASE_DIR/.gtkrc-2.0 ~
cp -r $BASE_DIR/.config ~
