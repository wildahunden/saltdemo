# Saltstack Demo
Demonstration of using saltstack and terraform with Oracle Cloud Service.

After being laid off, I interviewed for a DevOps job and they were concerned that I didn't have Saltstack experience.
To address that, and to satisfy my curiosity, I decided to create a working demo.  Having never worked with salt, 
terraform or Oracle Cloud Infrastructure (oci), I set out to create and document it.  I am a prolific documentor 
because I like to be able to refer back to my notes later.  It's selfish, I know.  :)

## Getting Started
This documentation is designed for a Mac OsX workstation, but the links will include instructions for other 
environments.  Homebrew (https://brew.sh) is used to install terraform (https://terraform.io).

### Prerequisites
#### Oracle Cloud Infrastructure (oci) Account
You can sign up for an account with 30 days to use $300 credit they give you.  

http://cloud.oracle.com/tryit

#### Install Terraform on your workstation (assumes mac workstation with homebrew)

brew install terraform

terraform --version

#### Install the OCI terraform provider
https://github.com/oracle/terraform-provider-oci/releases

Download the appropriate provider, untar it and copy it to ~/.terraform.d/plugins.  Note, the correct provider for
mac is named "darwin."  If you install the wrong provider, you will get a fork/execution error later.

If you still have questions about installing the oci provider for terraform, you can refer to:
https://docs.cloud.oracle.com/iaas/Content/API/SDKDocs/terraformgetstarted.htm?tocpath=Developer%20Tools%20%7CTerraform%20Provider%7C_____1

### Preparing to use terraform with oci
You will need to create export a number of variables which terraform will use to authenticate to oci.  To simplify I
created a file for the api credentials and put it in ~/terraform_oci.  You can see a sample in the /oci/.terrafor_oci file.

export TF_VAR_tenancy_ocid="<tenancy ocid>"

export TF_VAR_user_ocid="<username>"

export TF_VAR_fingerprint="<privateKeyFingerpring>"

export TF_VAR_private_key_path="<pathToPrivateKey>

export TF_VAR_compartment_ocid="<compartment OCID>"

export TF_VAR_region="<regionName>"

The OCID values are avaible in the OCI console.  You'll need to generate the key files using these instructions:
https://docs.cloud.oracle.com/iaas/Content/API/Concepts/apisigningkey.htm

Once you have the file created, you'll need to source it whenever you want to work with terraform & oci:

source ~/terraform_oci

## Running Tests
cd to the oci directory in this repo

* source ~/terraform_oci
* terraform init
* terraform plan       # See what it thinks it needs to do.
* terraform apply      # Apply the changes
* terraform destroy    # To save money, destroy the resources on oci until you come back next time.

## File layout
### /oci
This directory has all the code necessary to provision the resources in OCI.  The scripts create:
* Virtual Cloud Network (VCN)
* Internet Gateway (IGW)
* Four subnets
* Two security lists (used by the subnets)
* Two route tables (used by the subnets)
* Load balancer (with 2 instances in different subnets)
* Listener (used by the load balancer)
* Back end set (used by the load balancer) with health check
* Two backend objects to assign compute instances to the load balancer
* Five compute instances (salt master, two salt minions for testing, two web servers)

### /salt-code
This directory stores the code necessary for the salt stack deployment of a very simple web page for the web servers 
running Apache httpd to server.

### LessonsLearned
Look in the source code for "LessonsLearned" to see the areas which presented issues and had to be resolved in the process
of bringing this site up.

## Deployment
You will need to manually create a compartment in OCI and update the credentials file (e.g., ~/.terraform_oci) with the ocid.
You will also need to create a user and add a public key to the user.  That user will be used by terraform to provision 
resources.  Once you have the credentials setup and the compartment, you can do the following to bring the site up.
cd ./oci
source ~/.terraform_oci  #export shell variables terraform will use
terraform init
terraform apply          #this will take 10-20 minutes.  Once all the instances come up, the load balancer needs to detect back end servers.
You will see a list of server names and IP addresses.  These are the servers you will need to work with.

## Built With
Homebrew - https://brew.sh/

OCI - http://cloud.oracle.com/tryit

Terraform - https://terraform.io

## Author
Daniel Williams

## License
See LICENSE.md

## Acnowledgments
Arnes Tech Stuff -- http://arnes-stuff.blogspot.com/2017/11/oracle-cloud-infrastructure-and.html
Udemy OCI Architect Course:  https://www.udemy.com/oracle-cloud-infrastructure-associate-arch-part-i-1z0-932/learn/v4/
Udemy Salt Stack Course:  https://www.udemy.com/mastering-saltstack-from-ground-to-cloud/learn/v4/




