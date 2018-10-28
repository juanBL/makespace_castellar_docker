<p align="center">
<img src="http://ddf912383141a8d7bbe4-e053e711fc85de3290f121ef0f0e3a1f.r87.cf1.rackcdn.com/DevOps-automation-service_logo.png" width="30%" height="30%">
</p>

<hr>

# Local development environment

We use Docker in order to be able to develop in a local environment. We've chosen it because it's the only tool that allows to build an environment with different PHP versions without consuming too much resources.

# Table of Contents

1. [Getting started](#getting-started)
2. [Troubleshooting](#troubleshooting)
3. [Setting up sites](#setting-up-sites)
4. [Development Infrastructure Graph](#development-infrastructure-graph)

## Getting started
* Clone this repo `git clone git@github.com:juanBL/makespace_castellar_docker.git devops/`
* Install [Docker](https://www.docker.com/community-edition). Note for MacOS: Do not be confused with the deprecated "Docker toolbox" package. It was a previous approach with less performance than the "Docker for Mac".
* Start your "Docker" app
* Move to the docker directory: `cd devops/docker`
* Copy the `volume_mappings.yml.dist` to `volume_mappings.yml` and replace the `%YOUR_PROJECTS_PATH%` string with your own path
* Create the mapped folders in case you don't already have them (for instance: `mkdir %YOUR_PROJECTS_PATH%/makespace_castellar_database`. Check [section](#setting-up-sites) in order to setting up all repositories) 
* Move to the devops directory: `cd ..`
* Build containers: `docker-compose build`
* Start containers in detached mode:: `docker-compose up -d`

## Day to day work
* Stop containers: `docker-compose stop`
* Start containers: `docker-compose start`

## Update containers definition
* Stop containers: `docker-compose stop`
* Build the containers: `docker-compose build` (if you don't want to use cache, remember that you have the `--no-cache` flag available for this command)
* Create and start containers in detached mode: `docker-compose up -d`

## Common tasks
* List running containers: `docker-compose ps` (if you want to show all containers, remember that you have the `-a` flag available for this command)
* Open an interactive bash terminal inside a container: `docker-compose exec <service_name> bash`

## Troubleshooting

### Debugging
* List running containers: `docker ps`
* Show container logs: `docker-compose logs makespace_castellar_database`
* Start a container from a specific `Dockerfile`:
    * Move to the `Dockerfile` directory
    * Build: `docker-compose build <service_name>" .`
    * Run: `docker-compose up -d <service_name>`

### Debugging network
* List all Docker networks: `docker network ls`
* Inspect the details of a specific network: `docker network inspect devops_main`
* In order to check which is the IP of your host from the point of view of a container: `docker network inspect devops_main |grep Gateway`

### Cleaning up
* Stop and delete all containers: `docker-compose down`
* Delete all images: `docker rmi $(docker images -aq)`
* Remove all data from stopped containers: `docker system prune -a`
* Remove all networks: `docker network prune`

## Setting up sites


## Landing
