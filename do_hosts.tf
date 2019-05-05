# Create a web server
resource "digitalocean_droplet" "ss" {
  image = "ubuntu-19-04-x64"
  name = "ss-1"
  region = "sfo2"
  size = "s-1vcpu-1gb"
  tags = ["ss"]
  ssh_keys = "${var.do_ssh_keys}"
}

resource "null_resource" "ss-setup" {

  connection {
    type = "ssh"
    private_key = "${file(var.do_ssh_private_key)}"
    host = "${digitalocean_droplet.ss.ipv4_address}"
  }

  provisioner "file" {
    content = <<EOF
{
  "server": "0.0.0.0",
  "server_port": ${var.ss_server_port},
  "password": "${var.ss_password}",
  "timeout": ${var.ss_timeout},
  "nameserver": "8.8.8.8",
  "method": "${var.ss_method}"
}
EOF
    destination = "/etc/shadowsocks.json"
  }

  provisioner "remote-exec" {
    inline = [
        "apt-get update",
        "apt-get install -y shadowsocks-libev python rng-tools",
        "${local.setup_ss_config}",
    ]
  }

  provisioner "file" {
    content = <<EOF
[Unit]
Description=Shadowsocks proxy server

[Service]
User=root
Group=root
Type=simple
ExecStart=/usr/bin/ss-server -c /etc/shadowsocks.json -v start
ExecStop=/usr/bin/ss-server -c /etc/shadowsocks.json -v stop

[Install]
WantedBy=multi-user.target
EOF
    destination = "/etc/systemd/system/shadowsocks.service"
  }

  provisioner "remote-exec" {
    inline = [
      "systemctl daemon-reload",
      "systemctl enable shadowsocks",
      "systemctl start shadowsocks",
    ]
  }

  depends_on = ["digitalocean_droplet.ss"]
}

resource "digitalocean_project" "blockade-buster" {
  name        = "${var.do_project_name}"
  description = "A cluster runs shadowsocks."
  purpose     = "Service or API"
  environment = "Development"
  resources   = [
    "${digitalocean_droplet.ss.urn}"
  ]
}
