locals {
  all_vms = concat(
    proxmox_virtual_environment_vm.webserver,
    [proxmox_virtual_environment_vm.databaseserver],
  )

  # ipv4_addresses is a list per network interface (incl. loopback) reported by the guest agent
  vm_ips = {
    for vm in local.all_vms :
    vm.name => try([for ip in flatten(vm.ipv4_addresses) : ip if ip != "127.0.0.1"][0], "unknown")
  }
}

output "vm_ips" {
  description = "IP address per VM"
  value       = local.vm_ips
}

# Requirement: the IP of every machine ends up in a file on the management system
resource "local_file" "ip_addresses" {
  filename        = "${path.module}/ip_addresses.txt"
  file_permission = "0644"
  content         = join("\n", [for name, ip in local.vm_ips : "${name} ${ip}"])
}
