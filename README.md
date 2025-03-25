# DockerRaft
## Your docker life saving device

As of 2025-03-11, the goal is to have an easy to use script, well documented, to provide the beginner homelaber, Docker novice user, or Docker power users, to archive their compose configurations files and container data.

The plan is to have the option to have local archive directory and/or also offer remote archive directory via SSH, RSYNC, etc(possibly).  Also an option to limit the number of archives in the archive folder/s




### Arguments

Using a .env file in the same folder with the main.sh, does not require any arguments, unless you want it to override your variables set in the .env.


| ARG                  | Description             | .env ENV variable           | Default |
|----------------------|----------------------|-------------------|---------|
| -dF (Example)      | Docker file directory           | /home/user/docker/compose                  |         |