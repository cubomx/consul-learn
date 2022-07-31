# Consul

## Service Mesh
Dedicated layer that **provides service-to-service communication** for:
- On-premises
- Cloud
- Multi-cloud

Typically consist of:
- **Control/Central plane**: central registry, tracking all services and their respective IP addresses 
(**service discovery**). While an app is registered, this will be able to share to other members of the 
SM how to communicate with the app and enforce rules who can communicate. **RESPONSIBILITIES**: securing 
the mesh, *faciliting* service discovery, health checking, policy *enforcement*.
- **Data plane**: handles communication between services. Many SM solution use a sidecar proxy to handle 
this, limiting the level of awareness the services need.

## What is Consul?
It is the control plane of the SM. Multi-net tool that offers a fully-featured SM solution that *solves the net & security* challenges of operating microservices & cloud infra. Softwared-driven approach to 
**routing & segmentation**. Other benefits:
- Failure handling
- Retries
- Network observability

You can use it with (it is platform):
- VMs
- Containers
- Container orchestration platforms (Nomad, K8s)

Components:
- Registry
- KV (e.g. maintenace mode)
- Connect (connections between types of services, not IPs)
    - TLS to authenticate the service (know who it is) and identify them
    - Proxies, mutual. For enabling the communication. They are using the TLS certificates
    - Encrypt data at rest and transit
    - After the proxies authenticate between them, they need to check the **Service graph** to see if 
    there exist a rule that allow communication & traffic between them

Pillars of Service Mesh (SM):
- Discovery
- Configuration
- Segmentation

## Architecture
It is a distributed system designed to run on a **cluster of nodes**. Each node may be:
- Physical server
- Cloud instance
- VM
- Container

Connected set of nodes running Consul are called *datacenter*. It will have 3 to 5 servers & many clients. Consul is available as a single binary & can be run as a long running daemon.

**Consul agent** (node) runs the binary. Two modes: *server* or *client*. **Server agents** maintain a *consistent state* for Consul. The responsibilites are:
- Keep track of **available services**, their IP addresses and their current health and status
- Keep track of **availale nodes**, their IP addresses and " "
- Build a **service catalog** (DNS), aware of the service & nodes availability
- Maintain & update the **K/V store**
- **Communicate updates** to all agents (gossip protocol)

**Clients** are a *lightweight process* that runs on every node where services are running. You may use 
[**Envoy**](https://www.envoyproxy.io). This is a sidecar.

## Data plane
Supported & owned by the proxies. Proxy are in charge of:
- Open ports & direct traffic from the app to other microservices
- Receive traffic & direct this traffic back to the application

The **client** keeps the proxy *up-to-date* with info about the SM:
- Service discovery: Service's availability (health checks)
- Service mesh: if app can communicate with others (queries to servers)

## Installation
[Consul](https://learn.hashicorp.com/tutorials/consul/get-started-install?in=consul/getting-started)

