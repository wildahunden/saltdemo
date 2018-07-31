# saltdemo
Demonstration of using saltstack and terraform with Oracle Cloud Service.

After being laid off, I interviewed for a DevOps job and they were concerned that I didn't have Saltstack experience.
To address that, and to satisfy my curiosity, I decided to create a working demo.  Having never worked with salt, 
terraform or Oracle Cloud Infrastructure (oci), I set out to create and document it.  I am a prolific documentor 
because I like to be able to refer back to my notes later.

## Getting Started

### Prerequisites

Setting up your environment for using terraform with oci
Install terraform:  brew install terraform
Install OCI provider:  https://docs.cloud.oracle.com/iaas/Content/API/SDKDocs/terraformgetstarted.htm?tocpath=Developer%20Tools%20%7CTerraform%20Provider%7C_____1
https://github.com/oracle/terraform-provider-oci/releases
Note:  OSX provider is the Darwin provider
untar the file then copy it to ~/.terraform.d/plugins

### Terraform
Create a file for the api credentials: ~/terraform_oci

export TF_VAR_tenancy_ocid="<tenancy ocid>"
export TF_VAR_user_ocid="<username>"
export TF_VAR_fingerprint="<privateKeyFingerpring>"
export TF_VAR_private_key_path="<pathToPrivateKey>
export TF_VAR_compartment_ocid="<compartment OCID>"
export TF_VAR_region="<regionName>"

The OCID values are avaible in the OCI console.  You'll need to generate the key files using:
https://docs.cloud.oracle.com/iaas/Content/API/Concepts/apisigningkey.htm


## Running Tests
cd to the oci directory in this repo
terraform init
terraform plan
terraform apply
terraform destroy

## Deployment

## Build With

## Author

## License

## Acnowledgments




