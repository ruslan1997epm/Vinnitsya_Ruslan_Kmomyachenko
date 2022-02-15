Part 1

1)
Linux has basically 5 states:

  1. Running/Runnable (R): running processes are processes using a CPU core right now, a runnable process is a process that has everything to run and is just waiting for a CPU core slot.
  2. Sleeping Interruptible (S) the interruptible sleeping state will react to signals and the availability of resources.
  3. Sleeping Uninterruptible (D) The uninterruptible sleeping state will only wait for the resources to be available before it transit into a runnable state, and it doesn’t react to any signals.
  4. Stopped (T): a process becomes stopped when it receives the SIGSTOP signal.
  5. Zombie State (Z) When a process has completed its execution or is terminated, it’ll send the SIGCHLD signal to the parent process and go into the zombie state. The zombie process, also known as a defunct process, will remain in this state until the parent process clears it off from the process table. To clear the terminated child process off the process table, the parent process must read the exit value of the child process using the wait() or waitpid() system calls.

In Linux, the top command-line tool displays the process details in a real-time fashion. It shows different aspects of the system, such as memory and CPU usage of individual processes. To see the process state, let’s run top in the terminal:
```
Tasks: 198 total,   1 running, 196 sleeping,   0 stopped,   1 zombie
%Cpu(s):  0.8 us,  0.3 sy,  0.0 ni, 98.7 id,  0.1 wa,  0.0 hi,  0.0 si,  0.1 st
KiB Mem : 12137156 total,  1144320 free,  4204356 used,  6788480 buff/cache
KiB Swap:  2047996 total,  1508784 free,   539212 used.  7004360 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                 
19718 manual    20   0  614644  45968  29816 S   4.7  0.4   0:00.14 php-fpm                                                                                                                                 
 4073 mysql     20   0 3494752   1.5g   9072 S   1.0 13.1 201:26.40 mysqld                                                                                                                                  
 6043 cpanels+  20   0 5224908 708472   6228 S   1.0  5.8  53:47.97 java                                                                                                                                    
    9 root      20   0       0      0      0 S   0.3  0.0 368:00.23 rcu_sched                                                                                                                               
31781 icinga    20   0 2506004  11684   6360 S   0.3  0.1  25:19.21 icinga2                                                                                                                                 
    1 root      20   0  339024   3276   1620 S   0.0  0.0 198:51.97 systemd                                                                                                                                 
    2 root      20   0       0      0      0 S   0.0  0.0   0:08.41 kthreadd                                                                                                                                
    6 root      20   0       0      0      0 S   0.0  0.0   3:53.50 ksoftirqd/0                                                                                                                             
    7 root      rt   0       0      0      0 S   0.0  0.0   1:14.59 migration/0                                                                                                                             
    8 root      20   0       0      0      0 S   0.0  0.0   0:00.00 rcu_bh                                                                                                                                  
   10 root       0 -20       0      0      0 S   0.0  0.0   0:00.00 lru-add-drain                                                                                                                           
   11 root      rt   0       0      0      0 S   0.0  0.0   0:48.95 watchdog/0                                                                                                                              
   12 root      rt   0       0      0      0 S   0.0  0.0   0:49.68 watchdog/1                                                                                                                              
   13 root      rt   0       0      0      0 S   0.0  0.0   1:13.56 migration/1                                                                                                                             
   14 root      20   0       0      0      0 S   0.0  0.0   4:35.82 ksoftirqd/1                                                                                                                             
   16 root       0 -20       0      0      0 S   0.0  0.0   0:00.00 kworker/1:0H                                                                                                                            
   17 root      rt   0       0      0      0 S   0.0  0.0   0:46.00 watchdog/2     
```
We can find the S column, which shows the state of each process.

The /proc pseudo filesystem contains all the information about the processes in our system.

cat /proc/7303/status |grep State
State:	S (sleeping)


2)
pstree is a Linux command that shows the running processes as a tree.
```
systemd─┬─2*[agetty]
        ├─atd
        ├─atop
        ├─auditd───{auditd}
        ├─chronyd
        ├─cloudlinux-file
        ├─cloudlinux-ssa-───{cloudlinux-ssa-}
        ├─cpanellogd - sl
        ├─cpdavd - accept
        ├─cpsrvd (SSL) - ───2*[webmaild - serv]
        ├─crond─┬─crond───backup─┬─4*[backup───borg───ssh───sss_ssh_knownho]
        │       │                └─3*[{backup}]
        │       ├─crond───curl
        │       ├─crond───bash───curl
        │       └─2*[crond───bash───jetcli───cli───systemd-udevd]

```
systemd is the parent/root process of all the system process as it starts first when the system is booted.

