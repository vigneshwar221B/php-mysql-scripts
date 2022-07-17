#!/bin/bash

(crontab -l; echo "0 0 * * * ./backup.sh") | sort -u | crontab -
