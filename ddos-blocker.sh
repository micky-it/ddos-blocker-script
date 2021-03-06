#!/bin/bash


export RED="\e[0;31m"
export LRED="\e[1;31m"
export Z="\e[0m"
export LGRAY="\e[0;37m"
export LGREEN="\e[1;32m"
export LBLUE="\e[1;34m"

 echo -e "$RED                
                                            *********************************************
                                           <+                                           +>
                                           <+         Ip blocking tool/DDos block       +>
                                           <+                                           +>
                                           <+         Use with extreme caution          +>
                                           <+                                           +>
                                            ********************************************* $Z"



if [[ $(whoami) = root ]]
then
  sudo tcpdump -U -n --immediate-mode icmp and icmp[icmptype]=icmp-echo > /var/log/badip.txt &
  sleep 5
  pid=$(ps -e | pgrep tcpdump)
  sleep 5 
  kill $pid
  prebadip=$(sudo awk '{ print $3 }' /var/log/badip.txt | sort -u)
  vbadip=$(sudo echo "$prebadip" > /var/log/badip.txt)
  badip=$(echo $prebadip)

  echo -e "$LRED\bPossible bad ip found (PING). The ip/s are saved in /var/log/badip.txt:$Z
  $LGRAY\b$prebadip$Z"

  echo -n "Please Select an action [blockall/blockip/unblockip/exit]: " 
  read VAR 
  if [[ $VAR = blockall ]]
  then
    sudo route add $badip gw 127.0.0.1 lo
    echo -n -e "$LGREEN\bBlocked/s!$Z Do you want this ip(s) to remain locked even after reboot?[y/n]: "
    read VAR2
      if [[ $VAR2 = y ]]
      then  
        sudo echo "sudo route add $badip gw 127.0.0.1 lo" >> /etc/rc.local
        echo -e "$LGREEN\bDone! $Z"

      elif [[ $VAR2 = n ]]
      then 
        echo -e "$LBLUE\bThe ip(s) are only blocked for this session $Z"
        exit 0

      else
        echo -e "$RED\bUnknown command $Z"
        exit 1

      fi

  elif [[ $VAR = blockip ]]
  then
    echo -n "Please enter the ip to block: "
    read VAR3
    echo -n -e "$LGREEN\bBlocked/s!$Z Do you want this/these ip(s) to remain blocked even after reboot?[y/n]: "
    read VAR6
    if [[ $VAR6 = y ]]
    then  
      sudo echo "sudo route add $VAR3 gw 127.0.0.1 lo" >> /etc/rc.local
      var3=$(sudo route add $VAR3 gw 127.0.0.1 lo)
      if [[ $? = 0 ]]
      then
        echo -e "$LGREEN\bDone! $Z"
        exit 0

      else
        echo -e "$LRED\bAn error as occurred! $Z"
        exit 1

      fi

    elif [[ $VAR6 = n ]]
    then 
      var3=$(sudo route add $VAR3 gw 127.0.0.1 lo)
      if [[ $? = 0 ]]
      then
        echo -e "$LBLUE\bThe ip(s) are only blocked for this session $Z"
        exit 0

      else
        echo -e "$LRED\bAn error as occurred! $Z"
        exit 1

      fi

    else
      echo -e "$RED\bUnknown command $Z"
      exit 1

    fi
    
  
  
  elif [[ $VAR = unblockip ]]
  then 
    echo -n "Enter the ip to unlock: "
    read VAR4
    echo -e -n "Unblock a locked ip even after reboot?[y/n]: "
    read VAR5
    if [[ $VAR5 = y ]]
    then 
      sudo sed -i "s/sudo route add $VAR4 gw 127.0.0.1 lo//g" /etc/rc.local
      var=$(sudo route delete $VAR4)
      if [[ $? = 0 ]]
      then
        echo -e "$LGREEN\bDone! $Z"
        exit 0
      
      else 
        echo -e "$LRED\bAn error as occurred! $Z"
        exit 1
      fi
    elif [[ $VAR5 = n ]]
    then
      var2=$(sudo route delete $VAR4)
      if [[ $? = 0 ]]
      then
        echo -e "$LGREEN\bDone! $Z"
        exit 0
    
      else
        echo -e "$LRED\bAn error as occurred! $Z"
        exit 1
    
      fi
    
    

    else
    echo -e "$LRED\bUnknown command $Z"
    exit 1
    
    fi

  elif [[ $VAR = exit ]]
  then
    exit 0

  else
    echo -e "$LRED\bUnknown command $Z"
    exit 1
    
    
  fi



else
  echo -e "$LRED\bPlease execute this script with root permission! $Z"
  exit 1

fi



