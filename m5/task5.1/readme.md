1-2. root@Ruslan:~# passwd
Enter new UNIX password: 
Retype new UNIX password: 
passwd: password updated successfully

The passwd command changes passwords for user accounts. A normal user may only change the password for his/her own account, while the superuser may change the password for any account.
passwd also changes the account or associated password validity period.

The passwd is used to update a user’s authentication token (password) stored in /etc/shadow file

3. # awk -F: '{ print $1}' /etc/passwd
root
daemon
bin
sys
sync
games
man
lp
mail
news
uucp
proxy
www-data
backup
list
irc
gnats
nobody
systemd-network
systemd-resolve
syslog
messagebus
_apt
uuidd
avahi-autoipd
usbmux
dnsmasq
rtkit
cups-pk-helper
speech-dispatcher
whoopsie
kernoops
saned
pulse
avahi
colord
hplip
geoclue
gnome-initial-setup
gdm
ruslan_khomyachenko
nm-openvpn
root@Ruslan:~# cut -d : -f 1 /etc/passwd
root
daemon
bin
sys
sync
games
man
lp
mail
news
uucp
proxy
www-data
backup
list
irc
gnats
nobody
systemd-network
systemd-resolve
syslog
messagebus
_apt
uuidd
avahi-autoipd
usbmux
dnsmasq
rtkit
cups-pk-helper
speech-dispatcher
whoopsie
kernoops
saned
pulse
avahi
colord
hplip
geoclue
gnome-initial-setup
gdm
ruslan_khomyachenko
nm-openvpn

Each line line in /etc/passwd is a separate user account. There are seven fields delimited by colons that contain the following:

    User name
    Encrypted password (x means that the password is stored in the /etc/shadow file)
    User ID number (UID)
    User’s group ID number (GID)
    Full name of the user (GECOS)
    User home directory
    Login shell (defaults to /bin/bash)

To determine the user's commands ~# cat /home/ruslan_khomyachenko/.bash_history

4. Chnage user: password passwd username

   Chnage username: usermod -l newlogin oldlogin
```
~# chfn ruslan_khomyachenko
Changing the user information for ruslan_khomyachenko
Enter the new value, or press ENTER for the default
	Full Name [Ruslan]: Ruslan_Khomyachenko
	Room Number []: 
	Work Phone []: 
	Home Phone []: 
	Other []: 
```
5. man passwd or info passwd 
```
passwd -S -a ---> report password status on all accounts
passwd -d ----> delete the password for the named account
```

6. less /home/ruslan_khomyachenko/.bash_history

https://gyazo.com/dd1125d006c2e103ca462fa7761cb5b0

more /home/ruslan_khomyachenko/.bash_history

https://gyazo.com/53a1219caa5a6442c275550b6a0c3d29
Similar to more, less command allows you to view the contents of a file and navigate through file. The main difference between more and less is that less command is faster because it does not load the entire file at once and allows navigation though file using page up/down keys

