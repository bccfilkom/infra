tf/init:
	@cd terraform && terraform init

tf/update:
	@cd terraform && terraform init -upgrade

tf/plan:
	@cd terraform && terraform plan -var-file="proxmox.tfvars"

tf/apply:
	@cd terraform && terraform apply -var-file="proxmox.tfvars"
