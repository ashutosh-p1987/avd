# Copy to terraform.tfvars and fill in your values.

subscription_id = "7624824a-7f57-4902-9b9f-9150b5aa9a9d"
location        = "centralindia"
prefix          = "avd"
environment     = "dev"

session_host_count = 2
vm_size            = "Standard_D2s_v5"

personal_desktop_assignment_type = "Automatic"
start_vm_on_connect              = true
enroll_in_intune                 = false

avd_user_upns = [
  "test@ashutoshp1987outlook.onmicrosoft.com"
]

avd_admin_upns = [
  "test@ashutoshp1987outlook.onmicrosoft.com",
]

tags = {
  owner = "it-team"
}
