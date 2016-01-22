# Using already created images:


## Vagrant Boxes:

* opspipeline/headless-ubuntu
* opspipeline/mysql-centos
* opspipeline/mysql-ubuntu
* opspipeline/headless-centos
* opspipeline/flamegraph-ubuntu
* opspipeline/flamegraph-centos
* opspipeline/desktop-ubuntu
* opspipeline/headless
* opspipeline/desktop

```bash
vagrant init opspipeline/headless-centos; vagrant up
```

## Docker images:
* opspipeline/alpine-mysql
* opspipeline/ubuntu-mysql
* opspipeline/ubuntu-headless
* opspipeline/alpine-headless

``` bash
docker run -it  opspipeline/ubuntu-headless /bin/bash
root@fde2ab82b772:/# /usr/local/maven-3.3.3/bin/mvn -v
root@fde2ab82b772:/# exit


docker run -it opspipeline/ubuntu-mysql:latest /bin/bash
root@5792cd9b8546:/# openrc
root@5792cd9b8546:/# /etc/init.d/mariadb start
root@3875a77efb89:/# echo "show tables;" | mysql mysql
root@3875a77efb89:/# exit

```
