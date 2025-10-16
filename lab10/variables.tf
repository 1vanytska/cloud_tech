variable "region1" {
  default     = "East US"
  description = "Primary region"
}

variable "region2" {
  default     = "West US"
  description = "Secondary region for disaster recovery"
}

variable "resource_group_region1" {
  default     = "az104-rg-region1"
  description = "Resource group in East US"
}

variable "resource_group_region2" {
  default     = "az104-rg-region2"
  description = "Resource group in West US"
}

variable "vm_name" {
  default     = "az104-10-vm0"
  description = "Name of the virtual machine"
}

variable "admin_username" {
  default     = "localadmin"
  description = "Admin username for the VM"
}

variable "admin_password" {
  description = "Admin password for the VM"
  sensitive   = true
}

variable "vault_name_region1" {
  default     = "az104-rsv-region1"
  description = "Recovery Services Vault in East US"
}

variable "vault_name_region2" {
  default     = "az104-rsv-region2"
  description = "Recovery Services Vault in West US"
}

variable "backup_policy_name" {
  default     = "az104-backup"
  description = "Name of the backup policy"
}

variable "timezone" {
  default     = "UTC"
  description = "Timezone for backup policy"
}

variable "storage_account_name" {
  description = "Globally unique name for the storage account"
}