
# cloudflare-tunnel-ss-v2ray-tls
By using this approach you can setup a shadowsocks+v2ray VPN that uses your ISP as a server to bypass the filtering.

It uses Cloudflare tunnel to route the traffic to your local computer.

## Requirements
1. A high-speed and unlimited(preferred) internet at home/office
2. A Linux machine (e.g. Ubuntu 20.04)
3. A domain name that you own
4. A moderate knowledge in Linux

## Limitations
You must keep your computer running all the time.

## Setup guide

### 1. Prepare

1. Buy a cheap domain for 2 dollars.
2. Have docker and docker-compose installed
3. Create a Cloudflare account.
---

### 2. Cloudflare setup

4. Log in to the Cloudflare account and follow the tutorial to connect your name domain to Cloudflare https://developers.cloudflare.com/fundamentals/get-started/setup/add-site/
5. After setting your new domain nameservers to Cloudflare, open this page: https://dash.cloudflare.com/argotunnel
6. Select your domain and click on "Authorize", It will download a cert.pem file for your domain.
6. Copy the cert.pem file to the protocols/cloudflare-tunnel-ss-v2ray-tls/cf directory

### 2. Local setup

5. Edit the `.env` file.

```bash
# Replace <domain-name> with the domain you bought and a replace <subdomain> with a preferred subdomain
# Example: test.my-cool-domain.com
SUBDOMAIN=<subdomain-name>.<domain-name>

# change to a secure password
PASSWORD=some-strong-password
```

6. Run the containers:

Make sure that you are in protocols/cloudflare-tunnel-ss-v2ray-tls path. Run the following command.
```bash
docker-compose up -d
```

7. Since the container is running in detached mode, you need to check the logs to see the config for your VPN server. (Android and iOS urls)

```bash
docker-compose logs -f --tail 500
```

### 4. Share

1. Congratulations! Your server is running now. You can share the URLs with your family, friends and people you trust. You can share [this guide](../../guides/shadowsocks-v2ray-tls/how-to-connect.md) for them to start using your VPN server.
2. Alternatively, you can open a pull request to [this file](../../guides/shadowsocks-v2ray-tls/CONFIGS.md) to share your server config on this repository so more people can utilise it.
