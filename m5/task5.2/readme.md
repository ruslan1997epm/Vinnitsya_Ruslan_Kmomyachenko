1) 
```
https://gyazo.com/8ecc511f82eb5b61cc6b72cbecabbc48


The /etc/passwd contains the information about all users in the system

The /etc/passwd contains one entry per line for each user (user account) of the system. All fields are separated by a colon (:) symbol. Total of seven fields as follows. Generally, /etc/passwd file entry looks as follows:

ruslan_khomyachenko:x:1000:1000:Ruslan_Khomyachenko,,,:/home/ruslan_khomyachenko:/bin/bash

1. Username 
2. Password
3. User ID (UID)
4. Group ID (GID) The primary group ID (stored in /etc/group file)
5. User ID Info (GECOS)
6. Home directory
7.Command/shell

The /etc/group is a text file which defines the groups to which users belong under Linux and UNIX operating system.
It defines the groups to which users belong. There is one entry per line, and each line has the following format (all fields are separated by a colon (:)

sudo:x:27:ruslan_khomyachenko

1.group_name
2.Password
3.Group ID (GID)
4.Group List
```
2)
```
A UID (user identifier) is a number assigned by Linux to each user on the system. This number is used to identify the user to the system and to determine which system resources the user can access.

    UID 0 (zero) is reserved for the root.
    UIDs 1–99 are reserved for other predefined accounts.
    UID 100–999 are reserved by system for administrative and system accounts/groups.
    UID 1000–10000 are occupied by applications account.
    UID 10000+ are used for user accounts.
```
3) 
```
Groups in Linux are defined by GIDs (group IDs).

    GID 0 (zero) is reserved for the root group.
    GID 1–99 are reserved for the system and application use.
    GID 100+ allocated for the user’s group.
```
4)
```
groups ruslan_khomyachenko
ruslan_khomyachenko : ruslan_khomyachenko adm cdrom sudo dip plugdev lpadmin sambashare vboxusers
```
5)
```
~$ sudo adduser ruslan2
[sudo] password for ruslan_khomyachenko: 
Adding user `ruslan2' ...
Adding new group `ruslan2' (1001) ...
Adding new user `ruslan2' (1001) with group `ruslan2' ...
Creating home directory `/home/ruslan2' ...
Copying files from `/etc/skel' ...
Enter new UNIX password: 
Retype new UNIX password: 
No password supplied
Enter new UNIX password: 
Retype new UNIX password: 
passwd: password updated successfully
Changing the user information for ruslan2
Enter the new value, or press ENTER for the default
	Full Name []: 
	Room Number []: 
	Work Phone []: 
	Home Phone []: 
	Other []: 
Is the information correct? [Y/n] Y
```

6)
```
~$ sudo usermod -l ruslan23 ruslan2
~$ grep -w '^ruslan23' /etc/passwd
ruslan23:x:1001:1001:,,,:/home/ruslan2:/bin/bash
```
7)
The /etc/skel directory contains files and directories that are automatically copied over to a new user’s home directory when such a user is created by the useradd program. skel is derived from the “skeleton”.
```
~$ ls -la /etc/skel/
total 40
drwxr-xr-x   2 root root  4096 Feb  3  2020 .
drwxr-xr-x 131 root root 12288 Dec 19 20:09 ..
-rw-r--r--   1 root root   220 Apr  4  2018 .bash_logout
-rw-r--r--   1 root root  3771 Apr  4  2018 .bashrc
-rw-r--r--   1 root root  8980 Apr 16  2018 examples.desktop
-rw-r--r--   1 root root   807 Apr  4  2018 .profile
```
/etc/default/useradd file which defines the skel directory. You can change the default location /etc/skel to any other location.

8)

```
~$ sudo userdel -r ruslan23
userdel: ruslan23 mail spool (/var/mail/ruslan23) not foun
```

9)
```
sudo passwd -l username
sudo passwd -u username
```
10)
`sudo passwd -de username`

11)
```
~$ ls -lahi
total 108M
3145729 drwxr-xr-x 36 ruslan_khomyachenko ruslan_khomyachenko 4.0K Dec 17 16:02  .
      2 drwxr-xr-x  4 root                root                4.0K Dec 19 20:17  ..
1313009 drwxr-xr-x  2 ruslan_khomyachenko ruslan_khomyachenko 4.0K Jun  7  2019  .anydesk
3155120 -rw-r--r--  1 ruslan_khomyachenko ruslan_khomyachenko 264K Nov 28  2020  backup-11.28.2020_12-53-52_forasbcl.tar.gz
3152687 -rw-r--r--  1 ruslan_khomyachenko ruslan_khomyachenko  212 Feb 10  2021  backup-2.9.2021_20-07-22_greenbe3219.tar.gz
3156443 -rw-------  1 ruslan_khomyachenko ruslan_khomyachenko  60K Dec 15 07:59  .bash_history
3152693 -rw-r--r--  1 ruslan_khomyachenko ruslan_khomyachenko  220 Aug  6  2018  .bash_logout
3151702 -rw-r--r--  1 ruslan_khomyachenko ruslan_khomyachenko 3.7K Aug  6  2018  .bashrc
3150163 -rw-------  1 ruslan_khomyachenko ruslan_khomyachenko 1.5K Oct  2  2020 'bdddd '
```
```
total 108M --> The "total" is the disk usage of listed files
3145729 --> Inode number of the file
drwxr-xr-x --> d-directory, rwxr-xr-x - permissions
36--> numbers of soft links and hard links
ruslan_khomyachenko --> owner UID
ruslan_khomyachenko --> owned GID
4.0K --> The size of the file, expressed in bytes
Dec 17 16:02 --> For a file, the date and time the file was last changed; for a directory, when it was created
backup-11.28.2020_12-53-52_forasbcl.tar.gz --> The name of the file or directory.
```
12)
```
Each file and directory has three user based permission groups:

    owner – The Owner permissions apply only the owner of the file or directory, they will not impact the actions of other users.
    group – The Group permissions apply only to the group that has been assigned to the file or directory, they will not effect the actions of other users.
    all users – The All Users permissions apply to all other users on the system, this is the permission group that you want to watch the most.

