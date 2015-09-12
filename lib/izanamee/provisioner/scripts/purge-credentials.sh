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

echo "\n############################ Clearing proxy settings from /etc/environment ###############\n"
echo "PATH=$PATH" > /etc/environment

for authenvdotfile in `ls /etc/environment.auth.*`
do
    echo "\n########################### Purging $authenvdotfile ############################\n"
    rm $authenvdotfile
done

for envdotfile in `ls /etc/environment.*`
do
    echo "\n########################### Appending $envdotfile to /etc/environment ############################\n"
    cat $envdotfile >> /etc/environment
done

echo "\n############################ Listing BEFORE contents of /home/vagrant ############################\n"
ls -al /home/vagrant
echo "\n############################ Clearing proxy settings from /home/vagrant dotfiles ###############\n"
rm -f /home/vagrant/.npmrc
rm -f /home/vagrant/.bowerrc
rm -f /home/vagrant/.gitconfig
echo "\n############################ Listing AFTER contents of /home/vagrant ############################\n"
ls -al /home/vagrant


echo "\n############################ Listing BEFORE contents of /root ############################\n"
ls -al /root
echo "\n############################ Clearing proxy settings from /root dotfiles ###############\n"
rm -f /root/.npmrc
rm -f /root/.bowerrc
rm -f /root/.gitconfig
echo "\n############################ Listing AFTER contents of /root ############################\n"
ls -al /root
