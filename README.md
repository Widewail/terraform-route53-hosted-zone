# Simple Route53 DNS Management

Easily create a Route53 hosted zone and associated records. Supports creating an alias
record on the domain. See the [AWS docs](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/resource-record-sets-choosing-alias-non-alias.html)
for more information on alias records.


# Example

Pointing the A record of a domain to a CloudFront distribution

```
data "aws_cloudfront_distribution" "distro" {
  id = "AAABBBCCCC"
}

module "example_org" {
  source = "git@github.com:Widewail/terraform-route53-hosted-zone.git"
  domain = "example.org"
  alias = {
    dns_name = data.aws_cloudfront_distribution.distro.domain_name
    zone_id = data.aws_cloudfront_distribution.distro.hosted_zone_id
  }
}
```

Setting up subdomains

```
module "example_org" {
  source = "git@github.com:Widewail/terraform-route53-hosted-zone.git"
  domain = "example.org"
  records = [
    {name = "www", type = "CNAME", ttl = 300, records = [ "abc123.whatever.com" ]}
  ]
}
```

