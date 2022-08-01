#!/bin/bash
PORT=9002 COUNTING_SERVICE_URL="http://localhost:5000" ./dashboard-service_linux_amd64 \
    & PORT=9003 ./counting-service_linux_amd64 \
    & consul connect envoy -sidecar-for counting-1 -admin-bind localhost:19001 > counting-proxy.log \
    & consul connect envoy -sidecar-for dashboard > dashboard-proxy.log &