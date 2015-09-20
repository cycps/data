#!/usr/bin/env bash

#if [[ $EUID -ne 0 ]]; then
#  echo "This script must be run as root" 1>&2
#  exit 1
#fi

#wipe any existing data and start a new
dropdb --if-exists cyp
dropuser --if-exists root

#create the root user if it does not exist
createuser -s root
createdb cyp

#install the db extensions we need
psql cyp -c 'CREATE EXTENSION ltree;'
psql cyp -c 'CREATE EXTENSION pgcrypto;'

#create the databse
psql cyp -f /cypress/cypress.sql

