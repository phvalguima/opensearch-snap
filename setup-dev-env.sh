#!/usr/bin/env bash


function connect_interfaces () {
    sudo snap connect opensearch:log-observe
    sudo snap connect opensearch:mount-observe
    sudo snap connect opensearch:process-control
    sudo snap connect opensearch:system-observe
    sudo snap connect opensearch:sys-fs-cgroup-service
}


function set_kernel_conf () {
    # 1. Allow the opensearch user to Disable all swap files:
    # swapon -a -- default in local machine
    sudo sysctl -w vm.swappiness=0

    # 2. Ensuring sufficient virtual memory: https://www.elastic.co/guide/en/elasticsearch/reference/current/vm-max-map-count.html
    # sysctl -w vm.max_map_count=65530 -- default in local machine
    sudo sysctl -w vm.max_map_count=262144

    # 3. Reduce TCP retransmission timeout = ~6 seconds
    # sysctl -w net.ipv4.tcp_retries2=15 -- default in local machine
    sudo sysctl -w net.ipv4.tcp_retries2=5
}


connect_interfaces
set_kernel_conf
