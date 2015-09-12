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
  module ProxyHelper
    @@proxy_helper_script = "#{Izanamee.izanamee_lib_root}izanamee/scripts/proxy_helper_envvars.sh"

    @@proxy_user = ENV['HTTP_PROXY_USER']
    @@proxy_password = ENV['HTTP_PROXY_PWRD']
    @@proxy_host = ENV['HTTP_PROXY_HOST']
    @@proxy_port = ENV['HTTP_PROXY_PORT']

    @@http_proxy_url = ''
    @@https_proxy_url = ''

    def self.proxy_user
      @@proxy_user
    end

    def self.proxy_password
      @@proxy_password
    end

    def self.http_proxy_url
      @@http_proxy_url
    end

    def self.https_proxy_url
      @@https_proxy_url
    end

    def self.check_for_proxy_envvars
      if @@proxy_user == nil or @@proxy_password == nil
        puts "Please set the environment variables HTTP_PROXY_USER and HTTP_PROXY_PWRD to appropriate values before continuing...\n\n"
        exit 0
      else
        puts "Found HTTP_PROXY_USER envar: #{@@proxy_user}"
        puts 'Found HTTP_PROXY_PWRD envar: ********'
      end

      if @@proxy_host == nil or @@proxy_port == nil
        puts "Please set the environmentment variables HTTP_PROXY_HOST and HTTP_PROXY_PORT to appropriate values before continuing...\n\n"
        exit 0
      else
        puts "Found HTTP_PROXY_HOST envar: #{@@proxy_host}"
        puts "Found HTTP_PROXY_PORT envar: #{@@proxy_port}"
      end

      @@http_proxy_url = "http://#{@@proxy_user}:#{@@proxy_password}@#{@@proxy_host}:#{@@proxy_port}"
      @@https_proxy_url = "http://#{@@proxy_user}:#{@@proxy_password}@#{@@proxy_host}:#{@@proxy_port}"

    end

    def self.set_proxyconfig
      if Vagrant.has_plugin?('vagrant-proxyconf')
        Izanamee.config.proxy.http = @@http_proxy_url
        Izanamee.config.proxy.https = @@https_proxy_url

        Izanamee.config.vm.provision 'shell', run:'always' do |s|
          s.path = "#{@@proxy_helper_script}"
          s.args = "#{@@proxy_user} #{@@proxy_password} #{@@proxy_host} #{@@proxy_port}"
        end

      else
        puts "Please install the vagrant-proxyconf plugin using the installation command: \n\nvagrant plugin install vagrant-proxyconf\n\n"
        exit 0
      end
    end
  end
end