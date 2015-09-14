
# How to rebuild the Izanamee VMs

There are 2 main ways to go about building more future Izanamee revisions.

1. Leverage [Atlas](https://atlas.hashicorp.com/) to build and host boxes
2. Stand up a local VMware vm with tools to build the VMs and manage
   your own vagrant version catalog

## Leverage Atlas

### Atlas high level workflow
The builds intended for Atlas are at `packer/headless.json` and `packer/desktop.json`.
Running `packer push` with those will

1. send the packer configuration and all needed provisioning tools
1. install a base vm from iso
1. add guest tools
1. provision as either headless or desktop
1. package boxes for VMware and virtualbox
1. upload those boxes to Atlas

### Actual steps for pushing to Atlas

1. Get an account at [Atlas](https://atlas.hashicorp.com/)

2. Run the following to bring up a vm with the right tools for packer

        $ git clone git@github.com:capitalone/Izanamee.git
        $ cp Vagrantfiles/builder/Vagrantfile .
        $ # the provider could also be vmware_workstation
        $ # or vmware_appcatalyst for your OS
        $ vagrant up --provider=vmware_fusion
        $ berks vendor provision/chef/vendor-cookbooks

3. push the build to Atlas

        $ vagrant ssh
        $ cd /vagrant
        $ # get this token from Atlas website, settings, tokens
        $ export ATLAS_TOKEN=9NS.....xxxxx
        $ packer push packer/headless.json
        $ # this returns after uploading the local tree to atlas
        $ # check Atlas to see when build is complete

## Build your own build server for building VMs

This requires that you have a VMware hypervisor.  Virtualbox doesn't fully
support nested vms.

*Note, you'll need to manually set VMware Workstation to use a trial license,
 or set a real license number in the jenkins-master attributes.  Get into
 the desktop, and run Workstation once to set the license.  Alternativly, you can
 set one in the provisioning, just be careful not to let a license get committed.*

1. Stand up a VM with tools to package virtualbox and VMware vms

        $ # stand up a build server
        $ git clone git@github.com:capitalone/Izanamee.git
        $ cp Vagrantfiles/builder/Vagrantfile .
        $ # the provider could also be vmware_workstation or vmware_appcatalyst for your OS
        $ vagrant up --provider=vmware_fusion
        $ berks vendor provision/chef/vendor-cookbooks


1. Log in and start a build.
   Builds can be done as 2 stages to allow saving some time if you care to reuse
   the same base VM as a starting point for provisioning.

        $ vagrant ssh
        $ cd /vagrant
        $ version=0.20

        $ # first stage builds the vms, which can be re-used in stage2
        $ packer build -var "version=$version" packer/headless-stage-1.json

        $ # second stage packages the boxes by provisioning on top of the base vm
        $ packer build -var "version=$version" packer/headless-stage-2.json

        $ # later ....
        $ ls *.box

        $ # Add the boxes to your local setup.
        $ # Alternativly, upload them to a url internally (discussed below), or atlas.
        $ vagrant box add --force --name izanamee/headless headless-vmware-iso-${version}.box
        $ vagrant box add --force --name izanamee/headless headless-virtualbox-iso-${version}.box


## setting up an internal box repo:

You could use Artifactory for hosting an internal vagrant repo, or setup a web server
to serve the following files and boxes at the correct urls.

Write a catalog.json file similar to this.  Update version numbers, and checksums.

      "name": "Izanamee",
      "description": "Izanamee, based on ubuntu-14.04 LTS",
      "versions": [
          {
              "version": "0.1",
              "providers": [
                  {
                      "name": "virtualbox",
                      "url": "http://reposerver.local/izanamee/headless-virtualbox-0.1.box",
                      "checksum_type": "sha1",
                      "checksum": "46841c18ebd41344cfb28409b2a9c5ff43ae1bf2"
                  },
                  {
                      "name": "vmware_desktop",
                      "url": "http://reposerver.local/izanamee/headless-vmware-0.1.box",
                      "checksum_type": "sha1",
                      "checksum": "960d0dfe6fdb38a3a96f68128b2a01c096f6dc85"
                  }
              ]
          },
          {
              "version": "0.2",
              "providers": [
                  {
                      "name": "virtualbox",
                      "url": "http://reposerver.local/izanamee/headless-virtualbox-0.2.box",
                      "checksum_type": "sha1",
                      "checksum": "88122aa0dd3494cef7379d97d92d36d2d4d14ab1"
                  },
                  {
                      "name": "vmware_desktop",
                      "url": "http://reposerver.local/izanamee/headless-vmware-0.2.box",
                      "checksum_type": "sha1",
                      "checksum": "a470e3ff5e30714cd8f5b9ffc0e5304d273675d1"
                  }
              ]
          },
          {
              "version": "0.4",
              "providers": [
                  {
                      "name": "virtualbox",
                      "url": "http://reposerver.local/izanamee/headless-virtualbox-iso-0.4.box",
                      "checksum_type": "sha1",
                      "checksum": "ed130d4ca164b42db3575b439f361fbda3e9fa26"
                  },
                  {
                      "name": "vmware_desktop",
                      "url": "http://reposerver.local/izanamee/headless-vmware-iso-0.4.box",
                      "checksum_type": "sha1",
                      "checksum": "c0ec071e38ad5988a5ce502125c65c01be675379"
                  }
              ]
          }
      ]
  }

In your `Vagrantfile`, add the following:

    config.vm.box = "izanamee/headless"
    config.vm.box_url = "http://reposerver.local/izanamee/catalog.json"

Now, initial vagrant up will download the latest version in the catalog.  You can also destroy
and re-up with the latest version.


## Testing chef-solo with test kitchen

Install (Test Kitchen)[https://github.com/test-kitchen/test-kitchen]

If you are updating chef recipies, you'll want to write a test first,
then run the following for the platforms you want to test against.  You
should get passing tets before committing the changes.

    kitchen converge virtualbox
    kitchen verify virtualbox

This iterates through upping, provisioning, and testing the headless and desktop
Izanamee boxes for virtualbox provider.  The following commands do the same for the
vmware provider.

    kitchen converge vmware
    kitchen verify vmware

## Troubleshooting build problems

#### `==> vmware-iso: Error starting VM: VMware error: Error: The operation was canceled`

That error may show up if your build vm doesn't have enough ram to bring up the contained vmware vm.

#### for verbose logging, run with

    PACKER_LOG=1  PACKER_LOG_PATH=./debug.log packer build headless-stage-1.json
    PACKER_LOG=1  PACKER_LOG_PATH=./debug.log packer build headless-stage-2.json

#### if you can't figure out the error, look for logs from the vm provider.

Start a build on command line, use `^z` to send it into the background.  Look for
logfiles undoer the output-* directories.  That will contain errors directly from
the vm provider.  They will get cleaned up when the build finishes well or failed,
so you'll need to see them before the build ends.
