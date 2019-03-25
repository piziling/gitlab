#!/bin/bash

work_path=$(dirname $(readlink -f "$0"))
parent_path=$(dirname ${work_path})
source_path="$parent_path/mail/poste/data"
backup_path="$parent_path/mail/poste/backup"
backup_temp_path="$parent_path/mail/poste/backup/db"
backup_log_path="$backup_path/backup.data"

backup_name=`date '+20%y_%m_%d_%s_poste_backup'`

echo -e "\e[1;32m\n\t\t===> mail backup <===\n\e[m"
echo -e "\e[1;32m\n\t\t===> `date` <===\n\e[m" >> "$backup_log_path"

echo -e ">>> begin...\n"
echo -e ">>> begin...\n" >> "$backup_log_path"

if [[ -d ${backup_temp_path} ]]
then
    rm -rf ${backup_temp_path}
fi

mkdir ${backup_temp_path}

cp ${source_path}/users.db ${backup_temp_path}
cp -r ${source_path}/domains ${backup_temp_path}

tar -zcf ${backup_path}/${backup_name}.tar.gz -C ${backup_temp_path} . && echo -e "\n>>> saved as file : ${backup_name}.tar.gz\n" >> "$backup_log_path"

rm -rf ${backup_temp_path}

echo -e "\n>>> backup completed!\n" >> "$backup_log_path"
echo -e "\n>>> saved as file : ${backup_name}.tar.gz\n"
echo -e "\n>>> backup completed!\n"
echo -e "\n>>> detail log save in $backup_log_path \n"
