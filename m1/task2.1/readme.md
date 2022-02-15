The most popular hypervisors are:
1. VMware
2. Microsoft Hyper-V
3. Citrix XenServer
4. Oracle VirtualBox

Hyper-V is a type 1 hypervisor that is also called a bare metal hypervisor, and runs directly on a computer’s hardware. When a physical computer (a host) starts, a Hyper-V hypervisor takes control from BIOS or UEFI. Then, Hyper-V starts the management operating system, which can be Hyper-V Server, Windows, or Windows Server. Virtual machines can be started manually by user or automatically, depending on its settings.

VirtualBox is a type 2 hypervisor that is sometimes called a hosted hypervisor. A type 2 hypervisor is an application that runs on the operating system (OS) and is already installed on a host. When a physical computer starts, the operating system installed on the host loads and takes control. A user starts the hypervisor application (VirtualBox in this case) and then starts the needed virtual machines. VM hosted processes are created.

Hyper-V is always on if the host is powered on, while the VirtualBox can be started and closed by a user on demand.

The major key difference in-between VirtualBox and VMware is the software virtualization. Hence, VMware will not able to install on the existing operating system like the VirtualBox. It needs a dedicated host on top of it will install

group of VM
https://gyazo.com/6dc39f2a155a5e95f65593bb39ddf62c

snapshots

https://gyazo.com/1518b98917b5b092fba0c9236d70c122
https://gyazo.com/6dc39f2a155a5e95f65593bb39ddf62c

clone 
https://gyazo.com/9cb2e26eb6ae48fb207717036dcbb246

USB configured
sudo adduser $USERNAME vboxusers

shared folder

VBoxManage sharedfolder add "ubuntu_khomyachenko" --name Dwnldshare --hostpath "/home/ruslan_khomyachenko/Dwnldshare/"

sudo usermod -a -G vboxusers

/media/sf_Dwnldshare

https://gyazo.com/24fd2b2323e854336a22a4ee67c19d0b

NAT network

https://gyazo.com/39165e971b567dbabece951e73068c90

Vagrant 

/usr/bin/vagrant

vagrant up and vagrang ssh

https://gyazo.com/c5de1a7e073fbe3d4d1a533feec01a99
https://gyazo.com/a1768e19c89d27f4a273060f9a252378

remove box 

https://gyazo.com/7616c5b21fdf73851c1da1cc78fd24cc




