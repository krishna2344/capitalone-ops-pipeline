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

echo "\n############################ Installing xfce ############################\n"
DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install xubuntu-desktop

echo "\n############################ Configuring X11 to let the vagrant user start xfce ############################\n"
perl -i -p -e 's/console/anybody/' /etc/X11/Xwrapper.config

echo "\n############################ By default, three screensavers get installed; this creates screen-locking issues ############################\n"
echo "\n############################ Removing gnome-screensaver ############################\n"
DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" remove gnome-screensaver
echo "\n############################ Removing light-locker ############################\n"
DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" remove light-locker