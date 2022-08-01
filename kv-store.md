# KV Store
The 3 ways to use it are:
- HTTP API
- Consul KV CLI
- Consul Web UI

## Get
To get the value of some path:
```sh
consul kv get <Path>
```

Get metadata of a path:
```sh
consul kv get -detailed <Path>
```

Get all the values in a Path (not leaf):
```sh
consul kv get -recurse <Path>
```
Or, all them:
```sh
consul kv get -recurse
```

## Put
Simplest way to add a value:
```sh
consul kv put <Path> <Value>
```

Indicating a flag (index):
```sh
consul kv put -flags=<Index> <Path> <Value>
```

## Update
Just use the same path with a new value (using `consul kv put`).

Atomic key updates (**Check & Set Operation**):
```sh
consul kv put -cas -modify-index=<ModifyIndex> <Path> <Value>
```
You must use the **ModifyIndex**

## Delete
Delete a specific value:
```sh
consul kv delete <Path>
```

Delete all values in a non-leaf path:
```sh
consul kv delete -recurse <Path>
```