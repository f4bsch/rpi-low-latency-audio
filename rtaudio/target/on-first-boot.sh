#!/bin/bash

set -e

sleep 1

echo "" > /dev/tty0
echo "" > /dev/tty0
echo "" > /dev/tty0
echo "Installing RT-Audio (first boot) ..." > /dev/tty0
echo "start in 5 seconds..."  > /dev/tty0
sleep 5

cd /home/rtaudio


if [[ ! -f /usr/bin/create_ap ]]; then
	cd create_ap
	make install > /dev/tty0

	cd ..
fi

systemctl mask create_ap.service # we have our own service


#echo "System update..."  > /dev/tty0
#pacman -Syu --noconfirm &> /dev/tty0
#pacman -S hostapd --noconfirm  &> /dev/tty0


# increse vm writeback!!


echo "Installation successful! Cleaning up..." > /dev/tty0
systemctl disable rtaudio-first-boot.service
echo "Done!"

exit 0
