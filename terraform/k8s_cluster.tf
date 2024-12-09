resource "digitalocean_kubernetes_cluster" "template" {
  name    = "template"
  region  = var.do_region
  version = "1.31.1-do.1"

  node_pool {
    name       = "worker-pool"
    size       = "s-4vcpu-8gb"
    node_count = 1
  }
}
