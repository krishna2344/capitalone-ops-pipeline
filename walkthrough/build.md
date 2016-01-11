# Build an existing packer template


## Build locally

You can build locally using the same packer template as used to build on Atlas.  One issue with doing so is that the post processors upload vms and docker images totaling many GB to docker hub and Atlas, which will generally not be good for your pipes. Use *packer/headless.json* to generate artifacts, but not upload them.

```
git clone https://github.com/capitalone/Izanamee.git izanamee
cd izanamee

export docker_repo_username=username
export docker_repo_password=password
export docker_repo_server="local repo, or empty to use dockerhub"
export docker_repo_email=email@example.com

./packer/build-iso-to-vm.sh
version=0.67 packer build  packer/headless.json
```

## build on atlas

This can also be used to build locally, but will trigger a very large upload.

```
export ATLAS_TOKEN=dxjfXssbARWwzQ.atlasv1.LGGrcd5Acv55tePGDklHnksDJwCwC9gnyN3QWYe5c3A7Jqw06FMcX9Nj82Etls12qkE
berks vendor provision/chef/vendor-cookbooks &&  ansible-galaxy install --force -r galaxy.yml
version=0.67 packer push packer/push-headless.json
```