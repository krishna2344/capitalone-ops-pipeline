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

export STS_VERSION=3.7.0.RELEASE
export STS_HOME=/opt/sts-bundle/sts-$STS_VERSION
export STS_SETUP_LOC=/tmp/sts-setup

echo "\n############################ Creating STS desktop entry ###############\n"
cp ${STS_SETUP_LOC}/STS.desktop /usr/share/applications/
mkdir -p /home/vagrant/Desktop
cp ${STS_SETUP_LOC}/STS.desktop /home/vagrant/Desktop/
chown vagrant /home/vagrant/Desktop/STS.desktop
chmod 755 /home/vagrant/Desktop/STS.desktop
