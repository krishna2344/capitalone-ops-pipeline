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
    module ConfigureWorkspaceIZ

      # file locations
      @@scripts_dir = "#{Izanamee::Provisioners.scripts_root}/framework_installer_iz"
      @@resources_dir = Izanamee::Provisioners.resources_root

      # scripts
      @@proxy_credentials_configurator = 'set-proxy-credentials.sh'

      # resources
      #   ex. @@sts_ini = 'STS.ini'

      def self.provision
        provision_user_settings
      end

      private
      # configure Git and NPM
      def self.provision_user_settings
        Izanamee.config.vm.provision 'shell', run:'always' do |s|
          s.privileged = false
          s.path = "#{@@scripts_dir}/#{@@proxy_credentials_configurator}"
          s.args = "#{Izanamee::ProxyHelper.proxy_user} #{Izanamee::ProxyHelper.proxy_password}"
        end
      end

    end
  end
end