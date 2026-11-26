locals {
  vm_ips = {
    for i, vm in azurerm_linux_virtual_machine.vm :
    vm.name => azurerm_public_ip.pip[i].ip_address
  }
}

output "vm_public_ips" {
  description = "Public IP per VM"
  value       = local.vm_ips
}

output "ssh_commands" {
  value = [for name, ip in local.vm_ips : "ssh ${var.admin_username}@${ip}"]
}

# Requirement: the IP of every machine ends up in a file on the management system
resource "local_file" "ip_addresses" {
  filename        = "${path.module}/ip_addresses.txt"
  file_permission = "0644"
  content         = join("\n", [for name, ip in local.vm_ips : "${name} ${ip}"])
}
