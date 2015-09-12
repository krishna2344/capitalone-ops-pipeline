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
  module VMHelper
    require 'reboot-plugin/vagrant-provision-reboot-plugin'
    require 'izanamee/operating_system'

    @@scripts_dir = "#{Izanamee.izanamee_lib_root}izanamee/provisioner/scripts/"
    @@update_vb_guest_script = "#{@@scripts_dir}/update-vbox-guest-additions.sh"
    @@configure_bash_aliases_script = "#{@@scripts_dir}/configure-bash-aliases.sh"

    # Enumeration of OS Types
    # TODO Externalize this to a configuration pattern
    @@supported_systems = {
        :ubuntu_trusty => Izanamee::OperatingSystem.new('ubuntu', '14.04', 'ubuntu/trusty64', 'https://vagrantcloud.com/ubuntu/boxes/trusty64/versions/1/providers/virtualbox.box'),
        :centos6_5 => Izanamee::OperatingSystem.new('centos', '6.5', 'chef/centos-6.5', 'https://vagrantcloud.com/chef/boxes/centos-6.5/versions/1/providers/virtualbox.box'),
        :windows_7pro => Izanamee::OperatingSystem.new('windows', '7pro_x64', 'windows7pro', 'TBD')
    }

    # TODO Externalize this to a configuration pattern
    @@default_share_folder = {
        :host_path => '../host-share',
        :guest_path => '/home/vagrant/host-share'
    }

    def self.supported_systems
      @@supported_systems
    end

    @@guest_os = @@supported_systems[:ubuntu_trusty]

    def self.guest_os=(guest_os)
      @@guest_os = guest_os
    end

    def self.guest_os
      @@guest_os
    end

    def self.set_natdnsproxy
      Izanamee.config.vm.provider :virtualbox do |vb|
        vb.customize ['modifyvm', :id, '--natdnsproxy1', 'on']
        vb.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
      end
    end

    def self.fix_ubuntu_ssh_tty
      Izanamee.config.vm.provision 'shell', inline:"sed -i 's/^mesg n$/tty -s \\&\\& mesg n/g' /root/.profile"
    end

    def self.reboot
      # Reboot the vagrant image here before continuing
      Izanamee.config.vm.provision :unix_reboot
      self.fix_ubuntu_ssh_tty
    end

    def self.add_vbox_guest_tools
      # Update VBox Guest Additions
      Izanamee.config.vm.provision 'shell', path:"#{@@update_vb_guest_script}"
    end

    def self.mount_shared_folder
      Dir.mkdir("#{@@default_share_folder[:host_path]}") unless File.exist?("#{@@default_share_folder[:host_path]}")
      Izanamee.config.vm.synced_folder "#{@@default_share_folder[:host_path]}", "#{@@default_share_folder[:guest_path]}"
    end

    def self.configure_dotfiles
      Izanamee.config.vm.provision 'shell', run:'always', path:"#{@@configure_bash_aliases_script}"
    end
  end
end
