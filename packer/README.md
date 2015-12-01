
# Using the packer configurations

1. **headless-ami.json**

    This build an ami based on a 14.04 ubuntu ami, provisions it as a headless unit, and saves the result as an ami.  You'll need to setup your ~/.awx/credentials file to point to a valid aws credential.  You'll also need to update the subnet_id, vpc_id, and security_group_id with ids that exist for your account.

1. **sonar-build-ami.json**

    Based on the headless-ami, adds a sonar and jenkins server.  Configures a jenkins job to demo using the two together

1. **headless-stage-1.json**

    Basic headless machine, just the build from ISO to a VM for virtualbox and vmware

1. **headless-stage-2.json**

    Basic headless machine.  Building from the VM of stage-1 to vagrant boxes for vmware and virtualbox providers.

1. **headless.json**

    Both stage-1 and stage-2 as one full build.  Intended for pushing to Atlas for making a full public box build.

1. **desktop.json**

    Both stage-1 and stage-2 as one full build.  Intended for pushing to Atlas for making a full public box build.

1. **desktop-stage-2.json**

    Based on headless-stage-1.json, continues provisioning as a desktop image, and finishes by making vagrant boxes for vmware and virtualbox

1. **docker-headless-slim.json**

    Makes an alpine based docker image that can be provisioned using ansible.

1. **docker-headless-ubuntu.json**

    Makes an ubuntu based docker image, provisioned just as the headless from above


# building AMIs

For notes on how to set up amazon for building see [Packer Amazon Builder Setup](https://www.packer.io/docs/builders/amazon.html)

In particular read the section on the *IAM Role configuration* and *credentials lookup*.

Once you have setup the account, you'll be able to run:

    packer build \
    -var "instance_type=t2.micro" \
    -var "ssh_username=ubuntu" \
    -var "vpc_id=vpc-XXX" \
    -var "security_group_id=sg-XXX" \
    -var "subnet_id=subnet-XXX" \
    -var "region=us-east-1" \
    -var "source_ami=ami-XXX" \
    packer/sonar-build-ami.json
*Note: you'll need to update some of the vars to fit your EC2 setup.*
