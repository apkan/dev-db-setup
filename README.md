# Migrating Databases using Ansible and Terraform

## Required tools set:
- Ansible
- Terraform
- GCP Project

## Execution steps:
- git clone https://github.com/apkan/dev-db-setup.git
- define variables in terraform.tfvars
- define variables in ansible/dbServer.yml
- export GCP variables (Service account location & GCP storage keys)
    ```
      export GOOGLE_APPLICATION_CREDENTIALS=/etc/*****************.json
      export GS_ACCESS_KEY_ID=GO**********HM
      export GS_SECRET_ACCESS_KEY=sS************************aP 
   ```
- terraform plan
- terraform apply

## Output:
Terraform will execute Ansible playbook with a set of tasks.

## Directory structure
``` sh
./
├── ansible
│   ├── dbServer.yml
│   └── roles
│       ├── mongo-db
│       │   ├── files
│       │   ├── handlers
│       │   │   └── main.yml
│       │   ├── tasks
│       │   │   └── main.yml
│       │   ├── templates
│       │   │   ├── configurations.json.j2
│       │   │   ├── mongodb.repo.j2
│       │   │   ├── mongod.conf.j2
│       │   │   └── mongod.service.j2
│       │   └── vars
│       │       └── main.yml
│       └── mysql-db
│           ├── tasks
│           │   └── main.yml
│           ├── templates
│           │   ├── my.cnf.j2
│           │   └── mysqld.service.j2
│           └── vars
│               └── main.yml
├── inventory.tpl
├── main.tf
├── modules
│   └── db-server
│       ├── main.tf
│       └── variables.tf
├── README.md
├── terraform.tfstate
├── terraform.tfstate.backup
├── terraform.tfvars
└── variables.tf
```

Blog Post : 