The basic structure of the pstree can be seen in the following iamage.
```
parent————child(1)————subchild (1)
        |          |--subchild (2)
        |
        |-child(2)
```
```
pstree -np
```
3)
The proc file system contains a hierarchy of special files that represent the current state of the kernel.

Files in the /proc directory contain information about your hardware and current processes running on your system.

4)
~$ cat /proc/cpuinfo
~$ lscpu

5)
```
$ ps auxfS
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         2  0.0  0.0      0     0 ?        S    Dec20   0:00 [kthreadd]
root         3  0.0  0.0      0     0 ?        I<   Dec20   0:00  \_ [rcu_gp]
root         4  0.0  0.0      0     0 ?        I<   Dec20   0:00  \_ [rcu_par_gp]
root         6  0.0  0.0      0     0 ?        I<   Dec20   0:00  \_ [kworker/0:0H-kb]
root         9  0.0  0.0      0     0 ?        I<   Dec20   0:00  \_ [mm_percpu_wq]
ruslan_+  2403  0.0  0.0 206536  3436 tty2     Ssl+ Dec20   0:00      \_ /usr/lib/gdm3/gdm-x-session --run-script env GNOME_SHELL_SESSION_MODE=ubuntu gnome-session --session=ubuntu
```
6)

Kernel processes are the ones borned by kthreadd which is is the kernel thread daemon? its PID is 2
```
# pstree 2
kthreadd─┬─ata_sff
         ├─4*[bioset]
         ├─crypto
         ├─deferwq
         ├─edac-poller
         ├─ext4-rsv-conver
         ├─ipv6_addrconf
         ├─jbd2/loop0-8
         ├─kaluad
         ├─kauditd
         ├─kblockd
         ├─kdevtmpfs
         ├─khugepaged
         ├─khungtaskd
         ├─kintegrityd
         ├─kmpath_rdacd
         ├─kpsmoused
         ├─ksmd
```
The user processes are the other ones .

7)
```
root     24917  0.0  0.0 183712   816 ?        SN   Nov11   0:00 Malware Detection Worker
root     24918  0.0  0.0 183712   816 ?        SN   Nov11   0:00 Malware Detection Worker
root     25156  0.0  0.0 200744  1932 ?        S    Dec06   0:00 /usr/sbin/CROND -n
root     25158  0.0  0.0 113280  1300 ?        Ss   Dec06   0:00 /bin/sh -c sleep $((1 + RANDOM % 5))h $((1 + RANDOM % 60))m; /usr/local/bin/wp-toolkit update-configuration > /dev/null 2> /dev/null || /us
root     25230  0.0  0.0 249872  4188 ?        S    Nov10  47:31 /usr/bin/python /usr/bin/yum --assumeyes --color=never --config /etc/yum.conf update
root     25300  0.0  0.0 200744   868 ?        S    Nov11   0:00 /usr/sbin/CROND -n
root     25304  0.0  0.0 113280   652 ?        Ss   Nov11   0:00 /bin/sh -c sleep $((1 + RANDOM % 5))h $((1 + RANDOM % 60))m; /usr/local/bin/wp-toolkit update-configuration > /dev/null 2> /dev/null || /us
root     25582  0.0  0.0 113280     0 ?        S    Sep01   0:00 sh -c /bin/rpm '-q' '--queryformat' '%{NAME}:%{VERSION}:%{SUMMARY}\n' '--whatprovides' '/usr/lib/systemd/systemd-udevd'  2>&1
root     25583  0.0  0.0 177820     4 ?        S    Sep01   0:00 /bin/rpm -q --queryformat %{NAME}:%{VERSION}:%{SUMMARY}\n --whatprovides /usr/lib/systemd/systemd-udevd
root     25962  0.0  0.0 200744   864 ?        S    Nov02   0:00 /usr/sbin/CROND -n
root     25964  0.0  0.0 113280   700 ?        Ss   Nov02   0:00 /bin/sh -c sleep $((1 + RANDOM % 5))h $((1 + RANDOM % 60))m; /usr/local/bin/wp-toolkit update-configuration > /dev/null 2> /dev/null || /us
root     26299  0.0  0.2 148336 27948 ?        Ss   Aug11  61:39 cpsrvd (SSL) - waiting for connections                   
root     26487  0.0  0.0 113280   556 ?        S    Nov11   0:00 sh -c /bin/rpm '-qa' '--queryformat' '%{NAME}###%{VERSION}###%{SUMMARY}\n'  2>&1
root     26489  0.0  0.0 195780  1032 ?        S    Nov11   0:08 /bin/rpm -qa --queryformat %{NAME}###%{VERSION}###%{SUMMARY}\n
root     26597  0.0  0.0 200744  2668 ?        S    01:00   0:00 /usr/sbin/CROND -n
root     26602  0.0  0.0 113280  1392 ?        Ss   01:00   0:00 /bin/sh -c sleep $((1 + RANDOM % 5))h $((1 + RANDOM % 60))m; /usr/local/bin/wp-toolkit update-configuration > /dev/null 2> /dev/null || /us
root     26678  0.0  0.0 113280   556 ?        S    Nov09   0:00 sh -c /bin/rpm '-qa' '--queryformat' '%{NAME}###%{VERSION}###%{SUMMARY}\n'  2>&1
root     26679  0.0  0.0 194428  1028 ?        S    Nov09   0:04 /bin/rpm -qa --queryformat %{NAME}###%{VERSION}###%{SUMMARY}\n
root     26692  0.0  0.0 249872  4196 ?        S    Oct29  61:43 /usr/bin/python /usr/bin/yum --assumeyes --color=never --config /etc/yum.conf update
root     27138  0.0  0.0 200532     0 ?        S    Jul06   0:00 /usr/sbin/CROND -n
root     27139  0.1  0.0 480660   640 ?        Ssl  Jul06 410:06 /usr/bin/python3 /usr/bin/backup cron
```
SN ---> Interruptible sleep (waiting for an event to complete), has low-priority
S --->  Interruptible sleep
Ss ---> Interruptible sleep and is a session leader. A session leader is a process where session id == process id.
Ssl - sleeping, is a session loader and multi-threaded

