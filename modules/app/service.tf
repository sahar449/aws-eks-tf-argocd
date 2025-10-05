resource "kubernetes_service" "flask_service" {
  metadata {
    name      = local.values.app.name
    namespace = "default"
  }

  spec {
    selector = {
      app = local.values.app.name
    }

    port {
      port        = local.values.service.port
      target_port = local.values.app.port
    }

    type = local.values.service.type
  }
}
