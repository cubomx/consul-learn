# ACL
Add the ACL config to your agent config:
```hcl
acl = {
  enabled = true
  default_policy = "deny"
  enable_token_persistence = true
}
```

## Add token to agent
```hcl
consul acl set-agent-token agent "<AgentToken>"
```

## Keep the same privileges as another token
```hcl
consul acl token clone -description "<Description>" -id <Id>
```

## Delete token
```hcl
consul acl token delete -id <Id>
````