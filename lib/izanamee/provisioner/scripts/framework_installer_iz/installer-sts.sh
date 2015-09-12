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

echo "\n############################ Exporting Open IZ environment variables ############################\n"
export STS_VERSION=3.7.0.RELEASE
export STS_HOME=/opt/sts-bundle/sts-$STS_VERSION
export STS_SETUP_DIR=sts-setup
export STS_SETUP_LOC=/tmp/$STS_SETUP_DIR

echo "\n############################ Installing SpringSource Tool Suite 3.7.0 ############################\n"
cd /opt

# Use wget to download the STS installer
DONEFLAG=1
while [ $DONEFLAG > 0 ]; do
    wget --no-check-certificate --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 --continue http://dist.springsource.com/release/STS/$STS_VERSION/dist/e4.5/spring-tool-suite-$STS_VERSION-e4.5-linux-gtk-x86_64.tar.gz
    if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
    if [ $DONEFLAG -gt 10 ]; then
	break;
    else
	let DONEFLAG=DONEFLAG+1;
	sleep "$DONEFLAG"s;
    fi
done;

tar xvf spring-tool-suite-$STS_VERSION-e4.5-linux-gtk-x86_64.tar.gz
rm -r spring-tool-suite-$STS_VERSION-e4.5-linux-gtk-x86_64.tar.gz
cd ~

