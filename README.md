
# Deploy Kubernets

## Docs
https://help.ovhcloud.com/csm/en-public-cloud-kubernetes-create-cluster?id=kb_article_view&sysparm_article=KB0049685

## Teraform deploy
terraform init
terraform plan -var-file="variables.tfvars"       
terraform apply -var-file="variables.tfvars" -auto-approve    

terraform destroy -var-file="variables.tfvars"  -auto-approve  

## Output

Data like passwords are sensitive, and will not be shown.  

Run 
```Terraform output password```
to get the password



### Get Kubeconfig

run 
```terraform output -raw kubeconfig > /Users/tbr/.kube/my_kube_cluster.yml```

or download from portal
https://help.ovhcloud.com/csm/en-public-cloud-kubernetes-configure-kubectl?id=kb_article_view&sysparm_article=KB0049661
export KUBECONFIG=./kubeconfig.yml