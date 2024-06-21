terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.15"
    }
  }
}

provider "docker" {
  host = "npipe:////./pipe/docker_engine"
}

resource "docker_network" "my_network" {
  name = "my_network"
}

resource "docker_container" "nginx" {
  image = "nginx:latest"
  name  = "nginx_container"
  ports {
    internal = 80
    external = 8080
  }
  networks_advanced {
    name = docker_network.my_network.name
  }
}
