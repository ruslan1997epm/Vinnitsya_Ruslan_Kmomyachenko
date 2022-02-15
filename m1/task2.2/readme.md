AWS Menegment console

https://gyazo.com/5afe12cc53aec9c28caa897c067ab79f

Launch a Linux Virtual Machinewith Amazon Lightsail

https://gyazo.com/78a49e90fc0a074d642b14ec9c1b1be6

https://gyazo.com/88d05021021e39e9d8e81a176433fb03

Launch a Linux Virtual Machine without Lightsail (wih EC2 Centos 7)

https://gyazo.com/4771e503d2f7e022ec5181d9e6cb22f6

create snapshot

# aws ec2 create-snapshot --volume-id vol-076b14b9a03c8b7bb --description "This is my centos volume snapshot"
{
    "Description": "This is my centos volume snapshot", 
    "Tags": [], 
    "Encrypted": false, 
    "VolumeId": "vol-076b14b9a03c8b7bb", 
    "State": "pending", 
    "VolumeSize": 8, 
    "StartTime": "2021-11-11T19:18:40.479Z", 
    "Progress": "", 
    "OwnerId": "554112663908", 
    "SnapshotId": "snap-06f4de23b3a4189bc"
}

https://gyazo.com/afa625fedd6865c17fd8f58add3931f4

Attach and mount additional 2Gb to the EC2 instance

# aws ec2 attach-volume --volume-id vol-0c43c83db0d0856cc --instance-id i-0af324db3112f7cb3 --device /dev/sdf
{
    "AttachTime": "2021-11-11T19:46:33.651Z", 
    "InstanceId": "i-0af324db3112f7cb3", 
    "VolumeId": "vol-0c43c83db0d0856cc", 
    "State": "attaching", 
    "Device": "/dev/sdf"
}

# lsblk
NAME    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
xvda    202:0    0    8G  0 disk 
└─xvda1 202:1    0    8G  0 part /
xvdf    202:80   0    2G  0 disk 
└─xvdf1 202:81   0  1.9G  0 part /opt

/opt/somecontent/some_file


restored instance from snapshot

https://gyazo.com/8da2612aba96d08fb0ee36ee0a1fbe9c

Unmount and detach volume from centos and attach to restored instance

# umount -d /dev/xvdf1
# lsblk
NAME    MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
xvda    202:0    0   8G  0 disk 
└─xvda1 202:1    0   8G  0 part /

aws ec2 detach-volume --volume-id vol-0c43c83db0d0856cc

https://gyazo.com/a2d50d545a644d2d571a1875adc88efa

aws ec2 attach-volume --volume-id vol-0c43c83db0d0856cc --instance-id i-0203fc3e304960239 --device /dev/sdf

$ lsblk
NAME    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
xvda    202:0    0    8G  0 disk 
└─xvda1 202:1    0    8G  0 part /
xvdf    202:80   0    2G  0 disk 
└─xvdf1 202:81   0  1.9G  0 part 


WordPress instance 

https://gyazo.com/4f640f5ab0340ff99cfefcda0a6fb08a

Create bucket on S3 

https://gyazo.com/c48c3fdcec6b21cb072e432525fe2ad5
Upload file and remove file

https://gyazo.com/6fd6aa1ed12ec65dee14b5f870f67aba
https://gyazo.com/40c744a1ecefdb1d67cf0dbe0d26fb41

Create bucket and upload file

~$ aws s3 mb s3://ruslan-backup-bucket
~$ aws s3 cp prometheus-2.31.0-rc.1.linux-amd64.tar.gz s3://ruslan-backup-bucket
upload: ./prometheus-2.31.0-rc.1.linux-amd64.tar.gz to s3://ruslan-backup-bucket/prometheus-2.31.0-rc.1.linux-amd64.tar.gz


Run Docker image
14. ~$ docker image ls
REPOSITORY    TAG       IMAGE ID       CREATED          SIZE
redis-image   latest    c8c99a870321   43 seconds ago   109MB

ubuntu@ip-172-31-24-210:~$ docker run -d -p 6379:6379 --name redis redis-image
992db622a1db51a8e90d5f7b4d282c1ec495e841fca0b6f6aec1ef2182f75f49

ubuntu@ip-172-31-24-210:~$ docker container ls
CONTAINER ID   IMAGE         COMMAND                  CREATED          STATUS          PORTS                                       NAMES
992db622a1db   redis-image   "redis-server '--pro…"   11 seconds ago   Up 10 seconds   0.0.0.0:6379->6379/tcp, :::6379->6379/tcp   redis

~$ redis-cli ping
PONG

Create an Amazon ECR repository

~$ aws ecr create-repository --repository-name redis-repository --region us-east-2
{
    "repository": {
        "registryId": "554112663908",
        "repositoryArn": "arn:aws:ecr:us-east-2:554112663908:repository/redis-repository",
        "createdAt": 1636900180.0,
        "repositoryUri": "554112663908.dkr.ecr.us-east-2.amazonaws.com/redis-repository",
        "repositoryName": "redis-repository"
    }
}

docker tag redis-image 554112663908.dkr.ecr.us-east-2.amazonaws.com/redis-repository


~$ aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 554112663908.dkr.ecr.us-east-2.amazonaws.com

WARNING! Your password will be stored unencrypted in /home/ubuntu/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store

Login Succeeded

Push the image to Amazon ECR

~$ docker push 554112663908.dkr.ecr.us-east-2.amazonaws.com/redis-repository
Using default tag: latest
The push refers to repository [554112663908.dkr.ecr.us-east-2.amazonaws.com/redis-repository]
f2ac0de6bce4: Pushed 
9f54eef41275: Pushed 
latest: digest: sha256:85bc9ebc1d94c2ed28fe4723f7ce39b707bcee43b5673c0584f3b7291ab36d07 size: 741

https://gyazo.com/cbfa85fc6d016750ba9829b1dc64e540

~$ aws ecr delete-repository --repository-name redis-repository --region us-east-2 --force
{
    "repository": {
        "repositoryArn": "arn:aws:ecr:us-east-2:554112663908:repository/redis-repository",
        "registryId": "554112663908",
        "repositoryName": "redis-repository",
        "repositoryUri": "554112663908.dkr.ecr.us-east-2.amazonaws.com/redis-repository",
        "createdAt": "2021-11-14T14:29:40+00:00",
        "imageTagMutability": "MUTABLE"
    }
}

15. https://gyazo.com/555af6eb1d8dd41ddfbf498790fe71c0

http://khomyachenko.click/








