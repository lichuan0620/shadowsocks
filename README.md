# Deploy Shadowsocks with OBFS

Because a simple Shadowsocks server is no longer stealthy enough. Obscure it with OBFS!

## How to Use

#### Rent a server

AWS the is reliable, robust solution, but requires a bit more work to set up. I recommend Vultr or other VPC providers.

1 core for CPU and 1 GiB for memory is enough for personal use. For operating system, choose Ubuntu 18.04 to benefit from the modern kernel and network config. For other Linux distributions, you might want to upgrade the kernel and enable stuffs like BBR.

#### Prerequisites

Install Docker and other prerequisites. Assuming you chose Ubuntu as instructed:

```
{
sudo apt update -y
sudo apt install -y \
        build-essential \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg-agent \
        software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"
sudo apt update -y
sudo apt install -y docker-ce docker-ce-cli containerd.io
sudo systemctl start docker
sudo systemctl enable docker
}
```

#### Profit

Git clone this repo and profit. The Makefile should be self-explanatory. Here is an sample script to get started:

```
# build the image
sudo make build

# initialize docker swarm; required to run the container in service (recommended)
sudo docker swarm init

# default setting should be fine but at least change the password
# if your VPS has multiple cores, set REPLICAS to core count + 1 for optimal performance
PASSWORD=Pwd123456 sudo -E make run-service
```