8)

`ps -u ruslan_khomyachenko`

`top -U ruslan_khomyachenko`

9)
```
pgrep, pstree, top, proc, according to man ps
```
10)
```
The top program provides a dynamic real-time view of a running
system.  It can display system summary information as well as a
list of processes or threads currently being managed by the Linux kernel.
```
```
Tasks: 353 total,   1 running, 294 sleeping,   0 stopped,   0 zombie
%Cpu(s):  3.4 us,  1.4 sy,  0.0 ni, 94.4 id,  0.7 wa,  0.0 hi,  0.2 si,  0.0 st
KiB Mem :  8029488 total,  1914960 free,  4057168 used,  2057360 buff/cache
KiB Swap:   994004 total,   305564 free,   688440 used.  2969600 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                 
 2550 ruslan_+  20   0 4286068 327672  88428 S   3.6  4.1  39:32.16 gnome-shell                                                                                                                             
13219 ruslan_+  20   0 3170176 210592  80984 S   3.6  2.6  24:59.35 Isolated Web Co                                                                                                                         
 2576 ruslan_+   9 -11 4219888  13752  11288 S   2.0  0.2  32:54.39 pulseaudio                                                                                                                              
 2405 ruslan_+  20   0 1402160  49588  37672 S   1.7  0.6  38:58.18 Xorg                                                                                                                                    
10288 ruslan_+  20   0 16.779g 287876 129572 S   1.3  3.6  27:42.05 chrome                                                                                                                                  
12049 ruslan_+  20   0  650968  31560  17412 S   1.3  0.4   1:14.50 gnome-terminal-                                                                                                                         
12901 ruslan_+  20   0 4367532 462068 126676 S   1.3  5.8  38:07.85 GeckoMain                                                                                                                               
28765 ruslan_+  20   0   45852   4068   3216 R   1.0  0.1   0:00.10 top                                                                                                                                     
11804 ruslan_+  20   0 28.533g 228432  68860 S   0.7  2.8   7:13.63 slack                                
```
11)
`top -U ruslan_khomyachenko`

