variable "digitalocean_api_token" {}

module "digitalocean_vm" {  
  source  = "github.com/mto79/terraform_digitalocean_vm?ref=v0.0.1"

  for_each = { for vm in var.digitalocean_vms : vm.name => vm }

  project    = try(coalesce(each.value.project, var.default_project), null)

  name   = each.value.name
  image  = try(each.value.image, null)
  region = try(coalesce(each.value.region, var.default_region), null)
  size   = try(each.value.size, null)
  tags   = try(each.value.tags, [])

  backups    = try(each.value.backups, null)
  monitoring = try(each.value.monitoring, null)
  ipv6       = try(each.value.ipv6, null)
  vpc_uuid   = try(each.value.vpc_uuid, null)

  existing_ssh_keys = try(each.value.existing_ssh_keys, null)
  new_ssh_keys      = try(each.value.new_ssh_keys, null)

  resize_disk = try(each.value.resize_disk, null)

  user_data  = try(each.value.user_data, null)
  volume_ids = try(each.value.volume_ids, null)

  record_enable = each.value.record_enable
  record_type = each.value.record_type
  record_domain = each.value.record_domain
  record_name = each.value.record_name
  record_ttl = each.value.record_ttl

  ansible_name                 = try(each.value.ansible_name, null)
  ansible_host                 = try(each.value.ansible_host, null)
  ansible_groups               = try(each.value.ansible_groups, null)
  ansible_user                 = try(each.value.ansible_user, null)
  ansible_ssh_pass             = try(each.value.ansible_ssh_pass, null)
  ansible_ssh_private_key_file = try(each.value.ansible_ssh_private_key_file, null)
}
