#Izanamee - Xubuntu Server 14.04 VM#
This izanamee virtual machine configuration provides both a provisioning script and the launcher script for running a stock Ubuntu Trusty Tahr Server 14.04LTS with the XFCE/Xubuntu windows manager updates to provide a server-oriented environment with a lightweight windows environment.

The launcher will simply initialize a copy of a preprovisioned virtual machine and launch it.

The provisioner will initialize the virtual machine using a stock ubuntu-trusty-64 server image and then install the Xubuntu desktop system and configuration. Additionally, this provisioner adds Google Chrome, updates Firefox and Chrome to use the CapitalOne proxy pac-file configuration, and disables the xscreensaver.

##Pre-requisites for Izanamee##
In order to use this virtual machine, you must first have your system configured to use vagrant, virtualbox and izanamee.

##Running Pre-provisioned VM##
Once the virtual machine has been added to your environment (see previous subsection) you can launch the virtual machine by running the following command in the [[izanamee-home]]/01-gui-base/launch directory:

```
$> vagrant up
```

To shutdown the virtual machine, run the following command in the same directory:

```
$> vagrant halt
```

If you wish to access the virtual machine while it's running, the following command will ssh you into the running instance:

```
$> vagrant ssh
```

##Provisioning VM##
[[NOTE: Provisioning a fresh VM from scratch is not recommended for general use, please see the pre-provisioned VM instructions above.  If you do want to provision the VM from scratch, follow these instructions.  YMMV]]

To provision a fresh copy of the appliance virtual machine, change directory to the [[izanamee-home]]/01-gui-base/provision directory and execute the following command:

```
vagrant up
```

If your environment is properly configured for vagrant provisioning and the izanamee provisioning library, then you should see a success message once the provisioner has completed rebuilding the virtual machine.
