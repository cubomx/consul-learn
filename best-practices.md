# Best practices

- A cluster of 3 or 5 servers is recommended.

## Naming conventions
A folder with the Consul configuration files should end with `.d`.
- `/etc/consul.d`
- `/consul.d`

## Running scripts
When enabling script checks avoid using `-enable-script-checks` because it may introduce a 
remote execution vulnerability (targeted by malware). Instead, use `-enable-local-script-checks`.

## [Prepared Query](https://www.consul.io/api-docs/query)
Define failover policies in a centralized way. Expose them using **Consul's DNS** 
interface & **Consul's APIs**. Can be applied to:
- Fully static lists of alternate DCs
- Fully dynamic polcies with Consul's [network](https://www.consul.io/docs/internals/coordinates)
- Auto determine next best DC to failover based on net round trip time.

Can be made specific to certains svcs & prepared query templates can allows 1 policy
to apply to many (or all svcs).

About:
- Defined at the **data center level**
- Invoked by apps to retrieve results
- Used to filter the results of a service request

Example:
```sh
curl http://127.0.0.1:8500/v1/query \
    --request POST \
    --data @- << EOF
{
  "Name": "banking-app",
  "Service": {
    "Service": "banking-app",
    "Tags": ["v1.2.3"]
  }
}
EOF
```

### Policy types
Options:
- `NearestN` (int: 0): forwared to up to nearest N other DCs
- `Datacenters` (array<string>:nil): fixed list

## TLS
When you set `verify_server_hostname` to true:
- It prevents a client from modifying its config & becoming a Consul server
- Ensure outgoing connections perform hostname verification
- The certificate hostname should match `server.<DC>.<Domain>`
