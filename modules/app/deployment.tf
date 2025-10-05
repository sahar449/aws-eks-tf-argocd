resource "kubernetes_deployment" "flask_app" {
  metadata {
    name      = local.values.app.name
    namespace = "default"
    labels = {
      app = local.values.app.name
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = local.values.app.name
      }
    }

    template {
      metadata {
        labels = {
          app = local.values.app.name
        }
      }

      spec {
        container {
          name  = local.values.app.name
          image = "${local.values.image.repository}:${local.values.image.tag}"
          port {
            container_port = local.values.app.port
          }
        }
      }
    }
  }
}
