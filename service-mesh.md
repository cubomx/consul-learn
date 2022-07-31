# Service Mesh
It **secures** service-to-service communication with: 
- **Authorization**
- **Encryption**

Apps can use **sidecar proxies** to auto-establish *TLS* (in, out conns) without be aware of net 
config & topology.

A service mesh can also **intercept data service-to-service communications** and surface it to 
monitoring tools (**[observability](https://learn.hashicorp.com/tutorials/consul/kubernetes-layer7-observability)**).

## Intentions
You can use **[intentions](https://www.consul.io/docs/connect/intentions)** to define *access 
control* via **Connect** (authorization policies). Used to control which services may:
- Establish connections
- Make requests

Can be managed via:
- API
- CLI
- UI

[Default policy](https://www.consul.io/docs/agent/options.html?_gl=1*1mosxg3*_ga*NzAxNTk3ODMyLjE2NDM4MTY1NjI.*_ga_P7S46ZYEKW*MTY1OTI5MTMxMy4xOS4xLjE2NTkyOTE0NjEuMA..#acl_default_policy)

Using explicit intention helps **protect** your services **against changes to the implied permissions**.

To initialize intention rules file:
```sh
consul config write <IntentionFile>
```

## Register service
Ways:
- Directly from a **Consul-aware app**
- Orchestrator (Nomad, K8s)
- Config files
- API (JSON/HCL)
- CLI

CLI:
```sh
consul services register <File>
```

List all services registered:
```sh
consul catalog services
```