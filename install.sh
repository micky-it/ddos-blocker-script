#!/bin/bash

export LBLUE="\e[1;34m"
export LGREEN="\e[1;32m"
export RED="\e[0;31m"
export Z="\e[0m"

touch /tmp/ssh-mini-tool-ins.txt

echo -n "Are you sure you want to install this script? [y/n]: "
read VAR
if [[ $VAR = y ]]
then
  echo -e "$LBLUE\bInstalling... $Z"
  sleep 2
  var=$(sudo cp ddos-blocker /usr/local/bin >> /tmp/ddos-blocker-ins.txt)
  
  if [[ $? = 0 ]]
  then 
    echo -e "$LGREEN\bInstallation completed successfully! Now type ddos-blocker for use the script. $Z"
    exit 0

  else
    echo -e "$RED\bAn error as occured during installation! Check the log in /tmp/ for info $Z"
    exit 1

  fi

elif [[ $VAR = n ]]
then 
  exit 0

else
  echo -e "$RED\bUnknown command '$VAR' $Z"
  exit 1

fi