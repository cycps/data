#!/usr/bin/env bash

if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root" 1>&2
  exit 1
fi

#wipe any existing data and start a new
sudo -u postgres dropdb --if-exists cyp
sudo -u postgres dropuser --if-exists root

#create the root user if it does not exist
sudo -u postgres createuser -s root
createdb cyp

#install the db extensions we need
psql cyp -c 'CREATE EXTENSION ltree;'

#create the databse
psql cyp -f /cypress/data/sql/cypress.sql

