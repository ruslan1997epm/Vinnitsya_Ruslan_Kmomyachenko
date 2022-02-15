Task 7.1
Part A 
Here is the body of the script:

```
00#!/bin/bash

#This function displays the IP addresses and symbolic names of all hosts in the current subnet.

function netscan

{

ipaddr=$1
echo "The following hosts have been found in the network"

nmap -sP $ipaddr

}


function portscan

{

echo "The list of TCP sockets:"

ss -t -a


}


if [ "$1" == "--all" ]
then
        portscan

elif [ "$1" == "--target" ]
then
        netscan $2

fi 

if [ "$#" == "0" ]
then 
        echo "In order to display the list of open TCP ports use the argument --all"
        echo "In order to display the IP addresses and symbolic names of all hosts in the subnet use exmple ./script-a --target 192.168.0.88/24"

fi

```
The results of execution:

```
$ ./script-a 
In order to display the list of open TCP ports use the argument --all
In order to display the IP addresses and symbolic names of all hosts in the subnet use exmple ./script-a --target 192.168.0.88/24

```
```
 ./script-a --all
The list of TCP sockets:
State                     Recv-Q                     Send-Q                                          Local Address:Port                                              Peer Address:Port                      
LISTEN                    0                          128                                             127.0.0.53%lo:domain                                                 0.0.0.0:*                         
LISTEN                    0                          5                                                   127.0.0.1:ipp                                                    0.0.0.0:*                         
ESTAB                     0                          0                                                192.168.0.88:36436                                              3.67.35.217:https                     
ESTAB                     0                          0                                                192.168.0.88:37206                                             3.68.170.153:https                     
ESTAB                     0                          0                                                192.168.0.88:49269                                             13.89.178.27:https                     
ESTAB                     0                          0                                                192.168.0.88:36162                                          185.199.110.133:https                     
ESTAB                     0                          0                                                192.168.0.88:33368                                             140.82.121.6:https                     
ESTAB                     0                          0                                                192.168.0.88:40984                                            140.82.113.25:https                     
ESTAB                     0                          0                                                192.168.0.88:41036                                            3.126.186.102:https                     
ESTAB                     0                          0                                                192.168.0.88:33366                                             140.82.121.6:https                     
ESTAB                     0                          0                                                192.168.0.88:40325                                            52.112.120.13:https                     
ESTAB                     0                          0                                                192.168.0.88:41384                                           52.182.143.210:https                     
ESTAB                     0                          0                                                192.168.0.88:41038                                            3.126.186.102:https                     
ESTAB                     0                          0                                                192.168.0.88:51340                                          185.199.111.154:https                     
ESTAB                     0                          0                                                192.168.0.88:33588                                               75.2.53.94:https                     
ESTAB                     0                          0                                                192.168.0.88:45654                                             52.112.231.8:https                     
ESTAB                     0                          0                                                192.168.0.88:50692                                          142.250.102.188:5228                      
ESTAB                     0                          0                                                192.168.0.88:40280                                             52.33.84.190:https                     
ESTAB                     0                          0                                                192.168.0.88:41024                                            3.126.186.102:https                     
LISTEN                    0                          5                                                       [::1]:ipp                                                       [::]:*              
```
```
$ ./script-a --target 192.168.0.88/24
The following hosts have been found in the network

Starting Nmap 7.60 ( https://nmap.org ) at 2022-01-10 12:54 EET
Nmap scan report for Dlink-Router.Dlink (192.168.0.1)
Host is up (0.0031s latency).
Nmap scan report for Ruslan.Dlink (192.168.0.88)
Host is up (0.00014s latency).
Nmap done: 256 IP addresses (2 hosts up) scanned in 2.78 seconds

```

PART B

The body of the script:

```
#!/bin/bash

#From which ip were the most requests?

function mipr

{

echo "From these IP addresses where the most requestes"

awk '{ print $1}' apache_logs.txt  | sort | uniq -c | sort -nr | head -n 10

}

#What is the most requested page

function mrp

{

echo "The most requested pages are:"

awk {'print $7'} apache_logs.txt | sort | uniq -c | sort -nr | head -n 10

}


#How many requests were there from each ip? 

function rfeip

{

echo "The number of requsts from each IP:"

awk '{ print $1}' apache_logs.txt  | sort | uniq -c | sort -nr | head -n 10

}

#What non-existent pages were clients referred to? 

function nexp

{

echo "The non-existent page is:"

cat apache_logs.txt | grep "error404" | awk '{print "The non-existent page is: \"" $7 "\"  "}' | uniq -c

}

#What time did site get the most requests? 

function timesr

{

echo "The site got the most requests at:"

cat apache_logs.txt | awk '{print "Requests made on "$4" "$5" " }' | sort | uniq -c | sort -gr | head -10

}

#What search bots have accessed the site? (UA + IP)

function botsite

{

echo "The following seach bots accessed the site:"

cat apache_logs.txt | grep "bot" | awk '{print "The IP address is: "$1" and bot is:  "$NF""}' | sort | uniq -c
}

echo -e "Please select the neded option"

echo "1. From which ip were the most requests? "
echo "2. What is the most requested page"
echo "3. How many requests were there from each ip?"
echo "4. What non-existent pages were clients referred to?"
echo "5. What time did site get the most requests?"
echo "6. What search bots have accessed the site? (UA + IP)"

read answer

case $answer in 
	1) mipr;;
	2) mrp;;
	3) rfeip;;
       	4) nexp;;
	5) timesr;;
	6) botsite;;	
esac


```
The results:

