<img src="izanamee-logo.png" width="400" alt="izanamee"/>

### Environment setup done right!

#### Izanamee installation instructions

1. System requirements
  * Desktop: 16Gb RAM/20Gb SSD free
  * Headless: 8Gb RAM/5Gb SSD free

2. Install instructions for dependencies (vagrant, virtualbox):
  * __Mac OSX__: We recommend doing this via [Homebrew] (http://brew.sh/), i.e.
    * `brew update && brew cask install vagrant virtualbox`
    (if you do not have cask installed, run `brew install caskroom/cask/brew-cask`)

  * __Windows__: We recommend doing this via [Chocolatey] (https://chocolatey.org/), i.e.
    - `choco install vagrant virtualbox`
    - NOTE: if you have previously installed virtualbox manually, run the .msi installer and uninstall it if you would like to use choco going forward (recommended for non-managed desktops)
3. Clone this repo locally with git (if you do not have git installed, you may brew or choco install it as well)

4. First `vagrant up` to provision and register a VM image: you will need to build the desired image from the provision directory and then add the resulting .box file to your local vagrant registry.  This takes approximately 30 minutes for the desktop image and 5 minutes for the headless image.

5. Second `vagrant up` to create an VM instance from a registered VM image: cd to the launch sub-directory for the desired image you've already registered and run `vagrant up`.  The first time you launch, a VM instance is created in VirtualBox (requiring at most a couple minutes).
  * Subsequent launches of `vagrant up` re-use the instance in mere seconds of startup time...and you can always `vagrant destroy` the image to recover space or flush a corrupted instance, and restart a brand new VM instance from the registered VM image using the by now familiar `vagrant up`.
