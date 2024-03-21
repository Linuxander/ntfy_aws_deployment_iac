locals {
  allowed_ips_for_http = [for ip in split("\n", trimspace(file("${path.module}/data/allowed_ips_for_http.txt"))) : ip]
  allowed_ips_for_ssh  = [for ip in split("\n", trimspace(file("${path.module}/data/allowed_ips_for_ssh.txt"))) : ip]
}
