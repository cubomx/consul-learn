# Fun Facts
- Consul Template & Envoy Consul does not need a cluster to operate.
- Non-voting member does not participate in raft quorum, can be automatically promoted to voting
member, still receives replicated data.
- CA: built-in Consul CA, Vault, AWS ACM Private CA
- If Consul does not return a DNS lookup:
    - No healthy instances
    - Not registered services
    - Health check failed