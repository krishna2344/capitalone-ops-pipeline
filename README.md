[![License](https://img.shields.io/badge/license-Apache%202-blue.svg)](https://www.apache.org/licenses/LICENSE-2.0)

The Ops-Pipeline is an "infrastructure-as-code" project demonstrating the use of [Hashicorp's Packer](https://www.packer.io/)
and CM tools (principally [ChefSolo](https://docs.chef.io/chef_solo.html)
but in edge cases [Ansible](http://www.ansible.com/)) to consistently build
variously-purposed, non-trivial virtual machine images (virtualbox, vmware_desktop, and AWS AMIs) and containers
(Docker) across a set of operating systems (Ubuntu, Centos, and
Alpine) -- all with one set of scripts!

The "one set of scripts" is a packer.json file to define the targets, and
a ChefSolo role cookbook (or Ansible playbook) for the provisioning.

We make liberal use of TestKitchen to drive bats and ServerSpec tests of
image/container products.

We take this one step further by defining a [builder](https://github.com/capitalone/ops-pipeline/blob/master/Vagrantfiles/builder/Vagrantfile)
image for Jenkins with a Workflow job for building and testing the ops-pipeline.  Note: in
order to build VM images from within a VM image requires a hypervisor supporting nested virtualization,
such as VMWare Fusion, VMWare Workstation, or ESX.  (AWS does not support nested virtualization.)

This project also demonstrates pushing build artifacts to [Hashicorp's Atlas Platform](https://atlas.hashicorp.com)
to produce all targets, and provide persistent registry for hosting versioned images.  Atlas will also build AMI's at
AWS and push Docker containers to the [Docker Hub](https://hub.docker.com/).


# Background
This project began with the goal of providing a consistent method to help development teams
setup individual environments quickly by automating consistent
assemblies from manual instructions which in some cases spanned multiple pages and
hundreds of line-item steps.

With open source tools such as [Vagrant](https://www.vagrantup.com/),
we began to have some success in achieving our goal and in seeding a DevOps mentality earlier. We
continue to make use of Vagrant as the image consumption tool, but have moved image production
to Packer and CM tools as stated above.


# Ops-Pipeline Family of Virtual Machines

The currently supported images are [here](packer/README.md)

For specifics on package versions, please visit the [Release History](releases).

# Host System Requirements

 * For Docker and/or Java development, we recommend having at least 8Gb RAM on your host
    device as we allocate 4Gb RAM by default.  A full GUI-based desktop image will require more.
 * Less RAM is needed for microservices development in languages like Node, Python or Go.
    Tune this setting in the Vagrantfile.
 * We generally recommend having 10-20Gb free disk.

Here are the prerequisites which you'll first need to install before you can
begin using the Ops-Pipeline family of virtual machines:

* __Manual Install__:
  * [Git](https://git-scm.com/downloads)
  * [VirtualBox](https://www.virtualbox.org/wiki/Downloads) (You may also use VMWare Fusion, VMWare Workstation, or AppCatalyst.)
  * [Vagrant](https://www.vagrantup.com/downloads.html)
* __Mac OSX__ via [Homebrew](http://brew.sh/):
  ```
  $ # if Homebrew is not installed
  $ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  $ # update Homebrew if it was already installed
  $ brew update

  $ # if Cask is not installed
  $ brew install caskroom/cask/brew-cask

  $ # if Git is not installed
  $ brew install git

  $ # installs Vagrant & VirtualBox
  $ brew cask install vagrant virtualbox
  ```
* __Windows__ via [Chocolatey](https://chocolatey.org/):

  __NB:__ If you have previously installed Git, Vagrant & VirtualBox via
  the .msi installer, you may need to uninstall it if you would like to use
  Chocolatey going forward which is recommended for non-managed desktops.

  To install Chocolatey, open an administrative cmd.exe command prompt:
  ```
  C:\> @powershell -NoProfile -ExecutionPolicy Bypass -Command "iex
  ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))"
  && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin
  ```

  To install dependencies, open a non-privileged cmd.exd command prompt:
  ```
  C:\> REM installs Git, Vagrant & VirtualBox
  C:\> choco install git.install vagrant virtualbox
  ```

# Using the Ops-Pipeline Virtual Machines
The recommended pattern for installing and using an ops-pipeline virtual machine is
to copy the provided Vagrantfile into the base of your own GitHub repository.

1. Create a GitHub repository
2. Execute the steps below substituting _ghuser_ with your GitHub
   username and _your_repo_ with the name of the repository you created:

   ```
   $ git clone https://github.com/ghuser/your_repo.git
   $ cd your_repo

   $ # if you want to use the headless image, execute the following
   $ curl -O https://raw.githubusercontent.com/capitalone/ops-pipeline/master/Vagrantfiles/headless/Vagrantfile -o Vagrantfile

   $ # if you want to use the desktop image, execute the following
   $ curl -O https://raw.githubusercontent.com/capitalone/ops-pipeline/master/Vagrantfiles/desktop/Vagrantfile -o Vagrantfile

   $ vagrant up
   $ vagrant ssh
   ```
3. If you have chosen the desktop image, the login credentials for the GUI are
   username: `vagrant` and password: `vagrant`.

The Vagrantfile goes into the base of your project because Vagrant will sync the
current working directory to the `/vagrant` directory inside of the ops-pipeline
Virtual Machine.  This means you can continue to work on files on your host
machine and they will automatically be available within the ops-pipeline virtual
machine.  This is especially useful in the case of working on the headless
image as you can continue to use GUI IDEs for development.  Additionally, you
can execute `git` commands and they will work the same on your host machine and
within the ops-pipeline virtual machine.

# Additional Documentation
## [Adding a new use case into ops-pipeline](Vagrantfiles/README.md)
## [Building target images](provision/README.md)

# FAQ
FAQs are hosted [here](wiki/FAQ).

# Acknowledgements

* __Core Team__ (Packer/CM): Tom Scanlan, Brent Vukmer, Keith Gasser
* __Core Team__ (Vagrant/Ruby): Brent Vukmer, Etienne LaVallee, Harish Patel, Keith Gasser
* __Key Contributors__: Harish Patel, Larry Rosenzweig & Marshall Thompson
* __Executive Sponsors__: Jeff Elgin, Kranthi Dandamudi, Joelle Rowley, Darren McMahon
* __OSS Support__: Al Sell

