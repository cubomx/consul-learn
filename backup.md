# Backup

## Consul Snapshot (Consul 0.7.1+)
`consul snapshot` command has subcommands for:
- Saving
- Restoring
- Inspecting

Include:
- KV entries
- Service catalog
- Prepared queries
- Sessions
- ACLs

Access:
- CLI
- HTTP API

Create a snapshot and save it:
```sh
consul snapshot save <FileName>.snap
```

Restore from a file:
```sh
consul snapshot restore <FileName>.snap
```

Inpect from a file:
```sh
 consul snapshot inspect <FileName>.snap
```

Run a daemon process that periodically saves snapshots (this is a Consul Enterprise feature):
```sh
consul snapshot agent
```

## Modes
By default, snapshosts are taken using `consistent` so the leader is verified before 
taking the snapshot. To reduce the burden on the leader, you can use `stale` to run the
snapshot on any non-leader server.

## [Snapshot Agent](https://www.consul.io/commands/snapshot/agent)
Start a process that takes snapshots of the state of the Consul servers and save them:
- Locally
- Optional remote storage service

Two types of running:
- **Long-running**
- **One-shot mode** from a batch job (`-interval` arg). If is from a remote DC this is the
only way.

The agent will perfoma a *leader election* (multiple processes can be run in a HA with
automatic failover). The agent will register itself as a **services** with 2 health 
checks:
- `Consul Snapshot Agent Alive`
- `Consul Snapshot Agent Saving Snapshots` (onlu on leader)

You need the following permission for ACL:
| resource | segment | permission | 
| -------- | ------- | ---------- |
| `acl` | | w |
| `key` | `\<lock key>` | write |
| `session` | `\<session>` | write |
| `service` | `\<service name>`| write |


Example:
```hcl
# Required to read and snapshot ACL data
acl = "write"
# Allow the snapshot agent to create the key consul-snapshot/lock which will
# serve as a leader election lock when multiple snapshot agents are running in
# an environment
key "consul-snapshot/lock" {
  policy = "write"
}
# Allow the snapshot agent to create sessions on the specified node
session "server-1234" {
  policy = "write"
}
# Allow the snapshot agent to register itself into the catalog
service "consul-snapshot" {
  policy = "write"
}
``