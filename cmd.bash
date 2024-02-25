#!/bin/bash

# Start the first process
mongod > /dev/null &
mongo_id=$!
# Start the second process
/home/server &
server_id=$!

cleanup() {
    kill $mongo_id
    echo "bye $mongo_id"
    kill $server_id
    echo "bye $server_id"
    echo "bye bruh"
    exit 0
}


trap 'cleanup' SIGINT

# Wait for any process to exit
wait -n

# Exit with status of process that exited first
exit $?