#!/bin/bash

#---------------OpenVPN GUI-----------------
#| Author : Verdi <Developer@NoobCoder_OS> |
#| Version: 1                              |
#| License: GNU GPL                        |
#-------------------------------------------

path="$HOME/.ovpn/"
list=$(ls -1 $path)
logfile="$HOME/vpn.log"

if [ ! -d $path ]
    then
        mkdir $HOME/.ovpn
fi

if [ -f $logfile ]
   then
       rm -rf $logfile
fi

password=$(zenity --password --width=300 --title="Authenticate")

if [ "$password" == "" ]
    then
       	zenity --error --text "Password is Empty!"
	exit
fi

filename=$(zenity --width=400 --height=400 --title "OpenVPN" --list --column Server $list --ok-label Connect --cancel-label Disconnect --extra-button Close --extra-button "More Server" | xargs)

loading()
{
    (
       	echo 10
       	echo "# Setting Up The Connection..."
       	sleep 5

       	echo 30
       	echo "# Contacting The Server..."
       	sleep 5

       	echo 60
       	echo "# Checking Status..."
       	sleep 10

       	echo 100
       	status=$(cat $logfile | grep "Initialization Sequence Completed")
       	if [ "$status" != "" ]
       	    then
       		echo "# Connected Successful!"
       		firefox https://whatismyipaddress.com/ &
       	else
	    failedstatus=$(cat $logfile | grep "incorrect password")
	    if [ "$failedstatus" == "" ]
	       then
	           echo "# Could Not Establish The Connection!"
	    else
		echo "# Connection Failed, Wrong Password!"
	    fi
       	fi
    ) | zenity --width=400 --title "Connecting to VPN Server..." --no-cancel --progress --auto-kill

    rm -rf $logfile
}

execute()
{
    echo $password | sudo -S killall -9 openvpn
    echo $password | sudo -S openvpn --config $path$filename &> $logfile &
}

if [ "$filename" != "" ]
   then
	if [ "$filename" == "Close" ]
   	    then
		exit
	fi

	if [ "$filename" == "More Server" ]
   	    then
		zenity --width=400 --info --text "Visit and download the configuration files from vpngate.net by clicking the 'Download' button. After that, put the configuration files into the OpenVPN configuration folder."
		firefox https://www.vpngate.net &
		thunar $path &
		exit
	fi
	
	execute
	loading
else
    echo $password | sudo -S killall -9 openvpn &> $logfile
    wrongpassword=$(cat $logfile | grep "incorrect password")
    if [ "$wrongpassword" == "" ]
        then
	    zenity --info --text "Disconnect Successful!"
	    rm -rf $logfile
    else
       	zenity --error --text "Disconnect Failed, Wrong Password!"
	rm -rf $logfile
    fi
fi
