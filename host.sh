#!/bin/bash

echo $1
repo_url="https://VigneshwarM221b@bitbucket.org/vigneshwarm221b/sample.git"

main () {

  if [[ $EUID -ne 0 ]]; then
    error "You need to run this as the root user"
    exit 1
  fi

  if [ $1 ]; then
      repo_url=$1 
  fi

  DIR="./sample"
  if [ -d "$DIR" ]; then
    echo "project already exists";
  else 
    eval "git clone $repo_url"
  fi

  file1="./sample/test.php"
  file2="/var/www/html/test.php"

  if cmp -s "$file1" "$file2"; then
      printf 'The file "%s" is the same as "%s"\n' "$file1" "$file2"
  else
      printf 'The file "%s" is different from "%s"\n' "$file1" "$file2"
      echo "Do you want to sync? (y/n)";
      read input
      if [[ $input == "y" ]]; then
          cat $file1 > $file2
          echo "modified the file"
      fi
  fi

  echo "do u want crontab to automate the backups? (y/n)"
  read input
  if [[ $input == "y" ]]; then
     ./job.sh
  fi
}
main