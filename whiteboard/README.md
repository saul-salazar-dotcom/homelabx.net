# whiteboard

Powered by [AFFiNE](https://affine.pro/) and [Docker Compose](https://docs.docker.com/compose/).

## Removing limitations

```sh
docker compose exec -it postgres psql -U affine

# first get the feature ID
select feature_id from user_features;

# then get the config json from the previous ID
select id, feature, configs from features;
# it may look like this:
# 8 | free_plan_v1         | {"name":"Free","blobLimit":10485760,"storageQuota":10737418240,"historyPeriod":604800000,"memberLimit":3}

# The following command will update the admin and free plan:
# 100MB file size limit, 100GB storage and up to 10,000 members per workspace
update features set configs = '{"name":"Admin","blobLimit":104857600,"businessBlobLimit":104857600,"storageQuota":107374182400,"historyPeriod":604800000,"memberLimit":10000}' where id = 7;
update features set configs = '{"name":"Free","blobLimit":104857600,"storageQuota":107374182400,"historyPeriod":604800000,"memberLimit":10000}' where id = 13;

# After that you need to restart the container
docker compose restart affaine
```
