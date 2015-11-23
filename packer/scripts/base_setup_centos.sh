#!/bin/bash

set -e


yum -y update
yum -y install curl wget git vim openssh-server ca-certificates

# Make ssh faster by not waiting on DNS
echo "UseDNS no" >> /etc/ssh/sshd_config

# install epel
# @see https://fedoraproject.org/wiki/EPEL
rpm --import https://fedoraproject.org/static/0608B895.txt
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm

# yum install epel-release
yum -y update

yum -y install gcc make gcc-c++ kernel-devel-`uname -r` dkms nfs-utils
