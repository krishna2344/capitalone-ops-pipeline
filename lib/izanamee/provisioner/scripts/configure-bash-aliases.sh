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

export VAGRANT_BASH_ALIASES=/home/vagrant/.bash_aliases
export VAGRANT_BASH_ALIASES_DIR=${VAGRANT_BASH_ALIASES}.d

echo "########################### Clearing ${VAGRANT_BASH_ALIASES} ###########################"
rm -f ${VAGRANT_BASH_ALIASES}
touch ${VAGRANT_BASH_ALIASES}
chown vagrant:vagrant ${VAGRANT_BASH_ALIASES}

echo "########################### Appending each file in ${VAGRANT_BASH_ALIASES_DIR} to ${VAGRANT_BASH_ALIASES} ###########################"
ls -l ${VAGRANT_BASH_ALIASES_DIR}
for aliases in `ls ${VAGRANT_BASH_ALIASES_DIR}`
do
    echo "########################### Appending ${VAGRANT_BASH_ALIASES_DIR}/$aliases to ${VAGRANT_BASH_ALIASES} ############################"
    cat ${VAGRANT_BASH_ALIASES_DIR}/$aliases >> ${VAGRANT_BASH_ALIASES}
done