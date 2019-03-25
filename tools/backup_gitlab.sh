#!/bin/bash

work_path=$(dirname $(readlink -f "$0"))
parent_path=$(dirname ${work_path})
backup_log_path="$parent_path/gitlab/backup/backup.data"

gitlab_container_id=$(docker ps | grep "gitlab-ce" | awk '{print $1}')

echo -e "\e[1;32m\n\t\t===> gitlab backup <===\n\e[m"
echo -e "\e[1;32m\n\t\t===> `date` <===\n\e[m" >> "$backup_log_path"

if [[ -n "$gitlab_container_id" ]]
then
	echo -e ">>> begin...\n"
	echo -e ">>> begin...\n" >> "$backup_log_path"
	docker exec "$gitlab_container_id" gitlab-rake gitlab:backup:create >> "$backup_log_path"
	echo -e "\n>>> backup completed!\n" >> "$backup_log_path"
	echo -e "\n>>> backup completed!\n"
	echo -e "\n>>> detail log save in $backup_log_path \n"
else
	echo -e ">>> gitlab container is not running\n" >> "$backup_log_path"
fi