12)
```
Help for Interactive Commands - procps-ng 3.3.12
Window 1:Def: Cumulative mode Off.  System: Delay 3.0 secs; Secure mode Off.

  Z,B,E,e   Global: 'Z' colors; 'B' bold; 'E'/'e' summary/task memory scale
  l,t,m     Toggle Summary: 'l' load avg; 't' task/cpu stats; 'm' memory info
  0,1,2,3,I Toggle: '0' zeros; '1/2/3' cpus or numa node views; 'I' Irix mode
  f,F,X     Fields: 'f'/'F' add/remove/order/sort; 'X' increase fixed-width

  L,&,<,> . Locate: 'L'/'&' find/again; Move sort column: '<'/'>' left/right
  R,H,V,J . Toggle: 'R' Sort; 'H' Threads; 'V' Forest view; 'J' Num justify
  c,i,S,j . Toggle: 'c' Cmd name/line; 'i' Idle; 'S' Time; 'j' Str justify
  x,y     . Toggle highlights: 'x' sort field; 'y' running tasks
  z,b     . Toggle: 'z' color/mono; 'b' bold/reverse (only if 'x' or 'y')
  u,U,o,O . Filter by: 'u'/'U' effective/any user; 'o'/'O' other criteria
  n,#,^O  . Set: 'n'/'#' max tasks displayed; Show: Ctrl+'O' other filter(s)
  C,...   . Toggle scroll coordinates msg for: up,down,left,right,home,end

  k,r       Manipulate tasks: 'k' kill; 'r' renice
  d or s    Set update interval
  W,Y       Write configuration file 'W'; Inspect other output 'Y'
  q         Quit
          ( commands shown with '.' require a visible task display window ) 
Press 'h' or '?' for help with Windows,
Type 'q' or <Esc> to continue 
```
13)
In order to make sort we just need to run top command and press f
```
Fields Management for window 2:Job, whose current sort field is PID
   Navigate with Up/Dn, Right selects for move then <Enter> or Left commits,
   'd' or <Space> toggles display, 's' sets sort.  Use 'q' or <Esc> to end!

* PID     = Process Id          
* PPID    = Parent Process pid  
* TIME+   = CPU Time, hundredths
* %CPU    = CPU Usage           
* %MEM    = Memory Usage (RES)  
  USER    = Effective User Name 
* PR      = Priority            
* NI      = Nice Value          
* S       = Process Status      
* VIRT    = Virtual Image (KiB) 
* RES     = Resident Size (KiB) 
  SHR     = Shared Memory (KiB) 
  SWAP    = Swapped Size (KiB)  
* UID     = Effective User Id   
* COMMAND = Command Name/Line   
  RUID    = Real User Id        
  RUSER   = Real User Name      
  SUID    = Saved User Id       
  SUSER   = Saved User Name     
  GID     = Group Id            
  GROUP   = Group Name          
```
14)

You can change the process priority using nice and renice utility. Nice command will launch a process with an user defined scheduling priority. Renice command will modify the scheduling priority of a running process.

Linux Kernel schedules the process and allocates CPU time accordingly for each of them. But, when one of your process requires higher priority to get more CPU time, you can use nice and renice command

We can use top command

```
Tasks: 351 total,   1 running, 295 sleeping,   0 stopped,   0 zombie
%Cpu0  :  3.4 us,  0.3 sy,  0.0 ni, 96.3 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu1  :  2.6 us,  1.3 sy,  0.0 ni, 95.7 id,  0.0 wa,  0.0 hi,  0.3 si,  0.0 st
%Cpu2  :  2.7 us,  1.7 sy,  0.0 ni, 95.7 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu3  :  1.3 us,  1.0 sy,  0.0 ni, 95.3 id,  2.3 wa,  0.0 hi,  0.0 si,  0.0 st
KiB Mem :  8029488 total,  1620744 free,  4238620 used,  2170124 buff/cache
KiB Swap:   994004 total,   308636 free,   685368 used.  2849976 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                 
12901 ruslan_+  20   0 4448260 436308 137720 S   0.3  5.4  69:31.07 /usr/lib/firefox/firefox                                                                                                                
 2550 ruslan_+  20   0 4314708 358752  90060 S   0.3  4.5  47:03.65 /usr/bin/gnome-shell                                                                                                                    
13145 ruslan_+  20   0 2915264 325372  53200 S   1.3  4.1   4:08.97 /usr/lib/firefox/firefox -contentproc -childID 6 -isForBrowser -prefsLen 4885 -prefMapSize 251890 -jsInitLen 278884 -parentBuildID 202+ 
 2979 ruslan_+  20   0 13.693g 308524  61412 S   0.0  3.8  10:57.74 /usr/share/teams/teams --type=renderer --autoplay-policy=no-user-gesture-required --disable-background-timer-throttling --field-trial-+ 
10288 ruslan_+  20   0 16.766g 286584 130152 S   0.0  3.6  34:37.25 /opt/google/chrome/chrome --enable-crashpad                                                                                             
11804 ruslan_+  20   0 28.529g 246512  69164 S   3.6  3.1   8:04.57 /usr/lib/slack/slack --type=renderer --enable-crash-reporter=dba017ed-40a9-4322-994e-f4635e54d690,no_channel --global-crash-keys=dba01+ 
27186 ruslan_+  20   0 2743288 208932  93700 S   0.0  2.6   0:34.33 /usr/lib/firefox/firefox -contentproc -childID 57 -isForBrowser -prefsLen 10492 -prefMapSize 251890 -jsInitLen 278884 -parentBuildID 2+ 
```