```
$ ./script-b 
Please select the neded option
1. From which ip were the most requests? 
2. What is the most requested page
3. How many requests were there from each ip?
4. What non-existent pages were clients referred to?
5. What time did site get the most requests?
6. What search bots have accessed the site? (UA + IP)


```
```
$ ./script-b 
Please select the neded option
1. From which ip were the most requests? 
2. What is the most requested page
3. How many requests were there from each ip?
4. What non-existent pages were clients referred to?
5. What time did site get the most requests?
6. What search bots have accessed the site? (UA + IP)
1
From these IP addresses where the most requestes
     62 157.55.39.250
     61 46.29.2.62
     34 207.46.13.48
     10 178.76.227.154
      7 176.59.119.104
      4 157.55.39.174
      3 37.140.141.30
      2 66.249.78.58
      2 217.69.134.29
      2 157.55.39.182
```

```
$ ./script-b 
Please select the neded option
1. From which ip were the most requests? 
2. What is the most requested page
3. How many requests were there from each ip?
4. What non-existent pages were clients referred to?
5. What time did site get the most requests?
6. What search bots have accessed the site? (UA + IP)
2
The most requested pages are:
      8 /sitemap1.xml.gz
      5 /graffiti
      5 /flowers
      5 /dresses
      5 /cats
      5 /cars
      4 /weather.php?get
      4 /snowboard
      4 /skateboard
      4 /shoes

```
```
$ ./script-b 
Please select the neded option
1. From which ip were the most requests? 
2. What is the most requested page
3. How many requests were there from each ip?
4. What non-existent pages were clients referred to?
5. What time did site get the most requests?
6. What search bots have accessed the site? (UA + IP)
3
The number of requsts from each IP:
     62 157.55.39.250
     61 46.29.2.62
     34 207.46.13.48
     10 178.76.227.154
      7 176.59.119.104
      4 157.55.39.174
      3 37.140.141.30
      2 66.249.78.58
      2 217.69.134.29
      2 157.55.39.182


```
```
4
The non-existent page is:
      3 The non-existent page is: "/error404"  

```
```
5
The site got the most requests at:
      5 Requests made on [30/Sep/2015:02:26:55 +0300] 
      5 Requests made on [30/Sep/2015:02:26:53 +0300] 
      5 Requests made on [30/Sep/2015:02:26:52 +0300] 
      5 Requests made on [30/Sep/2015:02:26:51 +0300] 
      5 Requests made on [30/Sep/2015:02:26:24 +0300] 
      5 Requests made on [30/Sep/2015:02:26:23 +0300] 
      5 Requests made on [30/Sep/2015:02:25:54 +0300] 
      5 Requests made on [30/Sep/2015:02:25:53 +0300] 
      5 Requests made on [30/Sep/2015:02:25:52 +0300] 
      5 Requests made on [30/Sep/2015:02:25:50 +0300]

```
```
6
The following seach bots accessed the site:
      4 The IP address is: 157.55.39.174 and bot is:  +http://www.bing.com/bingbot.htm)"
      2 The IP address is: 157.55.39.182 and bot is:  +http://www.bing.com/bingbot.htm)"
      1 The IP address is: 157.55.39.250 and bot is:  +http://www.bing.com/bingbot.htm)"
     61 The IP address is: 157.55.39.250 and bot is:  +http://www.bing.com/bingbot.htm)"
      1 The IP address is: 185.53.44.186 and bot is:  +http://www.xovibot.net/)"
     33 The IP address is: 207.46.13.48 and bot is:  +http://www.bing.com/bingbot.htm)"
      1 The IP address is: 207.46.13.48 and bot is:  http://www.bing.com/bingbot.htm)"
      1 The IP address is: 217.69.134.11 and bot is:  +http://go.mail.ru/help/robots)"
      1 The IP address is: 217.69.134.12 and bot is:  +http://go.mail.ru/help/robots)"
      1 The IP address is: 217.69.134.13 and bot is:  +http://go.mail.ru/help/robots)"
      1 The IP address is: 217.69.134.15 and bot is:  +http://go.mail.ru/help/robots)"
      2 The IP address is: 217.69.134.29 and bot is:  +http://go.mail.ru/help/robots)"
      1 The IP address is: 217.69.134.39 and bot is:  +http://go.mail.ru/help/robots)"
      3 The IP address is: 37.140.141.30 and bot is:  +http://yandex.com/bots)"
      1 The IP address is: 5.255.253.45 and bot is:  +http://yandex.com/bots)"
      1 The IP address is: 5.255.253.74 and bot is:  +http://yandex.com/bots)"
      1 The IP address is: 66.249.69.39 and bot is:  +http://www.google.com/bot.html)"
      2 The IP address is: 66.249.78.58 and bot is:  +http://www.google.com/bot.html)"
      1 The IP address is: 66.249.78.65 and bot is:  +http://www.google.com/bot.html)"
      1 The IP address is: 93.158.178.129 and bot is:  +http://yandex.com/bots)"
      1 The IP address is: 95.108.158.190 and bot is:  +http://yandex.com/bots)"

```
