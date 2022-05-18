resource "aws_route53_zone" "zone" {
  name = "naman.ml"
}


resource "aws_route53_record" "record" {
  zone_id = aws_route53_zone.zone.zone_id
  name    = "naman.ml"
  type    = "A"

  alias {
    name                   = aws_lb.lb.dns_name
    zone_id                = aws_lb.lb.zone_id
    evaluate_target_health = true
  }
}

output "name_servers"{
  value=aws_route53_zone.zone.name_servers
}