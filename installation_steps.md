# Installing a production Hadoop cluster

## assumptions

* instances for each node type are up and accessible (ssh)
* a supported OS is installed on each instance
* a DNS server is available on the network and hostnames are resolvable
* instances are on the same private network
* hostnames are correctly setup
* all commands will be run as root user unless specified otherwise

## preinstall

### Package updates and some handy tools

Update the nodes and add some missing tools [all nodes]

```
yum clean all
yum -y update
yum install -y wget vim mlocate net-tools nc lsof bind-utils nscd ntp
```

### Mounting additional disks

**HDFS Data disks**
* mount with noatime option
* reduce the number of reserved blocks

example:
```
mkfs.ext4 -m 0 -F /dev/disk/by-id/scsi-0DO_Volume_data0
tune2fs -m 0 /dev/disk/by-id/scsi-0DO_Volume_data0
sudo mkdir -p /mnt/data0; sudo mount -o discard,defaults,noatime /dev/disk/by-id/scsi-0DO_Volume_data0 /mnt/data0; echo /dev/disk/by-id/scsi-0DO_Volume_data0 /mnt/data0 ext4 defaults,nofail,discard,noatime 0 0 | sudo tee -a /etc/fstab
```

**Zookeeper disks**
* choose disks with higher I/O throughput

example:
```
mkfs.ext4 -m 0 -F /dev/disk/by-id/scsi-0DO_Volume_zoo0
tune2fs -m 0 /dev/disk/by-id/scsi-0DO_Volume_zoo0
sudo mkdir -p /mnt/zoo0; sudo mount -o discard,defaults /dev/disk/by-id/scsi-0DO_Volume_zoo0 /mnt/zoo0; echo /dev/disk/by-id/scsi-0DO_Volume_zoo0 /mnt/zoo0 ext4 defaults,nofail,discard 0 0 | sudo tee -a /etc/fstab
```

> The examples above are specific for digitalocean instances. The steps do not cover tasks like making disks available to the server.

### ssh key for passwordless access created

Cloudera manager requires access to the required servers. Though it offers a password option, we strongly recommended to use the key based access. This means that you need to make sure that access with one public key is enabled to all servers in the cluster. We've simplified this part by creating a script, which we run from desktop.

```
bash dist_ssh_keys.sh
```

### important system configuration checks

1. vm.swapiness settings on all nodes
2. transparent hugepages
3. forward and reverse host lookup
4. correct ntp settings


### database

This workshop covers a quick installation and configuration of mariadb.

For the installation we will run a hand script, which installs mariadb via yum and set's the Cloudera recommended configuration.

```
bash install_mariadb-server.sh
```

Next we'll set the root password and some basic security requirements.

```
$ sudo /usr/bin/mysql_secure_installation
[...]
Enter current password for root (enter for none):
OK, successfully used password, moving on...
[...]
Set root password? [Y/n] y
New password:
Re-enter new password:
Remove anonymous users? [Y/n] Y
[...]
Disallow root login remotely? [Y/n] N
[...]
Remove test database and access to it [Y/n] Y
[...]
Reload privilege tables now? [Y/n] Y
All done!
```

install the JDBC driver

```
bash install_jdbc_driver.sh
```
