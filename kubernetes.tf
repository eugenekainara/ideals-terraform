resource "kubernetes_namespace" "test" {
  metadata {
    name = "test"
  }
}

resource "kubernetes_deployment" "test" {
  metadata {
    name = "test"
    namespace = kubernetes_namespace.test.metadata.0.name
    labels = {
      app = "test"
      application = "test"
    }

  }
  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "test"
      }
    }

    template {
      metadata {
        labels = {
          app = "test"
          application = "test"
        }
      }
      spec {
        container {
          image = "nginx"
          name  = "test"

          resources {
            limits {
              memory = "100Mi"
            }
            requests {
              memory = "100Mi"
            }
          }

          port {
            container_port = 80
            name = "http"
          }
          readiness_probe {
            http_get {
              path = "/"
              port = "http"
            }
            initial_delay_seconds = 10
            period_seconds        = 3
            failure_threshold     = 2
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "test" {
  metadata {
    name = "test"
    namespace = kubernetes_namespace.test.metadata.0.name
  }
  spec {
    selector = {
      app = "test"
    }
    port {
      port        = 80
      target_port = "http"
    }
    type = "LoadBalancer"
  }
}

output "url" {
  value = format("http://%s",kubernetes_service.test.load_balancer_ingress.0.hostname)
}
