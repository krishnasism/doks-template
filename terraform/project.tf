resource "digitalocean_project" "template" {
  name        = "template"
  description = "My project"
  purpose     = "Web Application"
  environment = "Development"
}

resource "digitalocean_project_resources" "template" {
  project   = digitalocean_project.template.id
  resources = [digitalocean_kubernetes_cluster.template.urn, digitalocean_domain.template.urn]
}
