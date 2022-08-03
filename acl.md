# [Access Control Lists](https://www.consul.io/docs/security/acl)
ACLs authenticate requests & authorize access to resources, Consul UI, API, CLI, service-service, 
agent-agent.

## Policy
Grouping 1+ authentication rules (grant/deny). Linked to a token.
![ACL](images/acl-structure.avif)


## [Rule](https://www.consul.io/docs/security/acl/acl-rules)
Composed of a resource declaration & access level defined:
```hcl
<Resource> "<Label>" {
    policy = "<PolicyDisposition>"
}
```

The next does not take a label:
- `acl`
- `keyring`
- `mesh`
- `operator`

Policy disposition:
- `read`
- `write`
- `deny`
- `list`: special for access to all keys (Consul KV)

Deny to a specific service:
```hcl
service "web-prod" {
  policy = "deny"
}
```

Allow write to all services beginning with a prefix:
```hcl
service_prefix "web" {
  policy = "write"
}
```

It can be empty and match all.

Create a policy:
```hcl
consul acl policy create -name "<NamePolicy>" -description "<Description>" -rules @rules.hcl -token "<Token>"
```

## [Token](https://www.consul.io/docs/security/acl/acl-tokens)
Core auth method. The most important attribute is `SecretID` (ACL Token). `AccesorID` may be used
for audit logging.

## [Roles](https://www.consul.io/docs/security/acl/acl-roles)
Collection of policies. It can be linked to a token. Reuse policies.

## Service Identities
Construct policies for services. Used during the authorization process.

## Node Identities
Linked token to policies for:
- Physical server
- Cloud instance
- VM
- Container