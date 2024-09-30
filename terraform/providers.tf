provider "proxmox" {
  # pm_tls_insecure     = true
  pm_api_url          = var.api_url
  pm_api_token_id     = var.api_token_id
  pm_api_token_secret = var.api_token
}
