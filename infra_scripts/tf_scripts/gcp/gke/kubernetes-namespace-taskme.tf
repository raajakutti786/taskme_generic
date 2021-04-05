resource "kubernetes_namespace" "taskme_ns" {
  metadata {
    name = "taskme"
  }
}