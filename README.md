# Detectify Challenge

## Overview

This repository constitutes of static webservers which displays `Hello World` and `Hello World, again`, dockerfiles for both the applications, and Helm chart.

## Before you start
Make sure you meet the following prerequisites before starting the how-to steps:
* Clone this repository. 
``` BASH
git clone https://github.com/akashkaveti/detectify-challenge.git
```
* [Docker](https://docs.docker.com/get-docker/) is installed.
* Kubernetes configuration is downloaded and stored.
* Helm(v2) is installed, tiller is initiated in the destination kubernetes cluster.

## Step-by-step guide
### Step-1: set the environment variables
* Set the following variables as environment varaibles. `Makefile` uses them during the build and deploy process.
``` BASH
# Docker hub repository details
CHALLENGE_LOCAL_IMAGE = akashkaveti/challenge-local
DETECTIFY_CHALLENGE_LOCAL_IMAGE = akashkaveti/detectify-challenge-local 
# Namespace where you would like to deploy the application in kubernetes
NAMESPACE=<NAMESPACE>
```
* Dockerise the applications.

``` BASH
make build
```
* Push the application to docker hub
``` BASH
make push
```
### Step-2: Install Helm chart
* This helm chart deploys both the applications along with an nginx ingress controller.
* To install,
``` BASH
make deploy
```
### Step-3: Get the IP address of the Ingress controller
* To get the IP address of the ingress controller,
``` BASH
kuectl get services detectify-nginx-ingress-controller -n <NAMESPACE> -o jsonpath="{.status.loadBalancer.ingress[0].ip}"
```
Take a note of this IP address.
### Step-4: Reaching URL
* To reach the URLS `challenge.local` and `detectify.challenge.local` please update `/etc/hosts` with the above IP address.
* In your browser, you can reach the webpages at `challenge.local` and `detectify.challenge.local`


#### Trouble shooting or Improvements:

* For this task, I have used Digital Ocean managed Kubernetes soluton(DOKS). I would outsource the underlying infrastructure and concentrate on deploying application part.
* When a user would like to handle to higher load, We shouild update the number of replicas that application is serving. This can be done by updating the value in `values.yaml` file under `replicaCount`. Currently it is set to 1.
* To decrese the response time, I would increse the CPU limits that are added for this application.
* To troubleshoot the application, either I would exec into the container or I would check the kubernetes pod logs.