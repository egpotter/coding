# Contracts management API

- [Set up development environment with Docker](#set-up-development-environment-with-docker)
- [Running tests](#running-tests)
- [Postman collection](#postman-collection)

## Set up development environment with Docker

### Prerequisites
- Git - [Download & Install Git](https://git-scm.com/downloads)
- Docker - [Download & Install Docker](https://docs.docker.com/get-docker/)

### Usage
#### 1 - Clone the repository to your local machine.

```bash
git clone URL
cd finlex
```

#### 2 - Build all images.

```bash
docker-compose build
```

#### 3 - Start containers.

```bash
docker-compose up
```

## Running tests

```bash
docker-compose run web rspec
```

## Postman collection
Downlaod and import the postman collection under the docs folder. It includes all the requests available in the api. The BASE_URL needs to be set for Postman. If no port is changed, it should be set as `localhost:3000`.
