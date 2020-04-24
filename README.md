# ideals-terraform

_This repository is a result of performing a test task for DevOps position_

Prerequisites:

    terraform v0.12.24+

0. Initialize a local workspace with needed plugins and modules with 
    
    `terraform init`
    
0. Gather changes should be applied to current environment

    `terraform plan`
    
0. _Optional._ Make some changes

0. Apply new changes with 

    `terraform apply` (`terraform apply -auto-approve` to run without confirmation prompt) 

0. To drop all resources from AWS 

    `terraform destroy` (`terraform destroy -auto-apply` to run without confirmation prompt)

P.S. what should be also added/modified here 
- tags for all possible resources 
- move part of names/configuration to variables
- remove default values and create tfvar files for each target needed
- move AWS ALB and Ingress resources instead of TCP traffic proxying 
