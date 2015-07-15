#!/usr/bin/env bash

if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root" 1>&2
  exit 1
fi

#create the root user if it does not exist
psql postgres -tAc "SELECT 1 FROM pg_roles WHERE rolname='root'" | grep -q 1 ||\
  createuser -s root

#wipe any existing cyp db and start a new
dropdb cyp
createdb cyp

#install the db extensions we need
psql cyp -c 'CREATE EXTENSION ltree;'

#create the databse
psql cyp -f cypress.sql
