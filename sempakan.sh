#!/bin/bash
# Gembalah cPanel Scripts - HOW TO
# v0.2
# /-------------------------------------------------------/
# 
# Backup cpanel account
# $ gembalah -b <username/domain> 
#
# Download and restore cpanel account from remote server
# $ gembalah -d <username> <server>
# 
# Restore cpanel account
# $ gembalah -r <username>
# /-------------------------------------------------------/

# Configure your requirements here
owner="sempak:sempak"
sempakan="/home/sempak/public_html/"
strip=`hostname | sed "s/.in-hell.com//"`

# Progress animation
a=1
sp="/-\|"
echo -n ' '
while true
do
    printf "\b${sp:a++%${#sp}:1}"
done

  while getopts "b:d:r:h:" options
    do
      case "$options" in
        "b")
          domain=`grep $OPTARG /etc/trueuserdomains | awk {'print $1'} | cut -d':' -f1`
          acc=`grep $OPTARG /etc/trueuserdomains | awk {'print $2'}`
          if [ "$OPTARG" == "$acc" ]; then
                echo "[+] Creating full backups user $OPTARG"
                /scripts/pkgacct $OPTARG > /dev/null
                  file="/home/cpmove-$OPTARG.tar.gz"
                  echo "[+] Backups created on $file"
          echo "[+] Processing to dummy ..."
          chown $owner $file > /dev/null
          chmod 644 $file > /dev/null
          mv $file $sempakan > /dev/null
          echo "[+] Success! http://$strip.dracoola.net/cpmove-$OPTARG.tar.gz"
          echo "[+] Do this on your remote server -> $0 -d $OPTARG $strip"
          elif [ "$OPTARG" == "$domain" ]; then
                echo "[+] Creating full backups domain $OPTARG"
                /scripts/pkgacct $acc > /dev/null
                  domfile="/home/cpmove-$acc.tar.gz"
                  echo "[+] Backups created on $domfile"
          echo "[+] Processing to dummy ..."
          chown $owner $domfile > /dev/null
          chmod 644 $domfile > /dev/null
          mv $domfile $sempakan > /dev/null
          echo "[+] Success! http://$strip.dracoola.net/cpmove-$acc.tar.gz"
          echo "[+] Do this on your remote server -> $0 -d $acc $strip"
          else
              	echo "domain or account not exist, please check!"
                exit 0
	  fi
          ;;
        "d")
          echo "[+] Download is in progress ..."
          wget -q -nv --user-agent=DraCoola/1.1 http://$3.dracoola.net/cpmove-$OPTARG.tar.gz -O /home/cpmove-$OPTARG.tar.gz
          echo "[+] The backups sucessfully downloaded at /home/cpmove-$OPTARG.tar.gz with `ls -lah /home/cpmove-$OPTARG.tar.gz | awk '{print $5}'`bytes"
          echo -n "[?] Do you want to restore the cpmove-$OPTARG.tar.gz? [Y/n] "; read yn
                case $yn in
                        [Yy]* ) echo "[+] Restoring account for $OPTARG is in progress ..."; /scripts/restorepkg $OPTARG > /dev/null; echo "[+] Restore account for $OPTARG complete!";;
                        [Nn]* ) echo "[!] Complete without restoring data"; exit;;
                        * ) echo "Default Answer (YES)"; /scripts/restorepkg $OPTARG > /dev/null;;
                esac
          ;;
        "r")
		  echo -n "[?] Do you want to restore the $OPTARG? [Y/n] "; read $yn
				case $yn in
						[Yy]* ) /scripts/restorepkg $OPTARG > /dev/null;;
						[Nn]* ) exit;;
						* ) echo "Default Answer (YES)"; /scripts/restorepkg $OPTARG > /dev/null;;
				esac
		  echo "[+] Restore complete"
          ;;
        *)
          echo "DraCoola cPanel Simple Scripts"
          echo "<dewanggaba@xtremenitro.org>"
          echo "Usage: $0 [OPTIONS]"
          echo " "
          echo "Options: "
          echo "        -b <username/domain>        Backup packages"
          echo "        -d <username> <servername>  Download packages from another server"
          echo "        -help                       Display this Messages"
          echo "        -r <username>               Restore packages"
          ;;
      esac
    done
