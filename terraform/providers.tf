provider "proxmox" {
  pm_api_url          = var.api_url
  pm_api_token_id     = var.api_token_id
  pm_api_token_secret = var.api_token
  # FIXME: figure out why unsetting below option
  # will cause error config file already exists
  pm_parallel = 1
}
