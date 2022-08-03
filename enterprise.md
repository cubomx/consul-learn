# Consul Enterprise features
HCP -> HashiCorp Cloud Platform

## Multi-Tenancy
**[Admin Partitions](https://www.consul.io/docs/enterprise/admin-partitions) (HCP 1.11.0+)**: define administrative boundaries between tenants within a single
Consul datacenter for services managed by separate teams/stakeholders. They exist 
above **namespaces** in the identity hierarchy. Contain 1+ namespaces. It allows 
multiple independent tenants to **share a Consul server cluster**. 

**[Namespaces](https://www.consul.io/docs/enterprise/namespaces) (HCP, Consul Enterprise 1.7.0+)**: data for diff users/teams can be
isolated from each other. It helps with:
- Reducing operational challenges by **removing restrictions around uniqueness of** 
**resources names** across distinct teams
- Enable operators to provide **self-service through delegation of administrative**
**privileges**

Managed through the **HTTP API** or **Consul CLI**.

## Resiliency
**[Automated Backups](https://www.consul.io/docs/enterprise/backups) (HCP)**: run the snapshot agent within your environment as a 
service (e. g. **Systemd**) or scheduled. HA. Integrate with the snapshot API to 
manage:
- Taking snapshots (atomic & point-in-time)
    - KV Store, Service registrations, Prepared queries, Sessions, ACLs, Namespaces
- Backup rotation
- Sending backup files offsite to Amazon S3 or compatible 

**[Redudancy] (https://www.consul.io/docs/enterprise/redundancy) (Only Enterprise)**:
Scaling. Enabling the deployment of non-voting servers (with the potential of becoming
voting).

## Scalability
**[Read Replicas](https://www.consul.io/docs/enterprise/read-scale) (HCP)**: include
read replicas. They receive data but do not take part in quorum.

## Operational Simplification
**[Automated Upgrades](https://www.consul.io/docs/enterprise/upgrades) (HCP)**: new 
servers with newer versions join the cluster. When a equal # of servers are running, 
the lower versioned will be demoted to non voting.

**[Consul-Terraform-Sync Enterprise](https://www.consul.io/docs/nia/enterprise)**:
- Collaboration (history, triggers, notifications)
- Operations (audit -> Terraform)
- Scale
- Governace (Sentinel)

Integration.

## Complex Network Topology Support
**[Network Areas](https://www.consul.io/docs/enterprise/federation)**: allows operators to federate Consul DCs together on pairwise basis,
enabling partially-connected network topologies. This is if you want to don't have 
full mesh (WAN) connectivity.

**[Network Segments](https://www.consul.io/docs/enterprise/network-segments)**: Consul requires full mesh connectivity within the DC (default). You may need to enforced policies through network rules of firewalls. To use Consul in 
such network, you must break up the **LAN gossip pool** into separate "network segments" (isolated).

## Goverance
**[OIDC Auth Method](https://www.consul.io/docs/security/acl/auth-methods/oidc) 
(**Enterprise 1.8.0+**): allows authentication via a configured OIDC provider using
the user's web browser (initiated by UI or CLI).

**[Audit Logging](https://www.consul.io/docs/enterprise/audit-logging)(HCP, Enterprise 1.8.0+)**: capture clear & actionable log of 
authenticated events (*attempted & committed*) via HTTP API. Compiled them into a JSON
format for export. Contains:
- Timestamp
- Operation perfomed
- User

**[Sentinel for KV](https://www.consul.io/docs/enterprise/sentinel)(HCP)**: extend the ACL system beyond `read`, `write`, `deny` to support full conditional logic & 
integration with external systems.