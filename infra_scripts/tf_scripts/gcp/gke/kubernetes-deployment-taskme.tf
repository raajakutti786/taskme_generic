resource "kubernetes_deployment" "taskme-deployment" {
  metadata {
    name = "taskme-deployment"
    labels = {
      App = "taskme"
    }
    namespace = kubernetes_namespace.taskme_ns.metadata[0].name
  }

  spec {
    replicas                  = 4
    progress_deadline_seconds = 60
    selector {
      match_labels = {
        App = "taskme"
      }
    }
    template {
      metadata {
        labels = {
          App = "taskme"
        }
      }
      spec {
        container {
          image = "drehnstrom/space-invaders:latest"
          name  = "taskme-ui"

          port {
            container_port = 80
          }

          resources {
            limits = {
              cpu    = "0.2"
              memory = "2562Mi"
            }
            requests = {
              cpu    = "0.1"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}