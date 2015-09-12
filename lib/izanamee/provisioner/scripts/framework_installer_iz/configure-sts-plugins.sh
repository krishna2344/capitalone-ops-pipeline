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

echo "\n############################ Installing Eclipse plugins ############################\n"
export ANGULAR_JS_SITE=http://oss.opensagres.fr/angularjs-eclipse/0.2.0/
export ORACLE_SITE=http://download.oracle.com/otn_software/oepe/luna/
export VELOCITY_SITE=http://veloedit.sourceforge.net/updates/
export SUBCLIPSE_SITE=http://subclipse.tigris.org/update_1.10.x
export JADECLIPSE_SITE=http://jadclipse.sourceforge.net/update/
export SUBCLIPSE_MAVEN_SITE=http://subclipse.tigris.org/m2eclipse/latest

export SUBCLIPSE_IUS=org.tigris.subversion.subclipse.feature.group,org.tigris.subversion.subclipse.graph.feature.feature.group,org.tigris.subversion.clientadapter.feature.feature.group,com.collabnet.subversion.merge.feature.feature.group,org.tmatesoft.svnkit.feature.group,org.tigris.subversion.clientadapter.svnkit.feature.feature.group
export JADECLIPSE_IUS=net.sf.jdtdecompiler.feature.feature.group
export ANGULARJS_IUS=angularjs-eclipse-feature.feature.group,tern-feature.feature.group,tern-jsdt-feature.feature.group,tern-server-nodejs-feature.feature.group,tern-server-rhino-feature.feature.group,tern.eclipse.ide.tools.feature.feature.group,tern.eclipse.linux.gtk.x86_64.feature.feature.group
export ORACLE_IUS=oracle.eclipse.tools.database.feature.group
export SONAR_IUS=org.sonar.ide.eclipse.jdt.feature.feature.group,org.sonar.ide.eclipse.m2e.feature.feature.group
export VELOCITY_IUS=org.vaulttec.velocity.feature.group
export SUBCLIPSE_MAVEN_IUS=org.sonatype.m2e.subclipse.feature.feature.group

cd $STS_HOME

echo "\n############################ Installing Subclipse plugin ############################\n"
./STS -application org.eclipse.equinox.p2.director -repository $SUBCLIPSE_SITE -installIUs $SUBCLIPSE_IUS -noSplash
./STS -application org.eclipse.equinox.p2.director -repository $SUBCLIPSE_MAVEN_SITE -installIUs $SUBCLIPSE_MAVEN_IUS -noSplash

echo "\n############################ Installing Jadclipse plugin ############################\n"
./STS -application org.eclipse.equinox.p2.director -repository $JADECLIPSE_SITE -installIUs $JADECLIPSE_IUS -noSplash

echo "\n############################ Installing AngularJS plugin ############################\n"
./STS -application org.eclipse.equinox.p2.director -repository $ANGULAR_JS_SITE -installIUs $ANGULARJS_IUS -noSplash

#echo "\n############################ Installing Velocity plugin ############################\n"
#./STS -application org.eclipse.equinox.p2.director -repository $VELOCITY_SITE -installIUs $VELOCITY_IUS -noSplash

#echo "\n############################ Installing Oracle database tools plugin ############################\n"
#./STS -application org.eclipse.equinox.p2.director -repository $ORACLE_SITE -installIUs $ORACLE_IUS -noSplash