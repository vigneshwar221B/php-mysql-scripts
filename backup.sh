#!/bin/bash

main () {
  echo "db backup started..."

  echo $1
  echo $2

  day="$(date +'%A')"
  db_backup="MyBackup_${day}.sql"

  username=""
  password=""

  # read from envs
  if [[ -z "${mysql_uname}" ]]; then
   username="default" 
  else
   username="${mysql_uname}"
  fi

  if [[ -z "${password}" ]]; then
   password="default" 
  else
   password="${password}"
  fi

  # read from cmd line args
  if [ "$#" -eq 0 ] ; then 
   echo "no cmd line args are not specified. Using the envs" 
  else 
    echo "using cmd line args..."
    username=$1
    password=$2
  fi    

  eval "mysqldump --all-databases -u $username -p $password > /opt/backups/${db_backup}"
  echo "db backup complete!"
}

main $1 $2