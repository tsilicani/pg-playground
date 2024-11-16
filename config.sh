#!/bin/bash

export DB_DATA_DIR="db_data"

# Configuring database credentials
export DB_HOST="localhost"
export DB_PORT="5432"
export DB_NAME="postgres"
export DB_USER="postgres"
export DB_PASSWORD="postgres"

# Usage: shmig [options] <action> [arguments...]

# Actions are:
#   create <name>
#       create migration file in MIGRATIONS directory

#   migrate|up [steps=COUNT] [[till=]TILL]
#       apply pending COUNT or till (and including) TILL migrations or all
#       unless TILL or COUNT given

#   down [steps=COUNT] [[till=]TILL]
#       rollback migrations till (and including) given version or
#       COUNT migrations (if given)

#   rollback [COUNT]
#       revert COUNT last migrations

#   redo [steps=COUNT] [[till]=TILL]
#       rolls back COUNT or TILL (and including) migration or all if not given
#       and then applies them again

#   pending
#       show migrations that are not applied

#   status
#       show which migrations were applied and at which time in UTC

install_shmig() {
    echo "⚠️ This command must be executed from superuser"
    rm -rf shmig
    git clone https://github.com/mbucc/shmig.git
    cd shmig
    make install
    mkdir -p $SHMIG_MIGRATIONS_DIR
    rm -rf shmig
}

reset_stack() {
    docker compose down
    rm -rf $DB_DATA_DIR
    docker compose up -d
    sleep 5
    shmig migrate
}
