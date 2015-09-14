default['spring_tool_suite']['application_dirs'] = [
  '/usr/share/applications',
  '/home/vagrant/Desktop'
]
default['spring_tool_suite']['sts_version'] = '3.7.0.RELEASE'
default['spring_tool_suite']['sts_homedir'] =
  "/opt/sts-bundle/sts-#{node['spring_tool_suite']['sts_version']}"
default['spring_tool_suite']['sts_setup_dir'] = 'sts-setup'
default['spring_tool_suite']['sts_download'] =
  'http://dist.springsource.com/release/STS/' <<
  node['spring_tool_suite']['sts_version'] <<
  '/dist/e4.5/spring-tool-suite-' <<
  node['spring_tool_suite']['sts_version'] <<
  '-e4.5-linux-gtk-x86_64.tar.gz'

default['spring_tool_suite']['subclipse']['site'] = 'http://subclipse.tigris.org/update_1.10.x'
default['spring_tool_suite']['subclipse']['ius'] = 'org.tigris.subversion.subclipse.feature.group,org.tigris.subversion.subclipse.graph.feature.feature.group,org.tigris.subversion.clientadapter.feature.feature.group,com.collabnet.subversion.merge.feature.feature.group,org.tmatesoft.svnkit.feature.group,org.tigris.subversion.clientadapter.svnkit.feature.feature.group'
default['spring_tool_suite']['subclipse']['creates'] = "#{node['spring_tool_suite']['sts_homedir']}/plugins/org.tigris.subversion.subclipse.core_1.10.10.jar"

default['spring_tool_suite']['subclipse_maven']['site'] = 'http://subclipse.tigris.org/m2eclipse/latest'
default['spring_tool_suite']['subclipse_maven']['ius'] = 'org.sonatype.m2e.subclipse.feature.feature.group'
default['spring_tool_suite']['subclipse_maven']['creates'] = "#{node['spring_tool_suite']['sts_homedir']}/plugins/org.sonatype.m2e.subclipse_0.13.0.201312191101.jar"

default['spring_tool_suite']['jadeclipse']['site'] = 'http://jadclipse.sourceforge.net/update/'
default['spring_tool_suite']['jadeclipse']['ius'] = 'net.sf.jdtdecompiler.feature.feature.group'
default['spring_tool_suite']['jadeclipse']['creates'] = "#{node['spring_tool_suite']['sts_homedir']}/plugins/net.sf.jdtdecompiler.core_3.4.0.v20090220.jar"

default['spring_tool_suite']['angularjs']['site'] = 'http://oss.opensagres.fr/angularjs-eclipse/0.2.0/'
default['spring_tool_suite']['angularjs']['ius'] = 'angularjs-eclipse-feature.feature.group,tern-feature.feature.group,tern-jsdt-feature.feature.group,tern-server-nodejs-feature.feature.group,tern-server-rhino-feature.feature.group,tern.eclipse.ide.tools.feature.feature.group,tern.eclipse.linux.gtk.x86_64.feature.feature.group'
default['spring_tool_suite']['angularjs']['creates'] = "#{node['spring_tool_suite']['sts_homedir']}/plugins/org.eclipse.angularjs.ui_0.2.0.201405272028.jar"

default['spring_tool_suite']['plugin_list'] =
  ['subclipse', 'subclipse_maven', 'jadeclipse', 'angularjs']
