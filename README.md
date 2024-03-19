# Deploy

This project is used to deploy a sandbox project that follows the TSE Sandbox Standard.

The TSE Sandbox Standard is meant defines the expected behavior of the entire application. This allows contributors to have a clear goal when creating example projects for the sandbox library. This project automates the deployment process for the sandbox so that users can have a running web application quickly.

## Requirements

This project leverages the cloud provider AWS for hosting and the tools Terraform and Ansible for deployment and configuration automation. This means that you will need those tools installed. If you don't have them installed already follow the instructions below for the given tool.

``` bash
# Installing Terraform
# https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

``` bash
# Installing Ansible
# https://formulae.brew.sh/formula/ansible
brew install ansible
```

``` bash
# Installing AWS CLI
# https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
sudo installer -pkg AWSCLIV2.pkg -target /
```

## Setup

### AWS

In order for Terraform to be able to create EC2's on your behalf, you will need to get an access and secret key. To do this you can follow [These Instructions](automated_deployment_test) from the EC2 Terraform Sandbox. Once you have your access and secret key, create a file in `~/.aws` called `credentials` and add the following text:

```
[datadog-admin]
aws_access_key_id = <YOUR_ACCESS_KEY>
aws_secret_access_key = <YOUR_SECRET_KEY>
```

This will create an AWS profile called `datadog-admin` which Terraform will use to interact with AWS.

### Terraform

In the `tools/terraform/variables.tf` files you can see that there is a variable called `hostname`, this is going to be the name of the EC2. The best way to provide the value for this is to create a `tools/terraform/terraform.tfvars` with the hostname you would like. Below is an example where I set the hostname to `sandbox-standardization`:

``` terraform
hostname = "sandbox-standardization"
```

### Sandbox Components

Here we will go over how to tell the tool where to find the components that need to be deployed. In the file `create_ec2.sh` you will see that there are 3 variables that look the example below:

``` sh
FRONTEND_REPO="https://github.com/TSE-Coders/pd-client-service.git"
BACKEND_REPO="https://github.com/TSE-Coders/pd-users-api.git"
PRODUCER_REPO="https://github.com/TSE-Coders/ZD.git"
```

The repos there are the default however these can be changed to whatever you'd like, though there are some crateria that the repo would have to follow. This information can be found in the TSE-Coders Confluence page.

### Environment Variables

For components that require environment variables you will need to create an env file in the `environment_varaibles` directory. The naming convention is `<COMPONENT.env` so if the frontend needs environment variables you would name the file `frontend.env`.

For the default deployment, only the producer needs environment variables. In the `environment_variables` directory you should see a file called `producer.env.example`, make a copy called `producer.env` and provide a value for each of the empty variables.

```
ENV=development
USER_SRV_DOMAIN=localhost
USER_SRV_PORT=3000

RMQ_USER=
RMQ_PASS=
RMQ_DOMAIN=localhost
RMQ_PORT=5672

REDIS_DOMAIN=localhost
REDIS_PORT=6379
REDIS_DB=0
REDIS_PASS=
```

## Deployment

Now that you have finished setting up, you can deploy the sandbox. To do this you run the script `create_ec2.sh` and let it go. After it has completed, you will see a message stating the URL that the application can be reached from. Note that this is the Private IP Address of the EC2 which can only be accessed via a computer connected to Appgate. 

Note that even though the script finished and all of the project components are deployed, they will need some time to be up and running so if you go to the URL given right away you will likely see a `Site Cannot be Reached Page`. The components should be ready after about 5 minutes of the script finishing.