Each file or directory has three basic permission types:

    read – The Read permission refers to a user’s capability to read the contents of the file.
    write – The Write permissions refer to a user’s capability to write or modify a file or directory.
    execute – The Execute permission affects a user’s capability to execute a file or view the contents of a directory.


    r = 4
    w = 2
    x = 1
```    

13)
```
The permission in the command line is displayed as: _rwxrwxrwx 1 owner:group

    User rights/Permissions
        The first character that I marked with an underscore is the special permission flag that can vary.
        The following set of three characters (rwx) is for the owner permissions.
        The second set of three characters (rwx) is for the Group permissions.
        The third set of three characters (rwx) is for the All Users permissions.
```
14)
```
~$ touch somefile
~$ ls -la somefile 
-rw-rw-r-- 1 ruslan_khomyachenko ruslan_khomyachenko 0 Dec 20 13:28 somefile
~$ chmod 755 somefile 
~$ ls -la somefile 
-rwxr-xr-x 1 ruslan_khomyachenko ruslan_khomyachenko 0 Dec 20 13:28 somefile
```
15)
```
The umask command masks permission levels by qualifying them with a certain value. To explain further how the umask value is applied, we will illustrate with an example. Let’s say that we want to set the default permissions for all new files or folders to 644 and 755. We would then use the following command.

[root@host ~]# umask 022

The number "2" permission (write permission) will be "filtered" from the system’s default permissions of 666 and 777 (hence the name “mask.”) From now on, the system will now assign the default permissions of 644 and 755 on new files and directories. Simply put, to calculate the permission bits for a new file or directory, we just subtract the umask value from the default value, like so.

    666 - 022 = 644
    777 - 022 = 755
```
16)
```
root@Ruslan:/home/ruslan_khomyachenko# mkdir Testsbit
root@Ruslan:/home/ruslan_khomyachenko# cd Testsbit/
root@Ruslan:/home/ruslan_khomyachenko/Testsbit# touch file1
root@Ruslan:/home/ruslan_khomyachenko/Testsbit# ls -ld 
drwxr-xr-x 2 root root 4096 Dec 20 13:55 .
root@Ruslan:/home/ruslan_khomyachenko/Testsbit# chmod +t /home/ruslan_khomyachenko/Testsbit/
root@Ruslan:/home/ruslan_khomyachenko/Testsbit# ls -ld 
drwxr-xr-t 2 root root 4096 Dec 20 13:55 .
ruslan_khomyachenko@Ruslan:~/Testsbit$ rm -f file1 
rm: cannot remove 'file1': Permission denied
ruslan_khomyachenko@Ruslan:~/Testsbit$ mv file1 file2
mv: cannot move 'file1' to 'file2': Permission denied
```
17)
```
The detailed meaning of these attributes according to the manual page is:

    a - append only: this attribute allows a file to be added to, but not to be removed. It prevents accidental or malicious changes to files that record data, such as log files.
    c - compressed: it causes the kernel to compress data written to the file automatically and uncompress it when it’s read back.
    d - no dump: it makes sure the file is not backed up in backups where the dump utility is used
    e - extent format: it indicates that the file is using extents for mapping the blocks on disk.
    i - immutable: it makes a file immutable, which goes a step beyond simply disabling write access to the file. The file can’t be deleted, links to it can’t be created, and the file can’t be renamed.
    j - data journaling: it ensures that on an Ext3 file system the file is first written to the journal and only after that to the data blocks on the hard disk.
    s - secure deletion: it makes sure that recovery of a file is not possible after it has been deleted.
    t - no tail-merging: Tail-merging is a process in which small data pieces at a file’s end that don’t fill a complete block are merged with similar pieces of data from other files.
    u - undeletable: When a file is deleted, its contents are saved which allows a utility to be developed that works with that information to salvage deleted files.
    A - no atime updates: Linux won’t update the access time stamp when you access a file.
    D - synchronous directory updates: it makes sure that changes to files are written to disk immediately, and not to cache first.
    S - synchronous updates: the changes on a file are written synchronously on the disk.
    T - and top of directory hierarchy: A directory will be deemed to be the top of directory hierarchies for the purposes of the Orlov block allocator.


$ lsattr
--------------e--- ./Desktop
--------------e--- ./Documents
--------------e--- ./Templates
--------------e--- ./Public
--------------e--- ./issues
--------------e--- ./test
--------------e--- ./inodinfo
--------------e--- ./bdddd 
-----------I--e--- ./Downloads
--------------e--- ./Dwnldshare
--------------e--- ./slack-desktop-4.0.2-amd64.deb
--------------e--- ./pt
```




