name             "chef-solo-proxy"
maintainer       "Ryan Wild"
license          "MIT"
description      "Sets up a proxy environment varriable for chef solo"
version          "0.0.1"

attribute "chef_solo_proxy/http_proxy",
  :description => "Sets an environment varriable for the http proxy",
  :default => nil

attribute "chef_solo_proxy/https_proxy",
  :description => "Sets an environment varriable for the https secure proxy",
  :default => nil

