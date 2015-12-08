name             "chef-solo-proxy"
maintainer       "Ryan Wild"
license          "MIT"
description      "Sets up a proxy environment variable for chef solo"
version          "0.0.1"

attribute "chef_solo_proxy/http_proxy",
  :description => "Sets an environment variable for the http proxy",
  :default => nil

attribute "chef_solo_proxy/https_proxy",
  :description => "Sets an environment variable for the https secure proxy",
  :default => nil

attribute "chef_solo_proxy/no_proxy",
  :description => "Sets an environment variable for addresses which aren't proxied",
  :default => nil

