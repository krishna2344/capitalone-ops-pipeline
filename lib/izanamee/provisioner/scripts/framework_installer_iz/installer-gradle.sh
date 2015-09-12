#!/bin/bash -e

echo "\n############################ Installing Gradle for use in template-driven config generation (app-common-config, web-isso-config) in build ############################\n"
echo "\n############################ Adding APT repo for Gradle to get up-to-date packages ############################\n"
DEBIAN_FRONTEND=noninteractive add-apt-repository -y ppa:cwchien/gradle
DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" update
echo "\n############################ Installing Gradle 1.12 ############################\n"
DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install gradle-1.12