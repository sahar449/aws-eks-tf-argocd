resource "kubernetes_manifest" "flask_ingress" {
  manifest = {
    apiVersion = "networking.k8s.io/v1"
    kind       = "Ingress"
    metadata = {
      name      = local.values.ingress.name
      namespace = local.values.ingress.namespace
      annotations = {
        "kubernetes.io/ingress.class"           = "alb"
        "alb.ingress.kubernetes.io/scheme"      = local.values.ingress.scheme
        "alb.ingress.kubernetes.io/target-type" = local.values.ingress.targetType
        "alb.ingress.kubernetes.io/listen-ports"= jsonencode(local.values.ingress.listenPorts)
        "alb.ingress.kubernetes.io/ssl-redirect"= local.values.ingress.sslRedirect
        "external-dns.alpha.kubernetes.io/hostname" = local.values.externalDNS.hostname
      }
    }
    spec = {
      rules = [
        {
          host = local.values.ingress.host
          http = {
            paths = [
              {
                path     = "/"
                pathType = "Prefix"
                backend = {
                  service = {
                    name = kubernetes_service.flask_service.metadata[0].name
                    port = {
                      number = local.values.service.port
                    }
                  }
                }
              }
            ]
          }
        }
      ]
      tls = [
        {
          hosts      = local.values.ingress.tlsHosts
          secretName = "flask-app-tls"
        }
      ]
    }
  }
}
