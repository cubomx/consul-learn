FROM envoyproxy/envoy:v1.22-latest as envoy-bin

FROM consul as consul-bin

FROM ubuntu 

COPY . .

ENV CONSUL_HTTP_ADDR=http://localhost:8500

RUN apt-get update && \
    apt-get install -y \
      bash \
      curl \
      jq && \
    rm -rf /var/lib/apt/lists/*

COPY --from=envoy-bin /usr/local/bin/envoy /bin/envoy
COPY --from=consul-bin /bin/consul /bin/consul

RUN chmod u+x ./init-services-sidecars.sh


CMD consul agent -dev -node machine -config-file=./dashboard.hcl -config-file=./counting.hcl
