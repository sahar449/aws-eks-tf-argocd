locals {
  values = {
    app = {
      name = "flask-app"
      port = 5000
    }
    image = {
      repository = "634647866665.dkr.ecr.us-west-2.amazonaws.com/eksdemo"
      tag        = "latest"
    }
    service = {
      type = "NodePort"
      port = 5000
    }
    ingress = {
      enabled     = true
      name        = "flask-ingress"
      namespace   = "default"
      host        = "www.saharbittman.com"
      scheme      = "internet-facing"
      targetType  = "instance"
      listenPorts = [{ HTTP = 80 }, { HTTPS = 443 }]
      sslRedirect = "443"
      tlsHosts    = ["*.saharbittman.com"]
    }
    externalDNS = {
      enabled  = true
      hostname = "www.saharbittman.com"
    }
  }
}
