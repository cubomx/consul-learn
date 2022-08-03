# [Server configuration](https://learn.hashicorp.com/tutorials/consul/add-remove-servers#add-a-server-with-agent-configuration)

## Manually adding a new server
You should type the following command to add a new server:
```sh
consul agent -server
```

If it ask for a `-data-dir`, you can write something like the following:
```sh
consul agent -server -data-dir=./data
```

Agent won't be part of any DC, so the console should emit something like:
```
[WARN]  agent.server.raft: no known peers, aborting election
```

Join any member:
```sh
consul join <NodeAddress>
```

## With agent configuration
You can use the `retry_join` in CLI as a flag or in the agent configuration file. It 
will ensure that if any server losses connection with the DC, it can rejoin when it 
comes back. This is for static IPs. You use **auto joining** based on cloud metadata
& discovery.

CLI:
```sh
consul agent -retry-join=52.10.110.11 -retry-join=52.10.110.12 -retry-join=52.10.100.13
```

HCL:
```hcl
bootstrap = false,
bootstrap_expect = 3,
server = true,
retry_join = ["52.10.110.11", "52.10.110.12", "52.10.100.13"]
```