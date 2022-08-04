# Fun Facts
- Consul Template & Envoy Consul does not need a cluster to operate.
- Non-voting member does not participate in raft quorum, can be automatically promoted to voting
member, still receives replicated data.
- CA: built-in Consul CA, Vault, AWS ACM Private CA
- If Consul does not return a DNS lookup:
    - No healthy instances
    - Not registered services
    - Health check failed
- To interact with the Raft's subsystem `consul operator raft`; to get the types of members 
`consul operator raft list-peers`
- If you are using a cloud provider for the servers `"retry_join": ["provider=aws tag_key=consul tag_value=true"]`, you can are using `cloud auto-join`.
- If you get info about a cluster without using a token, the 2 reasons are:
    - Token already set using the `CONSUL_HTTP_TOKEN` env variable
    - Anonymous token permits this

## Scripting
This is a prepared query, so to access the service by the next configuration:
```json
{
  "Name": "retail-app",
  "Service": {
    "Service": "inventory-app",
    "Tags": ["v1.2.3"],
    "Failover": {
      "Datacenters": ["dc2", "dc3"]
    }
  }
}
```

There are 2 ways:
```
retail-app.query.consul
```
Without taking in account the query:
```
inventory-app.service.consul
```

In the next prepared query, Consul will try to find a healthy instance locally. Then, it will start
with the first DC failover (**dc2**) and, finally, with **dc3**.
```json
{
  "Name": "banking-app",
  "Service": {
    "Service": "banking-app",
    "Tags": ["v1.2.3"],
    "Failover": {
      "Datacenters": ["dc2", "dc3"]
    }
  }
}
```