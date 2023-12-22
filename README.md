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
