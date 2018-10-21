# Docker cheat sheet

**Create docker machine**
docker-machine create --driver virtualbox name

**List docker machines**
docker-machine ls

**Log into docker machine**
docker-machine ssh name

**Remove docker machine**
docker-machine rm name

**Create swarm manager**
*ssh into manager host then:*
docker swarm init --advertise-addr ip-addr-of-this-machine

**Join swarm**
*ssh into worker host then:*
docker swarm join --token token-from-init-command ip-addr-and-port-of-manager

**Information**
docker info
docker ls
docker ps
docker node ls

**Create service**
docker service create --replicas 1 --name helloworld alpine ping docker.com

**Remove service**
docker service rm name

**Inspect service**
docker service inspect --pretty name

**List services**
docker service ls

**Scale service**
docker service scale name=number-of-instances (e.g. name=5)

**Create service versioned**
docker service create \
  --replicas 3 \
  --name redis \
  --update-delay 10s \
  redis:3.0.6

**Update service**
docker service update --image redis:3.0.7 redis

**Restart paused update**
docker service update redis

**Watch update**
docker service ps <SERVICE-ID>

**Set node drain mode**
docker node update --availability drain worker1

**Check worker availability**
docker node inspect --pretty worker1

**Set node to active mode**
docker node update --availability active worker1


https://docs.docker.com/get-started/part3/

**List stacks or apps**
docker stack ls

**Run the specified Compose file**
docker stack deploy -c <composefile> <appname>

# List running services associated with an app
docker service ls

# List tasks associated with an app
docker service ps <service>

# Inspect task or container
docker inspect <task or container>

# List container IDs
docker container ls -q

# Tear down an application
docker stack rm <appname>

# Take down a single node swarm from the manager
docker swarm leave --force


https://docs.docker.com/get-started/part4/

# Create a VM (Mac, Win7, Linux)
docker-machine create --driver virtualbox myvm1

# Win10
docker-machine create -d hyperv --hyperv-virtual-switch "myswitch" myvm1

# View basic information about your node
docker-machine env myvm1

# List the nodes in your swarm
docker-machine ssh myvm1 "docker node ls"

# Inspect a node
docker-machine ssh myvm1 "docker node inspect <node ID>"

# View join token
docker-machine ssh myvm1 "docker swarm join-token -q worker"

# Open an SSH session with the VM; type "exit" to end
docker-machine ssh myvm1

# View nodes in swarm (while logged on to manager)
docker node ls

# Make the worker leave the swarm
docker-machine ssh myvm2 "docker swarm leave"

# Make master leave, kill swarm
docker-machine ssh myvm1 "docker swarm leave -f"

# list VMs, asterisk shows which VM this shell is talking to
docker-machine ls

# Start a VM that is currently not running
docker-machine start myvm1

# show environment variables and command for myvm1
docker-machine env myvm1

# Mac command to connect shell to myvm1
eval $(docker-machine env myvm1)
& "C:\Program Files\Docker\Docker\Resources\bin\docker-machine.exe" env myvm1 | Invoke-Expression

# Windows command to connect shell to myvm1
docker stack deploy -c <file> <app>

# Deploy an app; command shell must be set to talk to manager (myvm1), uses local Compose file

# Copy file to node's home dir (only required if you use ssh to connect to manager and deploy the app)
docker-machine scp docker-compose.yml myvm1:~

# Deploy an app using ssh (you must have first copied the Compose file to myvm1)
docker-machine ssh myvm1 "docker stack deploy -c <file> <app>"

# Disconnect shell from VMs, use native docker
eval $(docker-machine env -u)

# Stop all running VMs
docker-machine stop $(docker-machine ls -q)

# Delete all VMs and their disk images
docker-machine rm $(docker-machine ls -q)


# Run a docker compose file
docker swarm init
docker stack deploy -c docker-compose.yml micro


