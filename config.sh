#!/bin/bash

export DB_DATA_DIR="db_data"

# Configuring database credentials
export DB_HOST="localhost"
export DB_PORT="5432"
export DB_NAME="postgres"
export DB_USER="postgres"
export DB_PASSWORD="postgres"

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
    source .venv/bin/activate && python3 load_swda_data.py
}
    
