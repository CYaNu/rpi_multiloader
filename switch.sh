#!/bin/bash

# backup boot content

echo
echo "                    MultiSystem Switch Tool"
echo
echo "          		Create by CYaNu @ 2018, Under The GPL."
echo "                                            cyanulee@gmail.com "
echo
echo

echo -n "Select System [ 1.Moode Audio 2.RetroPie 3.RaspBian ]: "
read sel

if [[ $sel -ne 1 && $sel -ne 2 && $sel -ne 3 ]]
then
	echo Not Allow Input,Exit and Please Run Again.
	exit 0
fi

echo

checkdir(){
	return `ls -A $1|wc -w`
}

path="/media/cyanu/DATA"
echo Checking Work Path...
cd /media/

if [[ -e "./cyanu/DATA" && -d "./cyanu/DATA" ]]
then
	echo "Exist."
else
	echo "No Exist,Create."
	sudo mkdir -p ./cyanu/DATA
fi

sudo mount /dev/mmcblk0p2 $path

if checkdir $path
then
	echo Mount DATA Partion on TF Failed.Exit.
	exit 0
fi

echo "Using Work Path: "${path}

if [[ -e $path && -d $path ]]
then
	echo Backup Boot Part...
	echo Will Delete Old Backup...

	cd $path
	if [[ -e "./boot_c/backup" && -d "./boot_c/backup" ]]
	then
		sudo rm -rf ./boot_c/backup/*
		sudo cp -r /boot/* ./boot_c/backup
	else
		mkdir -p ./boot_c/backup
		sudo cp -r /boot/* ./boot_c/backup
	fi
else
	echo Request Partion Not Exist. Finish.
	exit 0
fi

echo Backup Completed.
echo

sys=""

case $sel in
	1)
	sys="Moode Audio System"
	echo User Select $sys
	echo "Check Select System Boot Data.Exist or Not."

	if [[ -e "./boot_c/moode" && -d "./boot_c/moode" ]]
	then
		if checkdir "./boot_c/moode"
		then
			echo "Empty Dir,Exit."
			exit 0
		else
			echo "No Empty, Clean Boot Partion."
			sudo rm -rf /boot/*
			sudo cp -r ./boot_c/moode/* /boot/
			echo "Prepare Completed."
		fi
	else
		echo "Not Exist Boot Files.Exit"
		exit 0
	fi
	;;

	2)
	sys="RetroPie Game System"
	echo User Select $sys
	echo "Check Select System Boot Data.Exist or Not."

	if [[ -e "./boot_c/retropie" && -d "./boot_c/retropie" ]]
	then
                if checkdir "./boot_c/retropie"
                then
                        echo "Empty Dir,Exit."
                        exit 0
                else
                        echo "No Empty, Clean Boot Partion."
                        sudo rm -rf /boot/*
                        sudo cp -r ./boot_c/retropie/* /boot/
                        echo "Prepare Completed."
                fi
        else
                echo "Not Exist Boot Files.Exit"
                exit 0
        fi
	;;

	3)
	sys="Raspbian Operation System"
	echo User Select $sys
	echo "Check Select System Boot Data.Exist or Not."

	if [[ -e "./boot_c/rpi" && -d "./boot_c/rpi" ]]
	then
                if checkdir "./boot_c/rpi"
                then
                        echo "Empty Dir,Exit."
                        exit 0
                else
                        echo "No Empty, Clean Boot Partion."
                        sudo rm -rf /boot/*
                        sudo cp -r ./boot_c/rpi/* /boot/
                        echo "Prepare Completed."
                fi
        else
                echo "Not Exist Boot Files.Exit"
                exit 0
        fi
	;;
esac

while true
do
	echo -n "All Done. Reboot? [Y/n]"
	read ans
	case $ans in
		"y")
		sudo reboot
		exit 0
		;;
		"Y")
		sudo reboot
		exit 0
		;;
		"")
		sudo reboot
		exit 0
		;;
		"n")
		exit 0
		;;
	esac
done



