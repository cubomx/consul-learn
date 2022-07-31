# Best practices

- A cluster of 3 or 5 servers is recommended.

## Naming conventions
A folder with the Consul configuration files should end with `.d`.
- `/etc/consul.d`
- `/consul.d`

## Running scripts
When enabling script checks avoid using `-enable-script-checks` because it may introduce a 
remote execution vulnerability (targeted by malware). Instead, use `-enable-local-script-checks`.