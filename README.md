# AZ Terraform Hub and Spoke

## Prerequisite
1. Terraform
```
$ terraform version

Terraform v1.2.4
on linux_amd64
+ provider registry.terraform.io/hashicorp/azurerm v2.99.0
```
2. Azure cli
```
$ az version
{
  "azure-cli": "2.38.0",
  "azure-cli-core": "2.38.0",
  "azure-cli-telemetry": "1.0.6",
  "extensions": {}
}
```

3. Create Azure cloud sanbox

Update resource group (rg-name) local variable in `main.tf`
```
locals {
  rg-name        = "1-xyz-playground-sandbox"
}
```

Authenticate Azure cli
```
$ az login --use-device-code
To sign in, use a web browser to open the page https://microsoft.com/devicelogin and enter the code XYZ to authenticate.
```

## Initialize terraform code
```
$ terraform init
$ terraform fmt
```

## Create terraform workspace
```
$ terraform workspace new 1-xyz-playground-sandbox
```

## Deploy terraform code
```
$ terraform plan
$ terraform apply -auto-approve -parallelism=3
```