resource "aws_route53_zone" "primary" {
  name    = var.domain
  comment = "Hosted zone for ${var.domain}"
  tags    = var.tags
}

resource "aws_route53_record" "alias" {
  count   = length(var.alias) > 0 ? 1 : 0
  zone_id = aws_route53_zone.primary.zone_id
  name    = var.domain
  type    = "A"

  alias {
    name                   = var.alias.dns_name
    zone_id                = var.alias.zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "record" {
  // terraform can only iterate over maps or simple lists, so transform the list into a map
  for_each = { for record in var.records : record.name => record }
  zone_id  = aws_route53_zone.primary.zone_id
  name     = each.key
  type     = each.value.type
  ttl      = each.value.ttl
  records  = each.value.records
}