#!/bin/bash

# find distro and package installer
os="";
package_installer="";

os_type () {
  # redhat
  which yum >/dev/null && { os="redhat"; package_installer="yum"; return 0; }
  # debian
  which apt-get >/dev/null && { os="debian"; package_installer="apt"; return 1; }

  return -1; 
}
os_type

#helper functions
error() {
  printf '\E[31m'; echo "$@"; printf '\E[0m'
}

install () {
  echo "installing the lamp stack...";
  #apt upgrades and stuffs
  eval "${package_installer} install -y update"
  eval "${package_installer} -y upgrade"

  #install apache
  eval "${package_installer} install -y apache2"

  #install php and mysql
  eval "${package_installer} install -y php"
  eval "${package_installer} install -y mysql-server"
  eval "${package_installer} install -y php-mysql"
}

start () {
  service apache2 restart
  service mysql restart
}

shut_down () {
  service apache2 stop
  service mysql stop
}

show_status () {
  service apache2 status
  service mysql status
}

get_option () {
  echo "1) Install LAMP stack";
  echo "2) Start the LAMP stack";
  echo "3) Shut down";
  echo "4) Show status";
  echo "5) Exit";

  read option

  return $option
}

execute_option () {
  case $1 in
    1)
      echo "selected 1";
      install
      ;;

    2)
      echo "selected 2";
      start
      ;;

    3)
      echo "selected 3";
      shut_down
      ;;

    4)
      echo "selected 4";
      show_status
      ;;

    5)
      echo "Exiting...";
      option=5
      ;;

    *)
      echo "invalid argument";
      ;;
  esac
}

main() {
  if [[ $EUID -ne 0 ]]; then
    error "You need to run this as the root user"
    exit 1
  fi

  option=-1
  while [ $option -ne 5 ]
  do
    get_option
    option=$?

    execute_option $option
  done
}
main
