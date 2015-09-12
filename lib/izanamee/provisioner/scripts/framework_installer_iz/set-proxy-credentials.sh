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

#!/bin/bash -e

echo "\n############################ Listing current contents of /home/vagrant ############################\n"
ls -al /home/vagrant

echo "\n############################ Listing current contents of /root ############################\n"
# NOTE: Making this sudo since this script is meant to be run as vagrant user
sudo ls -al /root

echo "\n############################ Configuring proxy settings for Git, for vagrant user ############################\n"
git config --global url."https://".insteadOf git://
git config --global http.proxy $HTTP_PROXY
git config --global https.proxy $HTTP_PROXY

echo "\n############################ Configuring proxy settings for NPM, for vagrant user ############################\n"
npm config set proxy $HTTP_PROXY
npm config set https-proxy $HTTP_PROXY
npm config set registry "http://registry.npmjs.org"