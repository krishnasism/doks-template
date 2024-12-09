variable "do_region" {
  type    = string
  default = "fra1"
}

variable "auth0_cname_verification_record" {
  type      = string
  sensitive = true
}

variable "zoho_mail_txt_verification_record" {
  type      = string
  sensitive = true
}

variable "zoho_mail_domain_key" {
  type      = string
  sensitive = true
}

variable "ses_dkim1" {
  type      = string
  sensitive = true
}

variable "ses_dkim2" {
  type      = string
  sensitive = true
}

variable "ses_dkim3" {
  type      = string
  sensitive = true
}
