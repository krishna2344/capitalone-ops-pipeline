=begin
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
=end

module Izanamee
  module Provisioners
    module FrameworkInstallerIZ

      # file locations
      @@scripts_dir = "#{Izanamee::Provisioners.scripts_root}/framework_installer_iz"
      @@resources_dir = Izanamee::Provisioners.resources_root
      @@sts_setup_location = '/tmp/sts-setup'

      #scripts
      @@prereqs_installer = 'installer-prereqs.sh'
      @@configure_maven_settings = 'configure-maven-settings.sh'
      @@configure_sts_plugins = 'configure-sts-plugins.sh'
      @@maven_installer = 'installer-maven.sh'
      @@gradle_installer = 'installer-gradle.sh'
      @@docker_installer = 'installer-docker.sh'
      @@tomcat_7_installer = 'installer-tomcat-7.sh'
      @@tomcat_8_installer = 'installer-tomcat-8.sh'
      @@npm_installer = 'installer-npm.sh'
      @@scm_installer = 'installer-scm.sh'
      @@sts_installer = 'installer-sts.sh'
      @@oracle_jdk_installer = 'installer-oracle-jdk.sh'
      @@developer_tools_installer = 'installer-developer-tools.sh'
      @@configure_desktop_settings = 'configure-desktop-settings.sh'
      @@proxy_credentials_configurator = 'set-proxy-credentials.sh'
      @@configure_bash_aliases = 'configure-bash-aliases.sh'

      #resources
      @@maven_prefs = 'org.eclipse.m2e.core.prefs'
      @@sts_ini= 'STS.ini'
      @@sts_desktop_launcher = 'STS.desktop'
      @@bash_aliases = '.bash_aliases'

      #args
      @@jdk_version = '7'

      def self.provision
        provision_headless
        configure_headless

        provision_desktop
        configure_desktop
      end

      def self.provision_headless
        provision_prereqs
        provision_oracle_jdk_7
        provision_scm
        provision_gradle
        provision_maven
        provision_docker
        provision_tomcat_7
        provision_tomcat_8
        provision_npm
        provision_developer_tools
        #provision_user_settings
      end

      def self.configure_headless
        configure_maven_settings
      end

      def self.provision_desktop
        provision_sts
      end

      def self.configure_desktop
        configure_sts_plugins
        configure_sts_desktop
      end

      private

      def self.provision_prereqs
        Izanamee.config.vm.provision 'shell', path:"#{@@scripts_dir}/#{@@prereqs_installer}"
      end

      def self.provision_oracle_jdk_7
        Izanamee.config.vm.provision 'shell' do |s|
          s.path = "#{@@scripts_dir}/#{@@oracle_jdk_installer}"
          s.args = "#{@@jdk_version}"
        end
      end

      def self.provision_scm
        Izanamee.config.vm.provision 'shell', path:"#{@@scripts_dir}/#{@@scm_installer}"
      end

      def self.provision_gradle
        Izanamee.config.vm.provision 'shell' do |s|
          s.path = "#{@@scripts_dir}/#{@@gradle_installer}"
          s.args = "#{Izanamee::ProxyHelper.proxy_user} #{Izanamee::ProxyHelper.proxy_password}"
        end
      end

      def self.provision_maven
        Izanamee.config.vm.provision 'shell', path:"#{@@scripts_dir}/#{@@maven_installer}"
      end

      def self.provision_docker
        Izanamee.config.vm.provision 'shell', path:"#{@@scripts_dir}/#{@@docker_installer}"
      end

      def self.configure_maven_settings
        # NOTE: Requires SVN
        Izanamee.config.vm.provision 'shell' do |s|
          s.path = "#{@@scripts_dir}/#{@@configure_maven_settings}"
          s.args = "#{Izanamee::ProxyHelper.proxy_user} #{Izanamee::ProxyHelper.proxy_password}"
        end
      end

      def self.provision_tomcat_7
        Izanamee.config.vm.provision 'shell', path:"#{@@scripts_dir}/#{@@tomcat_7_installer}"
      end

      def self.provision_tomcat_8
        Izanamee.config.vm.provision 'shell', path:"#{@@scripts_dir}/#{@@tomcat_8_installer}"
      end

      def self.provision_npm
        Izanamee.config.vm.provision 'shell', path:"#{@@scripts_dir}/#{@@npm_installer}"
      end

      def self.provision_sts
        Izanamee.config.vm.provision 'shell', path:"#{@@scripts_dir}/#{@@sts_installer}"
      end

      def self.configure_sts_plugins
        Izanamee.config.vm.provision 'shell', path:"#{@@scripts_dir}/#{@@configure_sts_plugins}"
      end

      def self.provision_developer_tools
        Izanamee.config.vm.provision 'shell', path:"#{@@scripts_dir}/#{@@developer_tools_installer}"
      end

      def self.configure_sts_desktop
        Izanamee.config.vm.provision 'file', source:"#{@@resources_dir}/#{@@sts_desktop_launcher}", destination:"#{@@sts_setup_location}/#{@@sts_desktop_launcher}"
        Izanamee.config.vm.provision 'shell', path:"#{@@scripts_dir}/#{@@configure_desktop_settings}"
      end

      def self.provision_user_settings
        Izanamee.config.vm.provision 'shell' do |s|
          s.path = "#{@@scripts_dir}/#{@@proxy_credentials_configurator}"
          s.args = "#{Izanamee::ProxyHelper.proxy_user} #{Izanamee::ProxyHelper.proxy_password}"
        end
      end

      def self.configure_dotfiles
        Izanamee.config.vm.provision 'file', run:'always', source:"#{@@resources_dir}/#{@@bash_aliases}", destination:"/tmp/iz/#{@@bash_aliases}"
        Izanamee.config.vm.provision 'shell', run:'always' do |s|
          s.path = "#{@@scripts_dir}/#{@@configure_bash_aliases}"
        end
      end

    end
  end
end
