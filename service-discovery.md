# Service Discovery
Consul has a DNS interface that to find the IP address of their upstream dependencies. 
The ways to registers are:
- Operators (manually)
- Configuration management tools (deploy)
- Container orchestration (automatically via integrations)

## Define a Service
Register by:
- Providing a service definition
- Making a HTTP API call

Run the agent and provide the definition:
```sh
consul agent -dev -enable-script-checks -config-dir=./consul.d
```

## Query a Service
Query the service by the DNS:
```sh
dig @127.0.0.1 -p 8600 <ServiceName>.service.consul
```

Use the flag `-advertise` for a more meaningful IP address.

To retrieve it with the pair **address/pair**:
```sh
dig @127.0.0.1 -p 8600 <ServiceName>.service.consul SRV
```

Use the HTTP API:
```sh
curl http://localhost:8500/v1/catalog/service/<ServiceName>
```

## Health checks
Add a check:
```sh
echo '{
  "service": {
    "name": "web",
    "tags": [
      "rails"
    ],
    "port": 80,
    "check": {
      "args": [
        "curl",
        "localhost"
      ],
      "interval": "10s"
    }
  }
}' > ./consul.d/web.json
```

This will create **a stanza check** that will try to connect via `curl` every 10 seconds.

You will need to reload the configuration:
```sh
consul reload
```

