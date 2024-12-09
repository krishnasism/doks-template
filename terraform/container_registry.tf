resource "digitalocean_container_registry" "template" {
  name                   = "template"
  subscription_tier_slug = "basic"
  region                 = var.do_region
}
