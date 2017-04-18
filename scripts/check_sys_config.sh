#!/bin/bash

echo "Setting vm.swapiness"
sysctl vm.swappiness=1
echo "vm.swappiness = 1" >> /etc/sysctl.conf

echo "Disabling transparent_hugepage settings"
echo never > /sys/kernel/mm/transparent_hugepage/defrag
echo never > /sys/kernel/mm/transparent_hugepage/enabled

cat >> /etc/rc.local <<EOF
echo 'never' > /sys/kernel/mm/transparent_hugepage/defrag
echo 'never' > /sys/kernel/mm/transparent_hugepage/enabled
EOF

selinuxStat=$(getenforce)
echo "Selinux is ${selinuxStat}"
