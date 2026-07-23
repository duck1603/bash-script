#!/bin/bash

########################################
# DirectAdmin MySQL Backup Script
########################################

MYSQL_CNF="/usr/local/directadmin/conf/my.cnf"

BACKUP_ROOT="/backup/mysql"
LOG_FILE="/var/log/mysql_backup.log"

KEEP=3
DATE=$(date +"%F")

LOCK_FILE="/var/run/mysql_backup.lock"

########################################
# Prevent duplicate running
########################################

if [ -f "$LOCK_FILE" ]; then
    PID=$(cat "$LOCK_FILE")

    if ps -p "$PID" >/dev/null 2>&1; then
        echo "Backup already running (PID: $PID)"
        exit 1
    fi
fi

echo $$ > "$LOCK_FILE"

trap "rm -f $LOCK_FILE" EXIT

########################################

mkdir -p "$BACKUP_ROOT"

echo "========== $(date) ==========" >> "$LOG_FILE"

########################################
# Test MySQL Connection
########################################

mysql \
--defaults-extra-file="$MYSQL_CNF" \
-e "SELECT 1;" >/dev/null 2>&1

if [ $? -ne 0 ]; then
    echo "$(date) Cannot connect MySQL." >> "$LOG_FILE"
    exit 1
fi

########################################
# Get databases
########################################

DATABASES=$(
mysql \
--defaults-extra-file="$MYSQL_CNF" \
-N \
-e "SHOW DATABASES;"
)

########################################
# Backup
########################################

for USER in $(ls /usr/local/directadmin/data/users)
do

    USER_DIR="$BACKUP_ROOT/$USER"

    mkdir -p "$USER_DIR"

    USER_DBS=$(echo "$DATABASES" | grep "^${USER}_")

    if [ -z "$USER_DBS" ]; then

        echo "[$USER] No database." >> "$LOG_FILE"

        continue

    fi

    for DB in $USER_DBS
    do

        FILE="$USER_DIR/${DB}_${DATE}.sql.gz"

        echo "Backup $DB..." >> "$LOG_FILE"

        mysqldump \
        --defaults-extra-file="$MYSQL_CNF" \
        --single-transaction \
        --quick \
        --routines \
        --events \
        --triggers \
        --default-character-set=utf8mb4 \
        "$DB" | gzip > "$FILE"

        if [ ${PIPESTATUS[0]} -eq 0 ]; then

            echo "[SUCCESS] $DB" >> "$LOG_FILE"

            ls -1t "$USER_DIR/${DB}_"*.sql.gz 2>/dev/null \
            | tail -n +$(($KEEP + 1)) \
            | xargs -r rm -f

        else

            echo "[FAILED] $DB" >> "$LOG_FILE"

            rm -f "$FILE"

        fi

    done

done

echo "Finished : $(date)" >> "$LOG_FILE"
echo "" >> "$LOG_FILE"
