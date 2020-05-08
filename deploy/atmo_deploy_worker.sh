#!/bin/bash

# Change IRODS_SYNC_PATH if new db is uploaded on iRODS
# Remember to share db with public first
WORKQUEUE_PASSWORD=
PROJECT_NAME=
CPU_PER_WORKER=8
SEQSERVER_DB_PATH=/var/www/sequenceserver/db
IRODS_SYNC_PATH=/iplant/home/cosimichele/200503_Genomes_n_p

if [ -z $PROJECT_NAME ]; then
    PROJECT_NAME="$ATMO_USER-starBLAST"
fi
if [ -z $WORKQUEUE_PASSWORD ]; then
    WORKQUEUE_PASSWORD="$(echo $PROJECT_NAME | sha1sum | cut -d' ' -f1)"
fi

docker run -d --rm --net=host -e PROJECT_NAME=${PROJECT_NAME} -e WORKQUEUE_PASSWORD=${WORKQUEUE_PASSWORD} -e BLAST_NUM_THREADS=${CPU_PER_WORKER} -e IRODS_SYNC_PATH=${IRODS_SYNC_PATH} -e SEQSERVER_DB_PATH=${SEQSERVER_DB_PATH} zhxu73/sequenceserver-scale-worker
