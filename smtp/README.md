# SMTP

A mailcatch service, used as temporal SMTP server. You can access via HTTP to the port 1080 for read all emails the penpot platform has sent. Should be only used as a temporal solution meanwhile you don't have a real SMTP provider configured.

## Usage

```
SMTP_HOST=mailcatch
SMTP_PORT=1025
SMTP_USERNAME=
SMTP_PASSWORD=
SMTP_TLS=false
SMTP_SSL=false
```
