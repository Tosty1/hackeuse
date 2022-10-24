#mariadb firewall rule
data "http" "myip" {
  url = "http://ifconfig.me/ip"
}
