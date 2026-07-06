
# Docker Netcat Client-Server Homework

This repository contains a simple client-server network automation setup using Docker, Alpine Linux, and Netcat.

## Repository Structure
* `Dockerfile.server` & `Dockerfile.client` — Environment configurations.
* `server.sh` — Server script running `nc` loop.
* `client.sh` — Client script sending periodic messages.

---

## 1. Build Images
Run these commands from the root directory to build the Docker images:
```bash
sudo docker image build -f Dockerfile.server -t alpine-server-img .
sudo docker image build -f Dockerfile.client -t alpine-client-img .
```
## 2. Create Network

Create a custom bridge network to enable internal DNS resolution between containers:
Bash

```bash
sudo docker network create my_test_network
```
## 3. Run Containers

Start the server container first, then start the client (passing the server's container name as an argument):

```
bash
sudo docker container run -d --name my_server --network my_test_network -v "$(pwd)/server.sh:/app/server.sh" alpine-server-img
sudo docker container run -d --name my_client --network my_test_network -v "$(pwd)/client.sh:/app/client.sh" alpine-client-img bash /app/client.sh my_server
```
## 4. Verify Connectivity

Test the network connection between containers using Docker DNS (by container name):

### Ping server from client
```bash
sudo docker container exec -it my_client ping -c 4 my_server
```
### Ping client from server
```bash
sudo docker container exec -it my_server ping -c 4 my_client
```
## 5. Verify Netcat Scripts

Check the logs to ensure the client is successfully broadcasting and the server is receiving the payload:

### Check client logs for sent messages
```bash
sudo docker container logs my_client
```
### Check server logs for received data
```bash
sudo docker container logs my_server
```
