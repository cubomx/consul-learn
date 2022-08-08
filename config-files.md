# [Configuration Files](https://www.consul.io/docs/agent/config/config-files)
Uses:
- Setting up agent
- Checks
- Service definitions

## Important things to manage
- `addresses`: nested object. Setting bind addresses (dns, http/s, grpc).
- `audit`(E): configure a sink & filter audit logs.
- `bind_addr`
- `client_addr`
- `datacenter`
- `enable_agent_tls_checks`
-  `enable_local_script_checks`
- `license_path`(E)
- `partition`(E)
- `ports`: nested object. Bind ports.
- `segment`(E)
- `segments`(E)
- `server`
- `read-replica`

- `dns_config`
- `auto_encryption`
- `gossip_lan`
- `connect`
- `acl`
- `raft_boltdb`
- `serf_lan`
- `telemetry`: runtime telemetry
- `ui_config.enabled`
- `tls`

## [Consul Template](https://github.com/hashicorp/consul-template/blob/main/docs/templating-language.md)
Programmatic method for rendering config files from a variety of locations (also 
Consul KV). Not core feature. Use cases:
- **Update config files**: e. g. managing LBs
- **Discover data about Consul DC & service**: collect info about the services

Usage:
```sh
consul-template -templat <Template>:<FileToUpdate>