resource "digitalocean_domain" "template" {
  name = "template.com"
}

resource "digitalocean_record" "auth0" {
  domain = digitalocean_domain.template.id
  type   = "CNAME"
  name   = "auth0.template.com."
  value  = var.auth0_cname_verification_record
  ttl    = 30
}

# Webmail - in this case Zoho Mail
resource "digitalocean_record" "zoho_webmail_verification" {
  domain = digitalocean_domain.template.id
  type   = "TXT"
  name   = "@"
  value  = var.zoho_mail_txt_verification_record
  ttl    = 30
}

resource "digitalocean_record" "zoho_mx1" {
  domain   = digitalocean_domain.template.id
  type     = "MX"
  name     = "@"
  value    = "mx.zoho.eu."
  priority = 10
  ttl      = 30
}

resource "digitalocean_record" "zoho_mx2" {
  domain   = digitalocean_domain.template.id
  type     = "MX"
  name     = "@"
  value    = "mx2.zoho.eu."
  priority = 20
  ttl      = 30
}

resource "digitalocean_record" "zoho_mx3" {
  domain   = digitalocean_domain.template.id
  type     = "MX"
  name     = "@"
  value    = "mx3.zoho.eu."
  priority = 50
  ttl      = 30
}

resource "digitalocean_record" "zoho_spf" {
  domain = digitalocean_domain.template.id
  type   = "TXT"
  name   = "@"
  value  = "v=spf1 include:zohomail.eu ~all"
  ttl    = 30
}

resource "digitalocean_record" "zoho_dkim" {
  domain = digitalocean_domain.template.id
  type   = "TXT"
  name   = "zmail._domainkey"
  value  = var.zoho_mail_domain_key
  ttl    = 30
}

# Amazon SES Mail Records
resource "digitalocean_record" "amazon_ses_mx" {
  domain   = digitalocean_domain.template.id
  type     = "MX"
  name     = "mail.template.com"
  value    = "feedback-smtp.us-east-1.amazonses.com."
  priority = 10
  ttl      = 30
}

resource "digitalocean_record" "amazon_ses_spf" {
  domain = digitalocean_domain.template.id
  type   = "TXT"
  name   = "mail.template.com"
  value  = "v=spf1 include:amazonses.com ~all"
  ttl    = 30
}

resource "digitalocean_record" "amazon_ses_dkim1" {
  domain = digitalocean_domain.template.id
  type   = "CNAME"
  name   = "${var.ses_dkim1}._domainkey"
  value  = "${var.ses_dkim1}.dkim.amazonses.com."
  ttl = 30
}

resource "digitalocean_record" "amazon_ses_dkim2" {
  domain = digitalocean_domain.template.id
  type   = "CNAME"
  name   = "${var.ses_dkim2}._domainkey"
  value  = "${var.ses_dkim2}.dkim.amazonses.com."
  ttl    = 30
}

resource "digitalocean_record" "amazon_ses_dkim3" {
  domain = digitalocean_domain.template.id
  type   = "CNAME"
  name   = "${var.ses_dkim3}._domainkey"
  value  = "${var.ses_dkim3}.dkim.amazonses.com."
  ttl    = 30
}

resource "digitalocean_record" "dmarc" {
  domain = digitalocean_domain.template.id
  type   = "TXT"
  name   = "_dmarc"
  value  = "v=DMARC1; p=none;"
  ttl    = 30
}
