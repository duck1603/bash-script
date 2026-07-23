#!/bin/bash

# 1. Hàm lấy thứ trong tuần
get_current_weekday() {
    local dow=$(date +%u)
    case $dow in
        1) echo "thu_2" ;;
        2) echo "thu_3" ;;
        3) echo "thu_4" ;;
        4) echo "thu_5" ;;
        5) echo "thu_6" ;;
        6) echo "thu_7" ;;
        7) echo "chu_nhat" ;;
    esac
}

weekday=$(get_current_weekday)

# 2. Kiểm tra Control Panel và lấy thông tin MySQL
panel="Unknown"
mysql_user=""
mysql_pass=""

if [ -f "/usr/local/cpanel/cpanel" ]; then
    panel="cPanel"
    mysql_user="root"
    if [ -f "/root/.my.cnf" ]; then
        # Sử dụng sed để lấy nội dung bên trong dấu ngoặc kép một cách chính xác
        mysql_pass=$(grep "^password=" /root/.my.cnf | head -1 | sed -E 's/^password="?([^"]+)"?/\1/')
    fi
elif [ -f "/usr/local/directadmin/directadmin" ]; then
    panel="DirectAdmin"
    if [ -f "/usr/local/directadmin/conf/mysql.conf" ]; then
        mysql_user=$(grep "user=" /usr/local/directadmin/conf/mysql.conf | cut -d'=' -f2)
        mysql_pass=$(grep "passwd=" /usr/local/directadmin/conf/mysql.conf | cut -d'=' -f2)
    fi
fi

###### Backup processing ######

db_backup_dir="/root/nfs-backup-hosting/rsync/db/$weekday"
code_backup_dir="/root/nfs-backup-hosting/rsync/code/$weekday"
rm -rf $db_backup_dir/*

######## Backup Database #########
databases=`mysql -u$mysql_user -p$mysql_pass -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema|mysql|performance_schema)"`
for db in $databases; do
        echo "Dumping $db"
        mysqldump --force --no-create-db --opt --user=$mysql_user -p$mysql_pass --databases $db | gzip > "$db_backup_dir/$db.gz"
done

######## Backup Code #########
rsync -ave --progress  --delete /home/ $code_backup_dir