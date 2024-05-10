
locals {
  # all AWS region
  all_regions = jsondecode((file("${path.module}/data/region.json")))["region"]

  # specical region
  china_region     = jsondecode((file("${path.module}/data/china-region.json")))["region"]
  gov_cloud_region = jsondecode((file("${path.module}/data/gov-cloud-region.json")))["region"]

  input_region = replace(var.region, "-", "") # replace "-" in the region string

  # validation
  is_valid_char_code = contains([for region in local.all_regions : region.char_code], local.input_region) ? var.region : file("[Error] ${var.region} is not valid")

  # is china region
  is_china_region     = contains(local.china_region, local.input_region)
  is_gov_cloud_region = contains(local.gov_cloud_region, local.input_region)
  is_global_region    = local.is_china_region == false && local.is_gov_cloud_region == false
}


