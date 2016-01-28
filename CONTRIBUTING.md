# Contributing
We are currently in the midst of converting our Vagrant box build pipeline from
custom build scripts with custom Ruby provisioners and Bash scripts to
Hashicorp's Atlas build pipeline using [Packer](https://packer.io/) and
[Chef-Solo Provisioning](https://www.packer.io/docs/provisioners/chef-solo.html).

That being said, we are only able to accept pull requests at this time for
functionality that is currently broken in our opspipeline boxes.  Once this
migration has occured, we will be opening up contributions for new functionality
in addition to bug fixes.

To contribute:

1. Sign our [Contributor License Agreement](https://docs.google.com/forms/d/19LpBBjykHPox18vrZvBbZUcK6gQTj7qv1O5hCduAZFU/viewform)
2. Fork the repository on GitHub
3. Create a named feature branch (like `add_component_x`)
4. Write your change
5. Write tests for your change (if applicable).  We will provide more guidance on
    automating your tests following our migration.
6. Run the tests, ensuring they all pass
7. Submit a Pull Request with your tests using GitHub
 
