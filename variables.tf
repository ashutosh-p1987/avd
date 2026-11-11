
variable "resource_group_name" {
  description = "Azure Resource Group Name."
  type        = string
}

variable "location" {
  description = "Azure deployment region."
  type        = string
  default     = "southeastasia"
}

variable "subscription_id" {
  description = "Azure subscription ID to deploy into."
  type        = string
}

variable "prefix" {
  description = "Short prefix used in resource names (lowercase letters/numbers, max 6 chars)."
  type        = string
  default     = "avd"

  validation {
    condition     = can(regex("^[a-z0-9]{2,6}$", var.prefix))
    error_message = "prefix must be 2-6 lowercase letters or digits."
  }
}

variable "environment" {
  description = "Environment tag/name suffix."
  type        = string
  default     = "dev"
}

variable "tags" {
  description = "Tags applied to all resources."
  type        = map(string)
  default     = {}
}

# ---------------- Networking ----------------

variable "vnet_address_space" {
  description = "Address space for the AVD virtual network."
  type        = list(string)
  default     = ["10.10.0.0/16"]
}

variable "session_host_subnet_prefix" {
  description = "Address prefix for the session host subnet."
  type        = string
  default     = "10.10.1.0/24"
}

variable "enable_nat_gateway" {
  description = "Create a NAT gateway for explicit outbound internet access."
  type        = bool
  default     = true
}

# ---------------- Host pool ----------------

variable "personal_desktop_assignment_type" {
  description = "Automatic or Direct personal desktop assignment."
  type        = string
  default     = "Automatic"

  validation {
    condition     = contains(["Automatic", "Direct"], var.personal_desktop_assignment_type)
    error_message = "Must be Automatic or Direct."
  }
}

variable "start_vm_on_connect" {
  description = "Start deallocated session hosts automatically when users connect."
  type        = bool
  default     = true
}

variable "registration_token_rotation_days" {
  description = "Registration token rotation interval (1-27 days)."
  type        = number
  default     = 7

  validation {
    condition     = var.registration_token_rotation_days >= 1 && var.registration_token_rotation_days <= 27
    error_message = "Must be between 1 and 27 days."
  }
}

# ---------------- Session hosts ----------------

variable "session_host_count" {
  description = "Number of personal AVD session host VMs."
  type        = number
  default     = 1

  validation {
    condition     = var.session_host_count >= 1
    error_message = "Session host count must be at least 1."
  }
}

variable "vm_size" {
  description = "Azure VM size for AVD session hosts."
  type        = string
  default     = "Standard_D4s_v5"
}
variable "vm_size_1" {
  description = "Azure VM size for AVD session hosts."
  type        = string
  default     = "Standard_D4s_v5"
}

variable "os_disk_type" {
  description = "OS disk storage type."
  type        = string
  default     = "Premium_LRS"
}

variable "image" {
  description = "Marketplace image for AVD session hosts."
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })

  default = {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "windows-11"
    sku       = "win11-24h2-ent"
    version   = "latest"
  }
}

variable "admin_username" {
  description = "Local administrator username on session hosts."
  type        = string
  default     = "avdadmin"
}

variable "enroll_in_intune" {
  description = "Enroll session hosts in Intune during Entra ID join."
  type        = bool
  default     = false
}

variable "avd_dsc_artifact_url" {
  description = "URL of the AVD agent DSC configuration package."
  type        = string
  default     = "https://wvdportalstorageblob.blob.core.windows.net/galleryartifacts/Configuration_1.0.02790.438.zip"
}

# ---------------- Access ----------------

variable "avd_user_upns" {
  description = "User principal names allowed to sign in to personal desktops."
  type        = list(string)
  default     = []
}

variable "avd_admin_upns" {
  description = "User principal names granted VM Administrator Login."
  type        = list(string)
  default     = []
}
