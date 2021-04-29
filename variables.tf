variable "tags" {
  description = "Tags to apply to the hosted zone"
  default     = {}
}

variable "domain" {
  description = "Name of the domain. e.g. example.com"
  type        = string
}

variable "alias" {
  description = "Specify an AWS alias as the A record for this domain. See AWS docs on alias records."
  type = object({
    dns_name = string
    zone_id  = string
  })
}

variable "records" {
  description = "DNS records for domain"
  type = list(object({
    name    = string
    type    = string
    ttl     = number
    records = list(string)
  }))
  default = []
}