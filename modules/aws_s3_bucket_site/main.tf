locals {
  tld       = replace(var.zone.name, "/.$/", "")
  origin_id = "S3-${var.name}.${local.tld}"

  all_names = concat(list(var.name), var.aliases)

  domain_name = "${var.name}${var.name == "" ? "" : "."}${local.tld}"
  aliases     = [for alias in var.aliases: "${alias}${alias == "" ? "" : "."}${local.tld}"]
}
