# Create a web server
resource "digitalocean_droplet" "ss" {
    image = "ubuntu-19-04-x64"
    name = "ss-1"
    region = "sfo2"
    size = "s-1vcpu-1gb"
    tags = ["ss"]
}

resource "null_resource" "ss-setup" {
  provisioner "remote-exec" {
    inline = [
        "apt-get update",
        "apt-get install shadowsocks-libev",
    ]
  }
  depends_on = ["digitalocean_droplet.ss"]
}

resource "digitalocean_project" "blockade-buster" {
  name        = "blockade-buster"
  description = "A cluster runs shadowsocks."
  purpose     = "Service or API"
  environment = "Development"
  resources   = [
    "${digitalocean_droplet.ss.urn}"
  ]
}
