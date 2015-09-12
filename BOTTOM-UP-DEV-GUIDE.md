## Bottom-up exploration of Izanamee provisioning

* Git clone the Izanamee repository
* Open the Izanamee project in RubyMine
 * Use RubyMine to facilitate tracing the provisioning flow through different files
* Check out the topic branch
* Pick an existing shell script - the google-chrome-installer.sh
* Do Command-N and navigate to the given shell script
* Trace the chain of references to that file
 * You should find a Ruby module that encapsulates the shell script's name as a class-side variable
 * Find references to that class-side variable - should be a private provisioning method
 * Find references to the private provisioning method - should be a public provision() method
  * Take a look at the other private provisioning methods in that public provision() method
 * Find the references to that provision() method - should be Vagrantfiles
  * Take a look at the Vagrantfile - what other top-level provisioning modules are called?
  * How does the Vagrantfile process environment variables?  How do they get passed into Ruby modules' provisioning methods?
  * Try running the provisioner scripts directly on the command-line - test whether you've figured out what command-line arguments are getting passed in
  * Figure out this Ruby module gets loaded by the Vagrantfile - what if you need to create a new Ruby module?


