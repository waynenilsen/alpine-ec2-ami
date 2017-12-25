# Alpine Linux EC2 AMI Build

**NOTE: This is not an official Amazon or AWS provided image. This is community
built and supported.**

This repository contains a packer file and a script to create an EC2 AMI
containing Alpine Linux. The AMI is designed to work with most EC2 features
such as Elastic Network Adapters and NVME EBS volumes by default. If anything
is missing please report a bug.

This image can be launched on any modern instance type. Including T2, M5, C5,
I3, R4, P2, P3, X1, X1e, D2. Other instances may also work but have not been
tested. If you find an issue with instance support for any current generation
instance please file a bug against this project.

To get started use one of the AMIs below. The default user is `alpine` and will
be configured to use whatever SSH keys you chose when you launched the image.
If user data is specified it must be a shell script that begins with `#!`. If a
script is provided it will be executed as root after the network is configured.

**Note:** This image will be updated as Alpine Linux changes over time and as
AWS adds regions. This file and
[releases.yaml](https://github.com/mcrute/alpine-ec2-ami/blob/master/releases.yaml)
will be updated as new regions are made available.

| Alpine Version | Region Code | AMI ID |
| -------------- | ----------- | ------ |
| 3.7 | ca-central-1 | [ami-ba3a80de](https://ca-central-1.console.aws.amazon.com/ec2/home#launchAmi=ami-ba3a80de) |
| 3.7 | us-west-1 | [ami-971f19f7](https://us-west-1.console.aws.amazon.com/ec2/home#launchAmi=ami-971f19f7) |
| 3.7 | eu-west-2 | [ami-d8b2abbc](https://eu-west-2.console.aws.amazon.com/ec2/home#launchAmi=ami-d8b2abbc) |
| 3.7 | sa-east-1 | [ami-e233738e](https://sa-east-1.console.aws.amazon.com/ec2/home#launchAmi=ami-e233738e) |
| 3.7 | eu-west-1 | [ami-5589062c](https://eu-west-1.console.aws.amazon.com/ec2/home#launchAmi=ami-5589062c) |
| 3.7 | ap-south-1 | [ami-77a8e218](https://ap-south-1.console.aws.amazon.com/ec2/home#launchAmi=ami-77a8e218) |
| 3.7 | ap-southeast-1 | [ami-4fc8a133](https://ap-southeast-1.console.aws.amazon.com/ec2/home#launchAmi=ami-4fc8a133) |
| 3.7 | ap-southeast-2 | [ami-afdb2bcd](https://ap-southeast-2.console.aws.amazon.com/ec2/home#launchAmi=ami-afdb2bcd) |
| 3.7 | ap-northeast-1 | [ami-0cd5416a](https://ap-northeast-1.console.aws.amazon.com/ec2/home#launchAmi=ami-0cd5416a) |
| 3.7 | ap-northeast-2 | [ami-909c3dfe](https://ap-northeast-2.console.aws.amazon.com/ec2/home#launchAmi=ami-909c3dfe) |
| 3.7 | eu-central-1 | [ami-5cb92e33](https://eu-central-1.console.aws.amazon.com/ec2/home#launchAmi=ami-5cb92e33) |
| 3.7 | us-east-1 | [ami-c3dc9ab9](https://us-east-1.console.aws.amazon.com/ec2/home#launchAmi=ami-c3dc9ab9) |
| 3.7 | us-west-2 | [ami-6ac26d12](https://us-west-2.console.aws.amazon.com/ec2/home#launchAmi=ami-6ac26d12) |
| 3.7 | us-east-2 | [ami-fc8aa299](https://us-east-2.console.aws.amazon.com/ec2/home#launchAmi=ami-fc8aa299) |

## Caveats

This image is being used in production but it's still somewhat early stage in
its development and thus there are some sharp edges.

- Only EBS-backed HVM instances are supported. While paravirtualized instances
  are still available from AWS they are not supported on any of the newer
  hardware so it seems unlikely that they will be supported going forward. Thus
  this project does not support them.

- Not all packages required have been merged into the upstream aports tree.
  When they are they will still only be available on edge. Until then the image
  sources a few packages from a testing repo managed by the owner of this
  repository. The builds in this repository should be identical to what is
  eventually merged into the official tree.

- [cloud-init](https://cloudinit.readthedocs.io/en/latest/) is not currently
  supported on Alpine Linux. Instead this image uses
  [tiny-ec2-bootstrap](https://github.com/mcrute/tiny-ec2-bootstrap). Hostname
  setting will work as will setting the ssh keys for the Alpine user based on
  what was configured during instance launch. User data is supported as long
  as it's a shell script (starts with #!). See the tiny-ec2-bootstrap README
  for more details. You can still install cloud-init using aports but the
  version in the tree is somewhat old and may not work correctly for Alpine.
  If full cloud-init support is important to you please file a bug against this
  project.

- CloudFormation support is still forthcoming. This requires patches and
  packaging for the upstream cfn tools that have not yet been accepted.
  Eventually full CloudFormation support will be available.
