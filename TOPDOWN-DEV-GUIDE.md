## Top-down exploration of Izanamee provisioning

## Prototyping provisioning

To understand Izanamee, you may want to do a quick hands-on spike, just using a vanilla Linux VM.

* Start with something specific you want to provision:
  * the Chrome browser
  * the Gradle build tool
  * JDK 8
* Search GitHub repo for keyword ("chrome")
 * Look at both Issues and Code to see if there's existing code to extend/enhance, or at least imitate
  * Check Issues to see if the fix/enhancement you want is already being worked on
 * If it's not already covered by a Izanamee provisioner - search Stack Overflow, read man pages, etc. -> figure out one-liners for each incremental piece of provisioning
* Open vanilla Linux VM
* Test one-liners in the console
* Pull one-liners into Bash script
* Parameterize Bash script; supply parameters as environment variable or command-line argument
* Save Bash script as a Gist
* Have other developers validate Gist via "curl $URL | sudo sh"

But after a while, you've got a large and growing number of shell scripts.  You're managing your VM by hand (bringing it up, configuring memory and networking, setting up file shares, etc.).  And you're have to keep track of what order to run your various scripts, and the environment variables they need.  

If only there were an open-source tool to make all this easier....  Try Vagrant! 
* Vagrant is a handy way to prototype automated provisioning of VM images
 * You may want to pause here and try out the [Vagrant "Getting Started" guide](https://docs.vagrantup.com/v2/getting-started/)
* Once you've got a shell script (or small set of related shell scripts) that encapsulates installing and configuring a useful feature, Vagrant provides a nice DSL for orchestrating batches of shell scripts 
 * The Vagrant docs recommend starting with [shell-based provisioning](https://docs.vagrantup.com/v2/provisioning/shell.html) for your first [Vagrantfile](https://docs.vagrantup.com/v2/vagrantfile/index.html), so that you're not ascending multiple learning curves (Vagrant AND Chef or Vagrant AND Puppet, etc.)

 
Great!  Now you've got a Vagrantfile that pulls together your provisioning scripts, and does the necessary VM configuration as well.  But that Vagrantfile is looking awfully big .. and it's a combination of provisioning (one-time installation and configuration of features) and launching (starting the image with user-specific settings).   Also, Vagrant doesn't try to provide a way to share provisioning modules across Vagrantfiles - so multiple Vagrantfiles are not just verbose, but duplicative.   

## Izanamee codebase - layout and rationale

In Izanamee, we've separated the "launch" and "provision" logic by convention, into separate Vagrantfiles.  We've also created a lightweight set of Ruby modules that encapsule the shell script provisioners, so that Vagrantfiles can reference Ruby methods.  This is much more concise.  It also makes the Izanamee code-base much easier to navigate, if you're using the RubyMine IDE, by command-clicking on method names.

* The Izanamee project is laid out as follows:
  * module-name (for example, 'iz')
    * module-mode ('headless', 'desktop')
      * vagrant-mode ('provision', 'launch')
  * lib/izanamee/provisioner
  	* resources (files that need to be copied into the VM - typically config files)
  	* scripts (Bash scripts that implement fine-grained installer/configurer logic)
  	* installer and configure .rb files containing provisioner modules
  	 * The names of these files correlate with the directory names in scripts/ and resources/ 
    * provisioners.rb - used to import provisioner modules into Vagrantfiles

For these reasons, for production-oriented image builds, Izanamee will soon move to a new toolchain, consisting of:
* [Packer](https://packer.io/) 
* [Chef Zero](https://github.com/chef/chef-zero) 
* [Chef Test Kitchen](https://github.com/test-kitchen/test-kitchen) 
