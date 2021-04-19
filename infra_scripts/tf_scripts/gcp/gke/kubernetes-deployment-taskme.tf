resource "kubernetes_deployment" "taskmeui-deployment" {
  metadata {
    name = "taskmeui-deployment"
    labels = {
      App = "taskmeui"
    }
    namespace = "default" //kubernetes_namespace.default.metadata[0].name
  }

  spec {
    replicas                  = 1
    progress_deadline_seconds = 160
    selector {
      match_labels = {
        App = "taskmeui"
      }
    }
    template {
      metadata {
        labels = {
          App = "taskmeui"
        }
      }
      spec {
        container {
          //image = "dvzpoc/taskmeui:latest"
          //image = "dvzpoc/events-external:latest"
          //image = "drehnstrom/space-invaders:latest"
          image = "gcr.io/airy-generator-179101/nodejsui:65"
          name  = "taskmeui"

          env {
            name = "SERVER"
            value = "http://localhost:8082"
          }

        port {
            container_port = 8085
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
          //image = "dvzpoc/events-internal:latest"
          //image = "drehnstrom/space-invaders:latest"
          image = "gcr.io/airy-generator-179101/nodejsdb:14"
          name  = "taskmedb"

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
