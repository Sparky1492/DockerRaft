#!/bin/bash
# inspired by wiki.opensourceisawesome.com[https://wiki.opensourceisawesome.com/books/backing-up-docker/page/backup-docker-data-and-configs]
# goal is to create a script to allow anyone to archive their docker files/setup with minimal editing needed.

### Function - if cli arguments exist move on, else check .env file exsits use, if not throw error ###
. .env #if .env file exsites, pull variables from it
# ? source .env


# Get today's date for our archive filename
archiveDate=$(date +'%Y.%m.%d_%H%M')

#use .env file if no arguments provided

docker_files="/path/to/docker-files/folder"
#possibly need additional option for programs like portainer if configured to store data in different directory on host.
combining_folder="/path/to/combining/folder"  # probally /tmp
docker_archives="/path/to/docker-archives/folder"
clean_local_docker_archives_folder="" #true|false|# for keeping local # of archives
clean_remote_docker_archives_folder="" #true|false|# for keeping local # of archives

function cleaning_local {
    if $clean_local_docker_archives_folder == true
        $clean_local_docker_archives_folder = /tmp
    else $clean_local_docker_archives_folder == false
        $clean_local_docker_archives_folder = .env || cli argument
    else $clean_local_docker_archives_folder == #
        $clean_local_docker_archives_folder = .env || cli argument
        find (.env || cli argument)/* -mtime +5 -exec rm {} \; #remove files older than 5 days
    fi
}

function cleaning_remote {
    if $clean_remote_docker_archives_folder == true
        $clean_remote_docker_archives_folder = /tmp
    else $clean_remote_docker_archives_folder == false
        $clean_remote_docker_archives_folder = .env || cli argument
    else $clean_remote_docker_archives_folder == #
        $clean_remote_docker_archives_folder = .env || cli argument
        find (.env || cli argument)/* -mtime +5 -exec rm {} \; #remove files older than 5 days
    fi
}

for folder in $'docker-files': do
    docker-compose stop ./folder
    echo "$folder stopped"
    tar -czvf folder_$archiveDate.tar.gz $combining_folder
    echo "$folder tarred"
    docker-compose start ./folder
    echo "$folder restarted"

cd $combining_folder
echo "tarring all $docker_files"
tar -czvf * 'docker-files-archive_$archiveDate.tar.gz' '$docker-archives'
echo "tarred files to 'docker-files-archive_$archiveDate.tar.gz' to '$docker-archives'"

echo "Now to moving, yes moving again. get your friends and their pickup trucks...."
cd $docker_archives

### Back-up location function  ###
#scp option
scp $docker_archives/docker-files-archive_$archiveDate /mnt/data #need variable for remote folder 

#rsync local option
rsync -a -P $docker_archives

#rsync remote option
rsync -a -P $docker_archives $remote_user@$remote_host:/mnt/data

#clean-up remote folder
cleaning_remote{}


### Back-up location function  ###





#process for deleting uploaded/moved archive tars| keeping all | keeping # archives locally
$clean_local_docker_archives_folder


#Check Exit status
$?=