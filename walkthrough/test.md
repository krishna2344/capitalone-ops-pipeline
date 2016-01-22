# Test provisioning against base images

## installing test kitchen

Test kitchen is part of chefdk, and can be installed by following instructions at https://downloads.chef.io/chef-dk

You may need to add the the following dirs to your path:
* /opt/chefdk/embedded/bin/
* ~/.chefdk/gem/ruby/2.1.0/bin

Add extra driver gems:
``` bash
gem install kitchen
gem install kitchen-docker
gem install kitchen-vagrant
gem install test-kitchen
```

## Running existing tests
```
git clone https://github.com/capitalone/ops-pipeline.git ops-pipeline
cd ops-pipeline
kitchen list
kitchen converge headless
kitchen verify headless
```

## Add a new test
Add a new test in [test/integration/headless/serverspec/localhost](/test/integration/headless/serverspec/localhost) named new_test_spec.rb.  *Note: you need to name the file xxx_spec.rb*

``` ruby
require 'spec_helper'

describe package('tcpdump') do
  it { should be_installed }
end
```

Run the tests again:

``` bash
kitchen verify headless
```

```
Failures:

 1) Package "tcpdump" should be installed
    Failure/Error: it { should be_installed }
      expected Package "tcpdump" to be installed
      env PATH="/sbin:/usr/local/sbin:$PATH" /bin/sh -c dpkg-query\ -f\ \'\$\{Status\}\'\ -W\ tcpdump\ \|\ grep\ -E\ \'\^\(install\|hold\)\ ok\ installed\$\'

    # /tmp/verifier/suites/serverspec/localhost/new_test_spec.rb:4:in `block (2 levels) in <top (required)>'

Finished in 0.05801 seconds (files took 0.44578 seconds to load)
12 examples, 1 failure

Failed examples:

rspec /tmp/verifier/suites/serverspec/localhost/new_test_spec.rb:4 # Package "tcpdump" should be installed
```

## Make the test pass

To fix this test edit provision/chef/cookbooks/configure_headless/attributes/defaults.rb
 and add `tcpdump` to the list of packages we want installed.

 ``` diff
diff --git a/provision/chef/cookbooks/configure_headless/attributes/defaults.rb b/provision/chef/cookbooks/configure_headless/attributes/defaults.rb
index eea75eb..32b9e6c 100644
--- a/provision/chef/cookbooks/configure_headless/attributes/defaults.rb
+++ b/provision/chef/cookbooks/configure_headless/attributes/defaults.rb
@@ -1,5 +1,5 @@
default['configure_headless']['packages'] =
-  %w(bash ksh git subversion unzip libtool dos2unix)
+  %w(bash ksh git subversion unzip libtool dos2unix tcpdump)

case node[:platform]
when 'redhat', 'centos'
 ```

``` bash
kitchen converge headless
kitchen verify headless
```

And you should see success:
```
Package "tcpdump"
 should be installed
 ....
Finished in 0.0539 seconds (files took 0.33895 seconds to load)
17 examples, 0 failures
```