7. The finger displays information about the system users.
```
~# finger -s root
Login     Name       Tty      Idle  Login Time   Office     Office Phone
root      root        *     *  No logins   
```
```
~# finger -s ruslan_khomyachenko
Login               Name         Tty      Idle  Login Time   Office     Office Phone
ruslan_khomyachenko Ruslan_Khom *:0             Nov 29 19:23 (:0)
```
```
~# finger -s daemon
Login         Name               Tty      Idle  Login Time   Office     Office Phone
avahi         Avahi mDNS daemon   *     *  No logins   
avahi-autoipd Avahi autoip daem   *     *  No logins   
colord        colord colour man   *     *  No logins   
daemon        daemon              *     *  No logins   
kernoops      Kernel Oops Track   *     *  No logins   
pulse         PulseAudio daemon   *     *  No logins   
usbmux        usbmux daemon       *     *  No logins   
```
8.
```
~# ls
snap

~# ls -la
total 48
drwx------  6 root root 4096 Dec  9 10:50 .
drwxr-xr-x 24 root root 4096 Nov 30 15:57 ..
-rw-------  1 root root 2924 Dec 10 21:03 .bash_history
-rw-r--r--  1 root root 3106 Apr  9  2018 .bashrc
drwx------  3 root root 4096 Nov 21 22:52 .cache
drwxr-xr-x  2 root root 4096 Dec  9 10:22 hardlink
-rw-r--r--  1 root root  148 Aug 17  2015 .profile
-rw-r--r--  1 root root  729 Dec  1 19:48 rootfolders.txt
drwxr-xr-x  7 root root 4096 Apr 22  2021 snap
drwx------  2 root root 4096 Mar 27  2020 .ssh
lrwxrwxrwx  1 root root   49 Dec  9 10:11 symb_lnk_labwork2 -> /home/ruslan_khomyachenko/Documents/test/labwork2
-rw-------  1 root root 4355 Dec  9 10:50 .viminfo

```
```
~# ls -la
total 32
drwx------  5 root root 4096 Nov 22 00:00 .
drwxr-xr-x 24 root root 4096 Nov 30 15:57 ..
-rw-------  1 root root  222 Nov 22 00:00 .bash_history
-rw-r--r--  1 root root 3106 Apr  9  2018 .bashrc
drwx------  3 root root 4096 Nov 21 22:52 .cache
-rw-r--r--  1 root root  148 Aug 17  2015 .profile
drwxr-xr-x  7 root root 4096 Apr 22  2021 snap
drwx------  2 root root 4096 Mar 27  2020 .ssh
```

Part 2

1. 

~# tree -f -P cata*
~# tree -d -L 2
2.
````
# file *
backup-11.28.2020_12-53-52_forasbcl.tar.gz:  gzip compressed data, last modified: Sat Nov 28 06:54:52 2020, from Unix
backup-2.9.2021_20-07-22_greenbe3219.tar.gz: HTML document, ASCII text, with CRLF line terminators
bdddd :                                      ASCII text
Desktop:                                     directory
Documents:                                   directory
Downloads:                                   directory
Dwnldshare:                                  directory
Gyazo-for-Linux.git:                         HTML document, UTF-8 Unicode text, with very long lines
inodinfo:                                    Bourne-Again shell script, ASCII text executable
issues:                                      HTML document, UTF-8 Unicode text, with very long lines
keyy:                                        ASCII text
khomyachenko:                                directory
latest.tar.gz:                               gzip compressed data, last modified: Thu Aug  2 20:39:45 2018, from Unix
Music:                                       directory
mywebsite.com:                               directory
Pictures:                                    directory
pt:                                          directory
Public:                                      directory
rkhomyachenko.ovpn:                          ASCII text, with CRLF line terminators
script:                                      Bourne-Again shell script, ASCII text executable
slack-desktop-4.0.2-amd64.deb:               Debian binary package (format 2.0)
snap:                                        directory
Templates:                                   directory
test:                                        empty
TESTING:                                     directory
Untitled Document 1:                         ASCII text
vagrant_2.2.6_x86_64.deb:                    Debian binary package (format 2.0)
Videos:                                      directory
VirtualBox VMs:                              directory
```
3.
cd ~

4.
```
~# ls -l
total 4
drwxr-xr-x 7 root root 4096 Apr 22  2021 snap
```
```
~# ls -a
.  ..  .bash_history  .bashrc  .cache  .profile  snap  .ssh
```
```
ls -a displays the hiden files and directories unlike ls -l
```
I always use 
```
~# ls -la
total 32
drwx------  5 root root 4096 Nov 22 00:00 .
drwxr-xr-x 24 root root 4096 Nov 30 15:57 ..
-rw-------  1 root root  222 Nov 22 00:00 .bash_history
-rw-r--r--  1 root root 3106 Apr  9  2018 .bashrc
drwx------  3 root root 4096 Nov 21 22:52 .cache
-rw-r--r--  1 root root  148 Aug 17  2015 .profile
drwxr-xr-x  7 root root 4096 Apr 22  2021 snap
drwx------  2 root root 4096 Mar 27  2020 .ssh
```

5.
```
tree -d > /home/ruslan_khomyachenko/task5.1/rootfolders.txt
```
```
less /home/ruslan_khomyachenko/task5.1/rootfolders.txt
```
```
cp /home/ruslan_khomyachenko/task5.1/rootfolders.txt ~
```
```
~# ls -la |grep rootfolders.txt
-rw-r--r--  1 root root  729 Dec  1 19:48 rootfolders.txt
```
```
root@Ruslan:~# rm -rf /home/ruslan_khomyachenko/task5.1/
root@Ruslan:~# cd /home/ruslan_khomyachenko/task5.1/
-bash: cd: /home/ruslan_khomyachenko/task5.1/: No such file or directory

