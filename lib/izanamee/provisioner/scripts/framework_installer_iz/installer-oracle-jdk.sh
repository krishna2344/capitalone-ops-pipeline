<<COMMENT
/*************************IZANAMEE-LICENSE-START*********************************
 * Copyright 2015 CapitalOne, LLC.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *************************IZANAMEE-LICENSE-END*********************************/
COMMENT

#!/bin/bash


echo "############################ Inside Oracle JDK installer ############################"

##Remove option to select JDK per #208
#
#if [ $# -eq 0 ]; then
#    echo "You must specify a JDK version!" 1>&2
#    exit 1
#fi
#
#case "$1" in
#    7) echo "############################ JDK 7 requested ############################"
#       ;;
#    8) echo "############################ JDK 8 requested ############################"
#       ;;
#    *) echo "'$1' is not an acceptable JDK version!" 1>&2
#       exit 1
#       ;;
#esac

#Add JDKs 8, 7 in sequence per #208
for i in "8" "7"
do
    #echo "############################ Installing JDK $i ############################"
    echo oracle-java$i-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
    add-apt-repository ppa:webupd8team/java
    apt-get update
    DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install oracle-java$i-set-default
done

#TODO: this should not be in the JDK installer
echo "############################ Installing libsvn-java for use by Eclipse SVN integration ############################"
DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install libsvn-java

##Remove option to select JDK per #208
#export JAVA_HOME=/usr/lib/jvm/java-$1-oracle
#
##echo "############################ Making sure that the Oracle 1.$1 JDK is the default ############################"
#update-java-alternatives -s java-$1-oracle

##Make JDK7 default per #208
export JAVA_HOME=/usr/lib/jvm/java-7-oracle

#echo "############################ Making sure that the Oracle 1.7 JDK is the default ############################"
update-java-alternatives -s java-7-oracle