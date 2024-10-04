Setup a homelab in a single command line.

## 🔥 QUICK START

```sh
curl -fsSL https://raw.githubusercontent.com/saul-salazar-dotcom/homelabx.net/master/install.sh | sh
```

## 🚀 FEATURES

- 😎 EASY SETUP: copy & paste one line
- 👌 EASY ACCESS: SSO & MFA enabled by default
- 🛡️ LOCAL HTTPS: SSL Certificates for localhost
- 🎁 APPLICATIONS: Over 10 apps as containers

## 📦 APPLICATION LIST

### ▶️ MEDIA
- [📺 tv](https://tv.homelab.com) Stream movies and shows by [Jellyfin](https://jellyfin.org) (netflix, disney+)
- [📺 downloads](https://downloads.homelab.com) Multiple downloads manager by [JDownloader](jlesage/jdownloader-2)
- [📺 torrents](https://torrents.homelab.com) Torrents downloads manager by [QBitTorrent](https://www.qbittorrent.org)

### 📄 DOCUMENTATION
- [📕 notes](https://notes.homelab.com) Write notes by [memos](https://www.usememos.com)
- [🆕 changelog](https://changelog.homelab.com) Write release notes by [OpenChangelog](https://openchangelog.com)
- [📚 wiki](https://wiki.homelab.com) Write documentation with realtime collaboration by [Outline](https://www.getoutline.com) (confluence, notion)
- [🖍️ whiteboard](https://whiteboard.homelab.com) Write & draw with realtime collaboration by [AFFiNE](https://affine.pro) (miro, nuclino, mural)

### 🛠️ TOOLS

- [🎨 design](https://design.homelab.com) Build interactive prototypes by [Penpot](https://penpot.app) (figma, adobe xd)
- [🧐 read](https://read.homelab.com) Save links to read later by [Readeck](https://readeck.org)
- [📅 schedule](https://schedule.homelab.com) Create scheduling polls by [Rallly](https://rallly.co/)
- [📋 plan](https://plan.homelab.com) Project Management (kanban,list,gantt) by [vikunja](https://vikunja.io)

### 🏗️ INFRASTRUCTURE
- [🔀 proxy](https://proxy.homelab.com) Reverse Proxy by [Traefik](https://traefik.io) and [mkcert](https://github.com/FiloSottile/mkcert)
- [🔐 auth](https://auth.homelab.com) Single Sign On and Multi Factor Authentication by [Authelia](https://www.authelia.com)
- [✉️ smtp](https://smtp.homelab.com) Catches and displays email by [mailcatcher](https://github.com/sj26/mailcatcher)

---

## 🎯 ROADMAP

- [📈 uptime](https://uptime.homelab.com) Uptime monitoring tool by [Uptime Kuma](https://uptime.kuma.pet)
- [🔔 ntfy](https://ntfy.homelab.com) Push notifications by [ntfy](https://ntfy.sh)
- [🌎 vpn](https://vpn.homelab.com) Network Security (VPN) by [Firezone](https://firezone.dev)
- [📰 rss](https://rss.homelab.com) News aggregator by [FreshRSS](https://freshrss.github.io/FreshRSS)
- [📊 grafana](https://grafana.homelab.com) Monitoring dashboards by [Grafana](https://grafana.com)
- [🐋 docker](https://docker.homelab.com) Docker Management GUI by [Portainer](https://www.portainer.io)
- [💬 forum](https://misago.homelab.com) Discuss/debate topics by [Misago](https://github.com/rafalp/Misago)
- [🔀 workflow](https://workflow.homelab.com) Data pipelines automation [Windmill](https://www.windmill.dev)
- [🍽️ recipes](https://recipes.homelab.com) cooking recipes by [Mealie](https://mealie.io)
- [🛰️ remote](https://remote.homelab.com) Remote Device Management by [MeshCentral](https://meshcentral.com)
- [💻 support](https://support.homelab.com) Remote Device Control by [RustDesk](https://rustdesk.com) (teamviewer)
- [📈 tickets](https://tickets.homelab.com) support/ticketing solution by [Zammad](https://zammad.org) (jira)
- [🖵 pgadmin](https://postgres.homelab.com) Postgres management tool by [PgAdmin](https://www.pgadmin.org)
- [🛠️ pocketbase](https://pocketbase.homelab.com) Backend with DB, auth and file storage by [PocketBase](https://pocketbase.io) (firebase, supabase)

## 🧐 LEARN MORE
You should read the Docker Compose specification to know how this works.

- [Why use Compose?](https://docs.docker.com/compose/intro/features-uses/)
- [Compose Application Model](https://docs.docker.com/compose/compose-application-model/)

### ⭐ KEY CONCEPTS

- We follow the KISS principle (**Keep it simple, stupid!**)
- Each application consists of minimum 3 things:
    1. Folder with an *Useful Name*
    1. `docker-compose.yml` file
    1. `README.md` file.
- An Useful Name has:
    - `-` hyphens instead of whitespaces
    - keyword (s) to describe the app (for example jellyfin app has the tv folder)
- If possible we skip the `.env` files.
- No version declaration at the beginning of the compose file, as the practice was deprecated.
- For persistent storage bind mount `./data_whatever` is used. Only relative path next to the compose file.

## 🐋 REQUIREMENTS

The only requirement is **Docker**, which has multiple installation methods depending on your platform:

- First the [Official Guides](https://docs.docker.com/engine/install/).
- Linux and Mac [(ref)](https://github.com/docker/docker-install):
```sh
curl -fsSL https://get.docker.com | sh
```
- Windows needs the **Docker Desktop** application and WSL enabled (Windows Subsystem for Linux) because the Docker Engine doesnt have Windows Support.
