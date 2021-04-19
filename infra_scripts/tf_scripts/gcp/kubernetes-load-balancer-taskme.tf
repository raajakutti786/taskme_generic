resource "kubernetes_service" "taskmeui-service" {
  metadata {
    name      = "taskmeui-service"
    namespace = "default" //kubernetes_namespace.default.metadata[0].name
  }
  spec {
    selector = {
      App = kubernetes_deployment.taskmeui-deployment.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 80
      target_port = 8085
    }

    type = "LoadBalancer"
  }
}


output "lb_status" {
  value = kubernetes_service.taskmeui-service.status
}
