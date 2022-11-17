clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}             • BACKUP PANEL MENU •             ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC}  [INFO] Create password for database"
read -rp "   [INFO] Enter password : " -e InputPass
sleep 1
if [[ -z $InputPass ]]; then
exit 0
fi
echo -e "$COLOR1│${NC}  [INFO] Processing... "
mkdir -p /root/backup
sleep 1

cp -r /root/.acme.sh /root/backup/ &> /dev/null
cp /etc/passwd /root/backup/ &> /dev/null
cp /etc/group /root/backup/ &> /dev/null
cp /etc/shadow /root/backup/ &> /dev/null
cp /etc/gshadow /root/backup/ &> /dev/null
cp /etc/ppp/chap-secrets /root/backup/chap-secrets &> /dev/null
cp /etc/ipsec.d/passwd /root/backup/passwd1 &> /dev/null
cp -r /var/lib/ssnvpn-pro/ /root/backup/ssnvpn-pro &> /dev/null
cp -r /etc/xray /root/backup/xray &> /dev/null
cp -r /home/vps/public_html /root/backup/public_html &> /dev/null
cp -r /etc/cron.d /root/backup/cron.d &> /dev/null
cp /etc/crontab /root/backup/crontab &> /dev/null
cd /root
zip -rP $InputPass $NameUser.zip backup > /dev/null 2>&1

##############++++++++++++++++++++++++#############
LLatest=`date`
Get_Data () {
git clone https://github.com/SSHSEDANG4/backupuserssn.git /root/user-backup/ &> /dev/null
}

Mkdir_Data () {
mkdir -p /root/user-backup/$NameUser
}

Input_Data_Append () {
if [ ! -f "/root/user-backup/$NameUser/$NameUser-last-backup" ]; then
touch /root/user-backup/$NameUser/$NameUser-last-backup
fi
echo -e "User         : $NameUser
last-backup : $LLatest
" >> /root/user-backup/$NameUser/$NameUser-last-backup
mv /root/$NameUser.zip /root/user-backup/$NameUser/
}

Save_And_Exit () {
    DATE=$(date +'%d %B %Y')
    cd /root/user-backup
    git config --global user.email "sshsedang@gmail.com" &> /dev/null
    git config --global user.name "SSHSEDANG4" &> /dev/null
    rm -rf .git &> /dev/null
    git init &> /dev/null
    git add . &> /dev/null
    git commit -m backup &> /dev/null
    git branch -M main &> /dev/null
    git remote add origin https://github.com/SSHSEDANG4/backupuserssn
    git push -f https://$itoken@github.com/SSHSEDANG4/backupuserssn.git &> /dev/null
}

if [ ! -d "/root/user-backup/" ]; then
sleep 1
echo -e "$COLOR1│${NC}  [INFO] Getting database... "
Get_Data
Mkdir_Data
sleep 1
echo -e "$COLOR1│${NC}  [INFO] Getting info server... "
Input_Data_Append
sleep 1
echo -e "$COLOR1│${NC}  [INFO] Processing updating server...... "
Save_And_Exit
fi
link="https://raw.githubusercontent.com/SSHSEDANG4/backupuserssn/main/$NameUser/$NameUser.zip"
sleep 1
echo -e "$COLOR1│${NC}  [INFO] Backup done "
sleep 1
echo
sleep 1
echo -e "$COLOR1│${NC}  [INFO] Generete Link Backup "
echo -e "$COLOR1│${NC}"
sleep 2
echo -e "$COLOR1│${NC}  The following is a link to your vps data backup file.
$COLOR1│${NC}  Your VPS IP $IP
$COLOR1│${NC}
$COLOR1│${NC}  $link
$COLOR1│${NC}  save the link pliss!
$COLOR1│${NC}
$COLOR1│${NC}  If you want to restore data, please enter the link above.
$COLOR1│${NC}  Thank You For Using Our Services"
cd
rm -rf /root/backup &> /dev/null
rm -rf /root/user-backup &> /dev/null
rm -f /root/$NameUser.zip &> /dev/null
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$COLOR1│${NC}              • WWW.YASANATA.NINJA •                $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" 
echo
read -n 1 -s -r -p "   Press any key to back on menu"
menu-backup
