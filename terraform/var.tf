variable "api_url" {
  type        = string
  description = "Promox API URL"
}

variable "api_token" {
  type        = string
  description = "Promox API Token"
  sensitive   = true
}

variable "api_token_id" {
  type        = string
  description = "Promox API Token ID"
}

