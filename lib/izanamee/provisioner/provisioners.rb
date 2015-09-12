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
    # Paths
    @@scripts_root = "#{Izanamee.izanamee_lib_root}izanamee/provisioner/scripts"
    @@resources_root = "#{Izanamee.izanamee_lib_root}izanamee/provisioner/resources"

    # Scripts
    @@purge_credentials_script = 'purge-credentials.sh'

    def self.scripts_root
      @@scripts_root
    end

    def self.resources_root
      @@resources_root
    end

    require 'izanamee/provisioner/wm_installer_xubuntu'
    require 'izanamee/provisioner/framework_installer_iz'
    require 'izanamee/provisioner/configure_workspace_iz'

    def self.purge_config_credentials
      Izanamee.config.vm.provision 'shell', run:'always', path:"#{@@scripts_root}/#{@@purge_credentials_script}"
    end
  end
end
