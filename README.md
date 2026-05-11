
# Deploy Kubernets

## Docs
https://help.ovhcloud.com/csm/en-public-cloud-kubernetes-create-cluster?id=kb_article_view&sysparm_article=KB0049685

## Teraform deploy
terraform init
terraform plan -var-file="variables.tfvars"       
terraform apply -var-file="variables.tfvars" --auto-aprove   

terraform destroy -var-file="variables.tfvars" --auto-aprove        

