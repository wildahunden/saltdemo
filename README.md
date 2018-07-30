# saltdemo
Demonstration of using saltstack and terraform with cloud service

Setting up your environment for using terraform with oci

Create a file for the api credentials: ~/terraform_oci

export TF_VAR_tenancy_ocid="<tenancy ocid>"
export TF_VAR_user_ocid="<username>"
export TF_VAR_fingerprint="<privateKeyFingerpring>"
export TF_VAR_private_key_path="<pathToPrivateKey>
export TF_VAR_compartment_ocid="<compartment OCID>"
export TF_VAR_region="<regionName>"

The OCID values are avaible in the OCI console.  You'll need to generate the key files using:
https://docs.cloud.oracle.com/iaas/Content/API/Concepts/apisigningkey.htm


