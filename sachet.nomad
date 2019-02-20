job "sachet" {
  datacenters = ["[[env "DC"]]"]
  type = "system"
  group "sachet" {
    task "sachet" {
      artifact {
        source = "https://github.com/messagebird/sachet/releases/download/[[.sachet.version]]/sachet-[[.sachet.version]].linux-amd64.tar.gz"
      }
      template {
        data                = "[[env "SACHET-CONFIG"]]"
        destination         = "local/sachet.yml"
        change_mode         = "signal"
        change_signal       = "SIGHUP"
      }
      driver = "raw_exec"
      config {
        command = "sachet-[[.sachet.version]].linux-amd64/sachet"
        args    = ["-config", "local/sachet.yml"]
      }
      resources {
        cpu    = [[.sachet.cpu]]
        memory = [[.sachet.ram]]
        network {
          mbits = 10
          port "healthcheck" { static = [[.sachet.port]] }
        }
      }
      service {
        name = "sachet"
        tags = ["[[.sachet.version]]"]
        port = "healthcheck"
        check {
          name     = "alive"
          type     = "tcp"
          interval = "10s"
          timeout  = "2s"
        }
      }
    }
  }
}
