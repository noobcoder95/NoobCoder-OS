#!/bin/bash

clear

echo "\
-----------------ZRAM NOOB-----------------
| Author : Verdi <Developer@NoobCoder_OS> |
| Version: 1                              |
| License: GNU GPL                        |
-------------------------------------------
"

if [[ $(id -u) -ne 0 ]];
    then
        echo "Please run as root" ;
	exit 1
fi
	
if [ -f /etc/init/zram-init.conf ]
    then
	sudo rm /etc/init/zram-init.conf
fi

sudo apt-get autoremove --purge zram-config

sudo echo "\
description    "ZRAM Swap Initialization"
author         "Verdi \<Developer@NoobCoder_OS\>"

pre-start exec /usr/bin/init-zram-swapping

pre-stop exec /usr/bin/end-zram-swapping
">/etc/init/zram-init.conf

if [ -f /lib/systemd/system/zram-swap.service ]
    then
	sudo rm /lib/systemd/system/zram-swap.service
fi

sudo echo "\
[Unit]
Description=ZRAM Swap Service

[Service]
ExecStart=/usr/bin/zram-enable
ExecStop=/usr/bin/zram-disable
Type=oneshot
RemainAfterExit=true

[Install]
WantedBy=multi-user.target
">/lib/systemd/system/zram-swap.service

if [ -f /usr/bin/zram-enable ]
    then
	sudo rm /usr/bin/zram-enable
fi

sudo echo "\
#! /bin/sh

NRDEVICES=\$(grep -c ^processor /proc/cpuinfo | sed 's/^0$/1/')
if modinfo zram | grep -q ' zram_num_devices:' 2>/dev/null;
    then
        MODPROBE_ARGS=\"zram_num_devices=\${NRDEVICES}\"
elif modinfo zram | grep -q ' num_devices:' 2>/dev/null;
    then
        MODPROBE_ARGS=\"num_devices=\${NRDEVICES}\"
else
    exit 1
fi

modprobe zram \$MODPROBE_ARGS
totalmem=\`LC_ALL=C free | grep -e \"^Mem:\" | sed -e 's/^Mem: *//' -e 's/  *.*//'\`

mem=\$((totalmem * 1024))
                         
for i in \$(seq \${NRDEVICES});
    do
        DEVNUMBER=\$((i - 1))
echo \$mem > /sys/block/zram\${DEVNUMBER}/disksize
mkswap /dev/zram\${DEVNUMBER}
swapon -p 5 /dev/zram\${DEVNUMBER}

done
">/usr/bin/zram-enable

sudo chmod +x /usr/bin/zram-enable

if [ -f /usr/bin/zram-disable ]
    then
	sudo rm /usr/bin/zram-disable
fi

sudo echo "\
#! /bin/sh

if DEVICES=\$(grep zram /proc/swaps | awk '{print \$1}');
    then
        for i in \$DEVICES;
            do

swapoff \$i

done

fi
rmmod zram
">/usr/bin/zram-disable

sudo chmod +x /usr/bin/zram-disable

sudo systemctl disable zram-swap && sudo systemctl enable zram-swap && sudo systemctl start zram-swap

echo "\

*** ZRAM Configuration Done! ***

NOTE: Disable ZRAM with \"sudo systemctl disable zram-swap\"
      Enable  ZRAM with \"sudo systemctl enable zram-swap\"
      Start   ZRAM with \"sudo systemctl start zram-swap\"
      Stop    ZRAM with \"sudo systemctl stop zram-swap\"

"

