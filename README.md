# Traefik-Project
This is a project in which I will provide 3 EC2 instances on AWS. And I'll use Traefik as a reverse proxy for my application.

* I'll use Terraform for infrastructure provisioning and docker swarm to orchestrate the nodes on the cluster.
* So let's get started.

## Some requirements
* An IAM user with credentials and region set
* A bucket s3.
* An AWS account with sufficient permissions.

## First you'll need to git clone this repo 
  ```
  $ git clone https://github.com/afro-juliano/Traefik-Project.git
  ```

  A folder on your home directory will be created Traefik-Project.
  After those steps being concluded you should cd into your new folder and run some commands. If you don't have terraform
  installed on your machine you can run a docker container with the hashicorp image light version and exporting the Access key
  and secret access key on your aws account. You'll need to have an IAM user in which you store your credentials to access the infrastructure.

  Something like this:
  ```
  $ cd Traefik-Project/Terraform\ files
  ```
  * Run the hashicorp terraform container:
  ```
  # docker run -it -v $PWD:/app -w /app --entrypoint "" hashicorp/terraform:light sh
  ```
  * Export access key and secret access key:
  ```
  # export AWS_ACCESS_KEY_ID="Your access Key ID"
  ```
  ```
  # export AWS_SECRET_ACCESS_KEY="Your secret access Key"
  ```
### Now you're ready to provision your infrastructure.

  ```
  # terraform init
  ```
  ```
  # terraform plan
  ```
  ```
  # terraform apply
  ```

### Once your infrastructure is ready, you should enter your VMs via SSH, and configure the Swarm cluster:
  * Go to the AWS console page, and click on the instance and it's properties, get the SSH command to connect to the instance.
  * Should be something like this:
  ```
  $ ssh -i "your_keypair.pem" ubuntu@ip-from-aws-ec2
  ```
  * This file with extension ".pem" will be generated over the script named key_pair.tf, 
    and will be allocated on your local environment.

  * Now you create your master and worker nodes, like this:
  ```
  # docker swarm init
  ```
  * the code above will generate a command for the worker nodes to join the cluster, an example below:
  ```
  # docker swarm join --token yourgeneratedtokenhere ip-from-machine:2377
  ```
  * Use the command generated to join the other two instances and your cluster will be completed.

  * Now inside the master node we're going to create a docker-compose file for the traefik reverse proxy to listen to docker swarm events,
    You can find the script for this action on this path Traefik-Project/Traefik\ And\ Cluster\ Swarm\ files.

  * Create a docker network 
  ```
  # docker network create --driver=overlay traefik-public
  ```
  * Create the files
  ```
  # touch traefik_deploy.yaml
  ```
  ```
  # vim traefik_deploy.yaml
  ```
  ```
  # vim app_example.yaml
  ```
  * Once those files are in place we need to deploy the services in our cluster

  ###### Like This:
  ```
  # docker stack deploy traefik -c traefik_deploy.yaml
  ```
  ```
  # docker stack deploy loja -c app_example.yaml
  ```
  * To check the services status: 

  ```
  # docker service ls
  ```
