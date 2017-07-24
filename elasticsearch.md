# Elasticsearch - some useful commands

## Basic health & info

```
curl -XGET localhost:9200/_cluster/health
curl -XGET localhost:9200/_cluster/settings
curl -XGET localhost:9200/_template?pretty
curl -XGET 'localhost:9200/_cat/nodes?v'
```

## Allocation
```
curl -XPUT localhost:9200/_cluster/settings -d '{
    "transient" : {
        "cluster.routing.allocation.disk.threshold_enabled" : false
    }
}'
```

```
curl -XGET 'localhost:9200/_cluster/allocation/explain' -d'{
  "index": "<index-name>",
  "shard": 0,
  "primary": false
}'
```

```
curl -XGET 'localost:9200/_cat/shards?h=index,shard,prirep,state,unassigned.reason' | grep UNASSIGNED
```

```
curl -XPOST 'localhost:9200/application/_flush/synced'
```

```
curl -XPOST 'localhost:9200/_cluster/reroute?dry_run' -d '{
    "commands" : [ {
          "allocate" : {
              "index" : "<index-name>", "shard" : <shard-id>, "node" : "<node-name>", "allow_primary": "true"
          }
        }
    ]
}'
```

```
curl -XPUT 'localhost:9200/_cluster/settings' -d '{
        "transient" : {
            "cluster.routing.allocation.enable" : "all"
        }
}'
```
## Recovery

```
watch -n 10 -d 'curl -s -XGET http://localhost:9200/_cat/recovery | sort | grep index'
```
