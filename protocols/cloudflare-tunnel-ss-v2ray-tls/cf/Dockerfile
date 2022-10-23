FROM ubuntu:20.04

RUN apt update && apt install -y curl

# Add cloudflare gpg key
RUN mkdir -p --mode=0755 /usr/share/keyrings
RUN curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg | tee /usr/share/keyrings/cloudflare-main.gpg >/dev/null

# Add this repo to your apt repositories
RUN echo 'deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared focal main' | tee /etc/apt/sources.list.d/cloudflared.list

RUN apt update && apt install -y cloudflared && mkdir /root/.cloudflared -p

# copy domain cert.pem
COPY ./cert.pem /root/.cloudflared/cert.pem
# copy tunnel config yaml file
COPY ./config.yaml /config.yaml
# copy tunnel creation script
COPY ./cf-tunnel.sh /cf-tunnel.sh