#!make
-include .env
export

$(if $(DIGITALOCEAN_TOKEN),,$(error Must set DIGITALOCEAN_TOKEN))

init:
	terraform init 

plan:
	terraform plan $(ARGS)

apply:
	terraform apply $(ARGS)

destroy:
	terraform destroy