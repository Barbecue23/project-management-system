#!/bin/bash
set -e

psql -U postgres <<EOSQL
  CREATE DATABASE pg_poc_production_cache;
  CREATE DATABASE pg_poc_production_queue;
  CREATE DATABASE pg_poc_production_cable;
EOSQL
