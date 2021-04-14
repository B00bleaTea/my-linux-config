#!/usr/bin/bash

# sudo command
sud="sudo"
# pick either mv or cp
cm="mv"

echo 'sudo command:' $sud
echo 'action to mv/cp onfigs:' $cm
read -p "correct? [y/N] > " confirm_config

if [ $confirm_config != 'y' ];
then
	echo 'cancelling...'
	exit -1
fi

echo 'making fish functions directory'
mkdir -p ~/.config/fish/functions

echo 'installing fish configs'
$cm fish_prompt.fish ~/.config/fish/functions
$cm fish_variables ~/.config/fish

echo 'adding xinitrc'
$cm i3/_.xinitrc ~/.xinitrc

echo 'removing previous config dirs'
rm -rfv ~/.config/i3
rm -rfv ~/.config/i3blocks
rm -rfv ~/.config/i3status
rm -rfv ~/.config/picom
rm -rfv ~/.config/rofi
rm -rfv ~/.config/scripts
rm -rfv ~/.config/terminator
rm -rfv ~/.config/Thunar

if [ $cm == "mv" ];
then
	echo 'moving configs to the ~/.config folder'
	$cm i3/_.config/* ~/.config
else
	echo 'copying configs to the ~/.config folder'
	$cm -r i3/_.config/* ~/.config
fi

echo 'replacing fish config'
$sud $cm config.fish /etc/fish/config.fish
echo 'replacing lightdm config'
$sud $cm lightdm.conf /etc/lightdm/lightdm.conf
echo 'replacing nano config'
$sub $cm nanorc /etc/nanorc

echo 'replacing the refloctor config'
$sud $cm reflector.conf /etc/xdg/reflector/reflector.conf

echo 'Done!'
