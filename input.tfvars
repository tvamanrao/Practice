my_region = "us-west-2"
my_vpc_cidr = "172.30.0.0/16"
subnet = {
    sn_name = ["Private_SN", "Public_SN"]
    sn_range = [ 9, 10 ]
}
pub_cidr = "0.0.0.0/0"
secgrp = "Security Group"
sshkey_pair = {
  ssh_key_name = "oel7u9_tf"
  ssh_pub_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDTNcZ0+wqfM7zSUqZUNSiOFsJTrCse+WuWNFQyglVd2oxLr+RlL/cMSd6t91NyNeaSxTTJ4F5tbPjgXmkX9y1+3Ce58E+qhUqfYAgu6jgPNgKKypIk9ZgqQEdngqKLSL89Y4eEO65zq9D1zu3YQnvNKCUNQmkHejBehgC6SRghJuRsPcAhZZvXLQCZSrUlfKJC3cn9MewWkjUPTlfyeY53j6DmFJYubNEmjSRE4FOBbxbT649ysCZRRc6bTSiZJifDm6kEmVG7WY5LJiABUetrDlY0CAtWZnfVw1nTewK2ErtonOsbF+Rqz1c619sdkW2Kmz4M7mZ5s+hofAGFLEVN imported-openssh-key"
}
ec2_name = {
  name = [ "ubuntu-app01", "ubuntu-app02" ]
}
//ami_id = "ami-08970fb2e5767e3b8" /*RHEL 8 AMI-ID*/
ami_id = "ami-017fecd1353bcc96e" //Ubuntu 22.04
ava_zone = "us-west-2a"