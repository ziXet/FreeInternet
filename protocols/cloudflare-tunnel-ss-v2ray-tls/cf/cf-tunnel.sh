#!/bin/bash

random_str=$(echo $RANDOM | md5sum | head -c 20; echo;)

tunnel_uuid=$(ls ~/.cloudflared/ | grep json | sed 's/.json//')

echo "current UUID " $tunnel_uuid
if [ -z "$tunnel_uuid" ]; then
  # create a new tunnel
  cloudflared tunnel create freeiran-$random_str

  # get the created tunnel UUID
  tunnel_uuid=$(ls ~/.cloudflared/ | grep json | sed 's/.json//')
  echo $DOMAIN
  echo $tunnel_uuid

  # add dns
  cloudflared tunnel route dns $tunnel_uuid $SUBDOMAIN

  if [ $? -ne 0 ]; then
    rm ~/.cloudflared/* -rf
    echo ">>>>>ERROR: Cannot create a new DNS route<<<<<"
    echo "Use one of the options below to fix:"
    echo "1. Go to Cloudflare dashboard and delete the DNS record manually and then docker-compose up -d --build"
    echo "2. Choose a new  subdomain in .env file and then run docker-compose up -d --build"
    exit 1;
  fi

  cp /config.yaml ~/.cloudflared/config.yaml

  sed -i "s/{subdomain}/"$SUBDOMAIN"/g" ~/.cloudflared/config.yaml
  sed -i "s/{tunnel_uuid}/"$tunnel_uuid"/g" ~/.cloudflared/config.yaml
  cat ~/.cloudflared/config.yaml
  echo "waiting for 3 seconds"
  sleep 3
fi
# run the cf tunnel
cloudflared tunnel run $tunnel_uuid

