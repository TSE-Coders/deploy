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

