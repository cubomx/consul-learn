# [Architecture](https://www.consul.io/docs/architecture)

## Arch
The **leader** is reponsible for processing all:
- Queries
- Transactions (Replicated to all peers**consensus protocol**)

Also, for ingesting new log entries, replicating to followers, and managing when a 
entry is considered commited. 

**Cluster state** is maintain in **[MemDB](https://github.com/hashicorp/go-memdb)**.

## [Bootstrapping](https://www.consul.io/docs/install/bootstrapping)
**Bootstrap mode** is on when a single Consul server is getting started to get 
self-elect. Other server nodes are added to the cluster.

The `-bootstrap-expect` option informs Consul of the expected # of serv nodes. 

You can connect servers by:
- **Automatically**: 
    - List of serverss with `-join`, `star_join` options
    - With the `-retry-join` option
    - Automatic joining by tag with `-retry-join` option
- **Manually**:
    - `consul join <NodeAAddress> ... <NodeCAddress>`


## [Gossip Protocol](https://www.consul.io/docs/architecture/gossip)
Manage membership, broadcast messages (**[Serf library](https://www.serf.io)/**).

Pools:
- **LAN**: each datacenter (clients & servers). Part of a single **Raft peer set**
    - Membership info: discover servers
    - Failure detection
    - Fast & reliable event broadcasts (leader election)
- **WAN**: globally unique. All servers participate.
    - Membership info: cross-datacenter reqs
    - Failure detection: gracefully handle loss of connectivity

It a server receives a reques for a diff datacenter, it forwards it to a random server 
in the correct datacenter (that server may then forward to the local leader). 

Data is not replicated. A local Consul server is going to forward an RPC request to the
remote Consul servers for that information.

## [Consensus protocol](https://www.consul.io/docs/architecture/consensus)
Raft is a consensus algorithm (based on Paxos). Terms:
- **Log**: replicated. Ordered sequence of entries (cluster changes). Consistent when
all members aggree on the entry.
- **FSM (Finite State Machine)**: An app must result in the same state if a same 
sequence of logs is present.
- **Peer set**: all members in log replication.
- **Quorum**: majority of members. At least (N/2) + 1.
- **Commited Entry**: durably stored, then it can be applied.

If a RPC request is:
- Query: leader generates result based on the current state of the FSM
- Transaction: it modifies state, leader generates new log and applies it using Raft.

### Consistency Modes 
- **default**: leader can be partitioned from the remaining peers and a new leader may 
be elected. Fast, strongly consistent, rarely stale.
- **consistent**: leader has to verify with a quorum of peers.
- **stale**: any server can read regardless of whether it is the leader. It may contain
stale values.