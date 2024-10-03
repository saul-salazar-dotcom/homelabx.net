# traefik proxy

Powered by [Traefik Proxy](https://traefik.io/) and [Docker Compose](https://docs.docker.com/compose/).

This traefik is for local development purposes. Includes HTTPS support on localhost with [mkcert](https://github.com/FiloSottile/mkcert).

## Quick Start

```sh
# update to match your domain name
MKCERT_DOMAINS="homelab.com,*.homelab.com"

# create certificates
docker compose start mkcert

# copy and install certificates (linux)
cp certs/rootCA /usr/local/share/ca-certificates/
sudo update-ca-certificates

# start containers
docker compose up -d
```

## Firefox

In case you get the error `SEC_ERROR_UNKNOWN_ISSUER`, you need to import the CA file manually, this is how to fix it: ([source](https://github.com/FiloSottile/mkcert/issues/370))

- Open the Firefox Preferences
- Enter certificates into the search box on the top
- Click `View Certificates...`
- Select the tab `Authorities`
- Click to Import...w
- Go to the folder where your root certificate authority was stored (~/.local/share/mkcert)
- Select the file rootCA.pem
- Click to Open
- Check mark the `This certificate can identify websites.`
- Click OK twice and its done.
