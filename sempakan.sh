#!/bin/bash
owner="sempak:sempak"
sempakan="/home/sempak/public_html/"
strip=`hostname > /tmp/data`
sed -i 's/.or.id//g' /tmp/data

  while getopts "b:d:r:h:" options
    do
      case "$options" in
        "b")
          echo "[+] Creating backups user $OPTARG"
          /scripts/pkgaccts $OPTARG
          file="/home/cpmove-$OPTARG.tar.gz"
          echo "[+] Processing to dummy ..."
          chown $owner $file
          chmod 644 $file
          mv $file $sempakan
          echo "[+] Success"
          echo "[+] Do this on your remote server -> gembalah -d $OPTARG `cat /tmp/data`"
          rm -f /tmp/data
          ;;
        "d")
          echo "[+] Download is in progress ..."
          wget --user-aget=DraCoola/1.1 http://$3.dracoola.net/cpmove-$OPTARG.tar.gz -O /home/cpmove-$OPTARG.tar.gz
          echo "[+] The backups sucessfully downloaded at /home/cpmove-$OPTARG.tar.gz"
          echo -n "[?] Do you want to restore the cpmove-$OPTARG.tar.gz? [Y/N] "; read yn
                case $yn in
                        [Yy]* ) /scripts/restorepkg $OPTARG;;
                        [Nn]* ) exit;;
                        * ) echo "Default Answer (YES)"; /scripts/restorepkg $OPTARG;;
                esac
          echo "[+] Restoring account for $OPTARG"
          echo "[+] Complete"
          ;;
        "r")
          /scripts/restorepkg $OPTARG
          ;;
        *)
          echo "DraCoola cPanel Simple Scripts"
          echo " <dewanggaba@xtremenitro.org> "
          echo "Usage: $0 [OPTIONS]"
          echo " "
          echo "Options: "
          echo "        -b <username>           Backup packages"
          echo "        -d <username>           Download packages from another server"
          echo "        -help                   Display this Messages"
          echo "        -r <username>           Restore packages"
          ;;
      esac
    done
