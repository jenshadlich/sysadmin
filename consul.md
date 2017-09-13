# Consul

## Redis

Copy to `/etc/consul.d/client/redis.json`. `consul reload`.

```
{
  "service": {
    "name": "redis",
    "tags": ["redis"],
    "address": "",
    "port": 6379,
    "enableTagOverride": false,
    "checks": [
      {
        "id": "redis-tcp",
        "tcp": "localhost:6379",
        "interval": "10s",
        "timeout": "1s"
      }
    ]
  }
}
```
