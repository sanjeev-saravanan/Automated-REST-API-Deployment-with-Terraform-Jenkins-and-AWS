variable "domain_name" {}
variable "hosted_zone_id" {}
variable "aws_lb_zone_id" {}
variable "aws_lb_dns_name" {}

output "hosted_zone_id" {
  value = data.aws_route53_zone.tf_jenkins_proj_1_sanjeev_saravanan_xyz.zone_id
}

data "aws_route53_zone" "tf_jenkins_proj_1_sanjeev_saravanan_xyz" {
  name         = "sanjeevsaravanan.xyz"
  private_zone = false
}

resource "aws_route53_record" "lb_record" {
  zone_id = data.aws_route53_zone.tf_jenkins_proj_1_sanjeev_saravanan_xyz.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = var.aws_lb_dns_name
    zone_id                = var.aws_lb_zone_id
    evaluate_target_health = true
  }
}
