#!/bin/bash

main () {
  echo "db backup started..."
  day="$(date +'%A')"
  db_backup="mydb_${day}.sql"
  eval "mysqldump --all-databases -u username -p password > /opt/backups/${db_backup}"
  echo "db backup complete!"
}

main