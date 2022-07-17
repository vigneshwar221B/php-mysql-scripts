#!/bin/bash


if [ "$#" -eq 0 ] ; then 
   echo "no cmd line args are specified. Using the envs" 
  else 
    echo "using cmd line args..."
    username=$1
    password=$2
  fi    
