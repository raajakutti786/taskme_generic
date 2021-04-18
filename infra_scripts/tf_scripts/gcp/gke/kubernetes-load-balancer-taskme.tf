resource "kubernetes_service" "taskme-service" {
  metadata {
    name      = "taskme-service"
    namespace = kubernetes_namespace.taskme_ns.metadata[0].name
  }
  spec {
    selector = {
      App = kubernetes_deployment.taskme-deployment.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 80
      target_port = 8080
    }

    type = "LoadBalancer"
  }
}


output "lb_status" {
  value = kubernetes_service.taskme-service.status
}