Let's renice priority for the process 12901
```
~$ sudo renice -n +5 -p 12901
[sudo] password for ruslan_khomyachenko: 
12901 (process ID) old priority 0, new priority 5
```
```
PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                 
12901 ruslan_+  25   5 4458500 472836 137720 S   0.7  5.9  69:39.09 /usr/lib/firefox/firefox
```
 
15)
```
top - 22:35:50 up 23:09,  1 user,  load average: 1.30, 1.25, 1.15
Tasks: 368 total,   1 running, 310 sleeping,   0 stopped,   0 zombie
%Cpu0  : 14.1 us,  5.6 sy,  0.0 ni, 79.4 id,  0.0 wa,  0.0 hi,  1.0 si,  0.0 st
%Cpu1  : 16.4 us,  4.3 sy,  0.0 ni, 78.0 id,  0.0 wa,  0.0 hi,  1.3 si,  0.0 st
%Cpu2  : 14.3 us,  8.0 sy,  0.0 ni, 77.3 id,  0.0 wa,  0.0 hi,  0.3 si,  0.0 st
%Cpu3  : 16.2 us,  4.3 sy,  0.0 ni, 79.5 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
KiB Mem :  8029488 total,  1063508 free,  4691988 used,  2273992 buff/cache
KiB Swap:   994004 total,   308636 free,   685368 used.  2299088 avail Mem 
PID to renice [default pid = 12901] 
```

16)

~$ kill -l
 1) SIGHUP	 2) SIGINT	 3) SIGQUIT	 4) SIGILL	 5) SIGTRAP
 6) SIGABRT	 7) SIGBUS	 8) SIGFPE	 9) SIGKILL	10) SIGUSR1
11) SIGSEGV	12) SIGUSR2	13) SIGPIPE	14) SIGALRM	15) SIGTERM
16) SIGSTKFLT	17) SIGCHLD	18) SIGCONT	19) SIGSTOP	20) SIGTSTP
21) SIGTTIN	22) SIGTTOU	23) SIGURG	24) SIGXCPU	25) SIGXFSZ
26) SIGVTALRM	27) SIGPROF	28) SIGWINCH	29) SIGIO	30) SIGPWR
31) SIGSYS	34) SIGRTMIN	35) SIGRTMIN+1	36) SIGRTMIN+2	37) SIGRTMIN+3
38) SIGRTMIN+4	39) SIGRTMIN+5	40) SIGRTMIN+6	41) SIGRTMIN+7	42) SIGRTMIN+8
43) SIGRTMIN+9	44) SIGRTMIN+10	45) SIGRTMIN+11	46) SIGRTMIN+12	47) SIGRTMIN+13
48) SIGRTMIN+14	49) SIGRTMIN+15	50) SIGRTMAX-14	51) SIGRTMAX-13	52) SIGRTMAX-12
53) SIGRTMAX-11	54) SIGRTMAX-10	55) SIGRTMAX-9	56) SIGRTMAX-8	57) SIGRTMAX-7
58) SIGRTMAX-6	59) SIGRTMAX-5	60) SIGRTMAX-4	61) SIGRTMAX-3	62) SIGRTMAX-2
63) SIGRTMAX-1	64) SIGRTMAX	

SIGTERM (15): Termination signal
SIGKILL (9): The SIGKILL signal is used to kill or terminate processes immediately. SIGKILL signals can’t be handled, ignored, or stopped.
SIGSTOP (19): This signal is to stop or pause processes that can be later resumed.
SIGCONT (18): The SIGCONT signal is used to resume stopped or paused processes.

