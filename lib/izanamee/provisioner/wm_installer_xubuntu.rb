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
    module WMInstaller

      # file locations
      @@scripts_dir = "#{Izanamee::Provisioners.scripts_root}/wm_installer_xubuntu"
      @@resources_dir = Izanamee::Provisioners.resources_root

      # scripts
      @@update_apt = 'install-update-apt.sh'
      @@wm_installer = 'install-gui.sh'
      @@google_chrome_installer = 'install-google-chrome.sh'
      @@configure_firefox_prefs = 'configure-firefox-prefs.sh'
      @@configure_chrome_prefs = 'configure-google-chrome.sh'
      @@configure_ibus_hotkey = 'configure-ibus-hotkey.sh'
      @@configure_ubuntu_passwd = 'configure-ubuntu-passwd.sh'
      @@configure_xscreensaver = 'configure-xscreensaver.sh'

      # resources
      @@firefox_prefs = 'firefox_conf/prefs.js'
      @@firefox_desktop_config = 'firefox_conf/firefox.desktop'
      @@google_chrome_desktop_config = 'chrome_conf/google-chrome.desktop'
      @@xscreensaver_prefs = 'xscreensaver_conf/xscreensaver.prefs'

      def self.provision
        update_apt
        install_gui
        Izanamee::VMHelper.reboot

        install_google_chrome
        configure_firefox
        configure_google_chrome
        configure_ibus_hotkey
        configure_ubuntu_password
        configure_xscreensaver
        Izanamee::VMHelper.add_vbox_guest_tools
      end

      private
      # General apt update
      def self.update_apt
        Izanamee.config.vm.provision 'shell', path:"#{@@scripts_dir}/#{@@update_apt}"
      end

      # Install xubuntu and configure X11 to let the vagrant user start it
      def self.install_gui
        Izanamee.config.vm.provision 'shell', path:"#{@@scripts_dir}/#{@@wm_installer}"
      end

      def self.install_google_chrome
        Izanamee.config.vm.provision 'shell', path:"#{@@scripts_dir}/#{@@google_chrome_installer}"
      end

      def self.configure_google_chrome
        Izanamee.config.vm.provision 'file', source:"#{@@resources_dir}/#{@@google_chrome_desktop_config}", destination:"/tmp/#{@@google_chrome_desktop_config}"
        Izanamee.config.vm.provision 'shell' do |s|
          s.privileged = false
          s.path = "#{@@scripts_dir}/#{@@configure_chrome_prefs}"
          s.args = "/tmp/#{@@google_chrome_desktop_config}"
        end
      end

      # Set Proxy PAC
      def self.configure_firefox
        Izanamee.config.vm.provision 'file', source:"#{@@resources_dir}/#{@@firefox_prefs}", destination:"/tmp/#{@@firefox_prefs}"
        Izanamee.config.vm.provision 'file', source:"#{@@resources_dir}/#{@@firefox_desktop_config}", destination:"/tmp/#{@@firefox_desktop_config}"
        Izanamee.config.vm.provision 'shell' do |s|
          s.path = "#{@@scripts_dir}/#{@@configure_firefox_prefs}"
          s.args = "/tmp/#{@@firefox_prefs} /tmp/#{@@firefox_desktop_config}"
        end
      end

      def self.configure_ibus_hotkey
        Izanamee.config.vm.provision 'shell', privileged:false, path:"#{@@scripts_dir}/#{@@configure_ibus_hotkey}"
      end

      def self.configure_ubuntu_password
        Izanamee.config.vm.provision 'shell', path:"#{@@scripts_dir}/#{@@configure_ubuntu_passwd}"
      end

      def self.configure_xscreensaver
        Izanamee.config.vm.provision 'file', source:"#{@@resources_dir}/#{@@xscreensaver_prefs}", destination:"/tmp/#{@@xscreensaver_prefs}"
        Izanamee.config.vm.provision 'shell', privileged:false, path:"#{@@scripts_dir}/#{@@configure_xscreensaver}"
      end
    end
  end
end