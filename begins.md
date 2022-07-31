## Consul agent
Avoid using `dev` mode in production. It is only intended for learning. It won't persiste data and will not 
be strongly secure.

See information about the members of the cluster:
```sh
consul members
```

See the detailed information about the members:
```sh
consul members -detailed
```

To have a consistent view of the cluster:
```sh
curl <HostName>:<port>/v1/catalog/nodes
```

Get all services with a specific name:
```sh
curl http://localhost:8500/v1/catalog/service/<ServiceName>
```

Get all services that are healthy:
```
curl http://localhost:8500/v1/catalog/service/<ServiceName>?passing
```