17)
```
~$ jobs -l
[1]   8337 Running                 sleep 103 &
[2]   8341 Running                 sleep 105 &
[3]-  8343 Running                 sleep 105 &
[4]+  8347 Running                 sleep 110 &

     
~$ fg 1
sleep 103


~$ kill -9 8337 8341 8343 8347
[1]+  Killed                  sleep 103
[2]   Killed                  sleep 105
[3]   Killed                  sleep 105
[4]-  Killed                  sleep 110
```
```
~$ nohup ./hello.sh 
nohup: ignoring input and appending output to 'nohup.out'

~$ cat nohup.out 
Helo World
Helo World
```
Part 2

1.

ssh user@host -p ---> connect to remote host over ssh
ssh-keygen ---> generate ssh authoriazation key


https://gyazo.com/4d44101360e543547bc586b79b984444

https://gyazo.com/eb405ea2ef63046b29ae7c9bcc0ee5c1

2. To secure openssh we can perform the following steps:

1. Strong Usernames and Passwords
2. Configure Idle Timeout Interval

To avoid having an unattended SSH session, you can set an Idle timeout interval. Open your /etc/ssh/sshd_config file and add the following line:

ClientAliveInterval 360

ClientAliveCountMax 0

3. Disable Empty Passwords

You need to prevent remote logins from accounts with empty passwords for added security. Open your /etc/ssh/sshd_config file and update the following line:

PermitEmptyPasswords no

4. Limit Users’ SSH Access

To provide another layer of security, you should limit your SSH logins to only certain users who need remote access. This way, you will minimize the impact of having a user with a weak password.

Open your /etc/ssh/sshd_config file to add an ‘AllowUsers’ line, followed by the list of usernames, and separate them with a space:

AllowUsers user1 user2

5. Disable Root Logins

PermitRootLogin no

6. Only Use SSH Protocol 2

7. Use Another Port

8. Use Public/Private Keys for Authentication

3.

The list of supported algorithms in OpenSSH 
```
$ ssh -Q key
ssh-ed25519
ssh-ed25519-cert-v01@openssh.com
ssh-rsa
ssh-dss
ecdsa-sha2-nistp256
ecdsa-sha2-nistp384
ecdsa-sha2-nistp521
ssh-rsa-cert-v01@openssh.com
ssh-dss-cert-v01@openssh.com
ecdsa-sha2-nistp256-cert-v01@openssh.com
ecdsa-sha2-nistp384-cert-v01@openssh.com
ecdsa-sha2-nistp521-cert-v01@openssh.com
```
```
ruslan_khomyachenko@Ruslan:/etc/ssh$ sudo ssh-keygen -t ecdsa-sha2-nistp384
[sudo] password for ruslan_khomyachenko: 
Generating public/private ecdsa-sha2-nistp384 key pair.
Enter file in which to save the key (/root/.ssh/id_ecdsa): id_ecdsa
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in id_ecdsa.
Your public key has been saved in id_ecdsa.pub.
The key fingerprint is:
SHA256:mR5Sy6jMIxBI6WoyzTC1lu9EQrHuSqGqZHPLVvRD4Ig root@Ruslan
The key's randomart image is:
+---[ECDSA 384]---+
| .o.             |
|o.o. .           |
|+oooo . .        |
|oE=..o = +       |
|oB.+. = S        |
|=++ooo = .       |
|+*o+*   o        |
|=.+oo.           |
|= .o             |
+----[SHA256]-----+

```
4.

We need to configure the port forwarding in the nat network.

https://gyazo.com/0c14e7556af3a09ff3a12caa7e6b5466

```
uslan_khomyachenko@Ruslan:~$ ssh ruslan@127.0.0.1 -p 2222
The authenticity of host '[127.0.0.1]:2222 ([127.0.0.1]:2222)' can't be established.
ECDSA key fingerprint is SHA256:B0bOgWNB3+O5h2UCKl9fP/9+bcI3WsdfiMBibUIK54k.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '[127.0.0.1]:2222' (ECDSA) to the list of known hosts.
ruslan@127.0.0.1's password: 
Welcome to Ubuntu 20.04.3 LTS (GNU/Linux 5.11.0-44-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

184 updates can be applied immediately.
104 of these updates are standard security updates.
To see these additional updates run: apt list --upgradable

Your Hardware Enablement Stack (HWE) is supported until April 2025.

The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

ruslan@ruslanvb:~$ 


```          
