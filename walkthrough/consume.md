# Using already created images:


## Vagrant Boxes:

* tompscanlan/headless-ubuntu
* tompscanlan/mysql-centos
* tompscanlan/mysql-ubuntu
* tompscanlan/headless-centos
* tompscanlan/flamegraph-ubuntu
* tompscanlan/chaperone-ubuntu
* tompscanlan/flamegraph-centos
* tompscanlan/desktop-ubuntu
* tompscanlan/headless
* tompscanlan/desktop

```bash
vagrant init tompscanlan/headless-centos; vagrant up
```

## Docker images:
* tompscanlan/alpine-mysql
* tompscanlan/ubuntu-mysql
* tompscanlan/ubuntu-headless
* tompscanlan/alpine-headless

``` bash
docker run -it  tompscanlan/ubuntu-headless /bin/bash
root@fde2ab82b772:/# /usr/local/maven-3.3.3/bin/mvn -v
root@fde2ab82b772:/# exit


docker run -it tompscanlan/ubuntu-mysql:latest /bin/bash
root@5792cd9b8546:/# openrc
root@5792cd9b8546:/# /etc/init.d/mariadb start
root@3875a77efb89:/# echo "show tables;" | mysql mysql
root@3875a77efb89:/# exit

```