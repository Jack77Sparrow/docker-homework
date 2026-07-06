#!/bin/bash

SERVER_HOST=${1:-'localhost'}
PORT='2222'

echo "Client starts on: $SERVER_HOST:$PORT"

while true
do
    echo "Sending messages to server"
    echo "hello from client" | nc -w 2 $SERVER_HOST $PORT
    
    if [ $? -ne 0 ]; then
        echo "Server is not responding. Next try in 2 seconds..."
    fi
    
    sleep 2
done
