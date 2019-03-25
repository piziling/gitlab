#!/bin/bash

work_path=$(dirname $(readlink -f "$0"))
parent_path=$(dirname ${work_path})
log_path="${parent_path}/logs/backup.log"

echo -e "\e[1;32m\n\t===> `date` <===\n\e[m" >> "${log_path}"

${work_path}/backup_mail.sh >> ${log_path}

${work_path}/backup_gitlab.sh >> ${log_path}
