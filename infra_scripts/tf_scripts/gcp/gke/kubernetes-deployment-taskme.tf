resource "kubernetes_deployment" "taskme-deployment" {
  metadata {
    name = "taskme-deployment"
    labels = {
      App = "taskme"
    }
    namespace = kubernetes_namespace.taskme_ns.metadata[0].name
  }

  spec {
    replicas                  = 1
    progress_deadline_seconds = 6000
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
          //image = "dvzpoc/taskmeui:latest"
          image = "dvzpoc/events-external:latest"
          //image = "drehnstrom/space-invaders:latest"
          name  = "taskme-ui"


          port {
            container_port = 8080
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

        container {
          //image = "dvzpoc/taskmeui:latest"
          image = "dvzpoc/events-internal:latest"
          //image = "drehnstrom/space-invaders:latest"
          name  = "taskme-db"

          port {
            container_port = 8082
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