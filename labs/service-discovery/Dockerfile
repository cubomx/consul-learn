FROM consul

COPY ./consul.d ./etc/consul.d


CMD consul agent -dev -enable-script-checks -config-dir=/etc/consul.d