```
6.
```
# cp .bash_history Documents/test/labwork2
```

```
# ln -s /home/ruslan_khomyachenko/Documents/test/labwork2 /root/labwork2
lrwxrwxrwx  1 root root   49 Dec  9 10:11 labwork2 -> /home/ruslan_khomyachenko/Documents/test/labwork2

symbolic links refer to a symbolic path indicating the abstract location of another file.
```
```
ln /home/ruslan_khomyachenko/Documents/test/labwork2 /home/ruslan_khomyachenko/Documents/labwork2
-rw------- 2 root                root                    62154 Dec  1 20:04 labwork2

hard links : Refer to the specific location of physical data.
```
```
While chnanging the data of the softlink file labwork2, the changes effect the original file as well.

If we remove the oridinal file, the softlink will brake unlike the hardlink

```
7.
```
~# locate traceroute
/etc/alternatives/tcptraceroute
/etc/alternatives/tcptraceroute.8.gz
/etc/alternatives/traceroute
/etc/alternatives/traceroute.1.gz
/etc/alternatives/traceroute.sbin
/etc/alternatives/traceroute6
/etc/alternatives/traceroute6.8.gz
/lib/modules/5.4.0-90-generic/kernel/drivers/tty/n_tracerouter.ko
/lib/modules/5.4.0-91-generic/kernel/drivers/tty/n_tracerouter.ko
/usr/bin/traceroute

~# locate squid
/usr/share/vim/vim80/syntax/squid.vim
```
8.

```
~# lsblk

~# fdisk -l

~# df -aTh
```
9.
```
$ cat .xsession-errors | grep -c "child"
397

```
10.
```
# find /etc -type f -name "vm3244*"
/etc/pki/tls/certs/vm3244.tmdcloud.com.crt
/etc/ssl/private/vm3244.tmdcloud.com.key

```
11.
```
find /etc -name "*ss*"
ls -la | grep -r "ss"
```
12.
```
ls -alh | less
```

13.

```
There are two types of device files based upon how data written to them and read from them is processed by the operating system and hardware: 1. Character special files or Character devices 2.Block special files or Block devices.

Understanding Character special files or Character devices

Talks to devices in a character by character (1 byte at a time)
Examples: Virtual terminals, terminals and serial modems etc

Understanding Block special files or Block devices

Talks to devices 1 block at a time ( 1 block = 512 bytes to 32KB)
Examples: Hard disk, DVD/CD ROM, and memory regions etc

ls -la /dev

The ones that have a "b" are block type devices and the ones that begin with "c" are character devices.
```
14. 

```
in the ls command you can see the type of file with the first bit on each line. Device files are denoted as the following:
just - regiral file
d -directory
c - character
b - block
p - pipe
s - socket
l - link file

ls -la | grep ^l and etc..

# file /dev/sda1
/dev/sda1: block special 
```
15. 

```
ls -1t | head -5
```
