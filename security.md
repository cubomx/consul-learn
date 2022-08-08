# Securiy

## [Core](https://www.consul.io/docs/security/security-models/core)
You must implement **defense in depth**.
You must have (generally):
- **mTLS**: mutual authentication for both the TLS server & client x509 certificates to prevent
internal abuse
- **ACLs**: RBACs for authenticated conns by granting capabilities via an ACL token to
authorize actions within a cluster to (def):
    - Human
    - Machine operator identity
- **Namespaces (E, HCP)**: `rw` operations can be scoped to restrict access to Consul components
within a multi-tenat env
- **Sentinel Policies (E, HCP)**: granular control over the built-om KV store


### Personas
- SysAdmin: Administrative rights, totally trusted
- Consul Admin: 
    - Define Consul agent configs (server & clients)
    - Consul management ACL token
    - Access to all paths 
    - Manage all services
- Consul Operator: restricted capabilities
- Developer: limited capabilities to view Consul info (metrics, logs)
- User: not network acces to the Consul agent APIs

## ACL
System:
- Token: API key associated with **policies, roles, or service identities**
- Policy: Set of rules (grant/deny) to access to Consul resources
- Role: Grouping of policies, & service identities
- Service/Node Identity: Predefined set of permissions typical for services deployed within
Consul
- Namespace: logical scoping, enable multi-tenant

## Gossip Encryption
Shared, based64-encoded 32-byte symmetric key (to *encrypt Serf gossip communication*). It uses AES
GCM. 32-byte keys are preferred. **SHOULD BE ROTATED**

## Other recommendations
- Don't use the `enable-script-checks` use the `enable-local-script-checks`
- Remote exec should not be enabled.
- Don't run as root
- Customize TLS settings (version, ciphers)
- Customize HTTP Response Headers
- Secure UI access
    - TLS
    - ACL
    - Extra tooling: mTLS


## Threat Model
- Transport encryption
- Encrypted communication of server with CA authority
- Tampering (manipulation) should be detectable and avoid requests from it
- DDoS to a node shouldn't be a problem
- Connected services should be secure from eavesdropping. mTLS, authentication

## [Network Infrastructure Automation](https://www.consul.io/docs/security/security-models/nia)
Enables dynamic updates to net infra devices triggered by service changes. It implements CTS 
(Consul-Terraform-Sync), utilizes Consul as a `data source` that contains 
- Net info about services
- Monitors those services

It will execute 1+ automation tasks with the most recent variables values. Each one is a runbook
written as a CTS compatible Terraform module.

Requirements:
- Create NIA user & group with limited permission (directories), files permissions appropiately 
scoped.
- Protect Consul KV Path or Namespaces (limited with ACL)
- Use Consul ACLs: restrict access to the required parts
    - RW KV specific path, namespace
    - R for Consul Catalog
    - RW to update health checks (NIA monitoring)

Recommendation:
- Hardened, dedicated host for supporting sensitive operations
- Not administrative privileges
- Protect endpoints with Consul Connect & firewall rules
- Export logs to a centralized entity
- Audit used Terraform providers