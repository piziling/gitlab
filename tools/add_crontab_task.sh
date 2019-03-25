#!/bin/bash

work_path=$(dirname $(readlink -f "$0"))

sh_path="$work_path/auto_backup.sh"

cmd="0 2 * * * /bin/bash $sh_path"

find_task_line=$(crontab -l | grep "$sh_path" | wc -l)

if [[ ${find_task_line} -eq 0 ]]
then
	echo -e "\n>>> add task to crontab\n"
	echo "$cmd" >> /var/spool/cron/crontabs/root && echo -e "$cmd \n\n>>> ok\n"
else
	echo -e "\n>>> crontab task already exists\n"
fi

