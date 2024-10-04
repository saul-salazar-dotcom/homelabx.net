# homelabX.net

Setup a homelab in a single command line.

## 🚀 Features
- 😎 EASY SETUP: copy & paste one line
- 👌 EASY ACCESS: SSO & MFA enabled by default
- 🛡️ LOCAL HTTPS: SSL Certificates for localhost
- 🎁 APPLICATIONS: Over 10 apps as containers

## ⚡ Quick Start
```sh
git clone https://github.com/saul-salazar-dotcom/homelabx.net.git
cd homelabx.net
./start.sh
```

### Notes
- Penpot SSO with OIDC doesnt work because it fails an strict SSL validation. [source](https://github.com/penpot/penpot/issues/3393#issuecomment-1630937925).
- AFFiNE SSO with OIDC isnt implemented yet and its on low priority by the devs [source](https://github.com/toeverything/AFFiNE/issues/6464).
