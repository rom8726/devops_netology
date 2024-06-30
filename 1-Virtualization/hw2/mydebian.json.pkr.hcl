source "yandex" "debian_docker" {
  disk_type           = "network-hdd"
  folder_id           = "b1gvd286fqo94k90g0kc"
  image_description   = "my custom debian with docker"
  image_name          = "debian-11-docker"
  source_image_family = "debian-11"
  ssh_username        = "debian"
  subnet_id           = "e9bpv92u3304ii696ihl"
  token               = "y0_AgAAAAAMAWNyAATuwQAAAAEFgt4vAADowfX61ptJe7qZKb33LDO1XMImUQ"
  use_ipv4_nat        = true
  zone                = "ru-central1-a"
}

build {
  sources = ["source.yandex.debian_docker"]

  provisioner "shell" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install ca-certificates curl",
      "sudo install -m 0755 -d /etc/apt/keyrings",
      "sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc",
      "sudo chmod a+r /etc/apt/keyrings/docker.asc",
      "echo \"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian bullseye stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null",
      "sudo apt-get update",
      "sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin",
      "sudo usermod -aG docker $USER",
      "sudo chmod 666 /var/run/docker.sock",
      "sudo useradd -m -s /bin/bash -G docker debian"
    ]
  }

}
