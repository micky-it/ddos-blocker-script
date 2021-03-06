#!/bin/bash


export LBLUE="\e[1;34m"
export LGREEN="\e[1;32m"
export RED="\e[0;31m"
export Z="\e[0m"

touch /tmp/ddos-blocker-uns.txt

echo -n "Are you sure you want to uninstall this script? [y/n]: "
read VAR
if [[ $VAR = y ]]
then
  var=$(sudo rm -r /usr/local/bin/ddos-blocker >> /tmp/ddos-blocker-uns.txt)
  echo -e "$LBLUE\bUninstalling... $Z"
  sleep 2

  if [[ $? = 0 ]]
  then 
    echo -e "$LGREEN\bThe script was uninstalled successfully $Z"
    exit 0 
  
  else
  echo -e "$RED\bAn error as occured during installation! Check the log in /tmp/ for info $Z"
  exit 1

  fi

elif [[ $VAR = n ]]
then exit 0

else
  echo -e "$RED\bUnknown command '$VAR' $Z"
  exit 1

fi
