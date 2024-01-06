---
title: Advent of cyber 2023
---

# Advent of cyber 2023

## Day16 - Machine learning: Can't CAPTCHA this machine!

### Convolutional Neural Networks

CNN have the ability to extract features that can be used to train a neural networks. In essence, CNNs are normal neural networks that simply have the feature-extraction process of the network itself.

Three main components:
- Feature extraction
- Fully connected layers
- Classification

Last two components was covered in previous tasks.

## Day17 - Traffic analysis: I Tawt | Taw A C2 Tat!

PCAPS formats are very useful for detailed analysis, but not practical for fast analysis with large data

NetFlow format provides only the summary of the traffic, does not contain the packet details and payload.

Key Data Files of PCAP format:
- Link layer information
- Timestamp
- Packet length
- MAC addresses
  - Source and destination MACs
- IP and port information
  - Source and destination IP addresses
  - Source and destination ports
- TCP/UDP information
- Application layer protocol **details**
- Packet data and payload

Key Data Fields of Network Flow format:

- IP and port information
  - Source and destination IP addresses
  - Source and destination ports
- IP protocol
- Volume details in byte and packet metrics
- TCP flags
- Time details
  - Start time
  - Duration
  - End time
- Sensor info
- Application layer protocol **information**

How to collect: can use wireshark. See module
<https://tryhackme.com/module/wireshark>


Convert PCAPs to network flows: SiLK (System for Internet Level Knowledge) - open-source tool, was developed by the CERT Situational Awareness group at Carnegie Mellon University's Software Engineering Institute.

SiLK suite has two parts: the packing system and the analysis suite. The packing system supports the collection of multiple network flow types (IPFIX, NetFlow v9, NetFlow v5) and stores them in binary files. The analysis suite contains the tools needed to carry out various operations (list, sort, count and statistics) on network flow records.


See the config and version
```bash
silk_config -v
```

![image](images/_index/screenshot_18-12-2023_00h15m31.png)

Silk mainly works on a data repository. Default data repository is in `/var/silk/data` directory.


### See the info rwfileinfo
```bash
rwfileinfo FILENAME
```

![image](images/_index/screenshot_18-12-2023_00h17m51.png)

### Reading rwcut
```bash
rwcut suspicious-flows.silk --num-recs=6
```

![image](images/index/screenshot_18-12-2023_00h23m44.png)

```bash
rwcut suspicious-flows.silk --fields=pro,sIP,sPort,dIP,dPort --num-recs=6
```

![image](images/index/screenshot_18-12-2023_00h24m47.png)


Some parameters
- Source IP: sIP
- Destination IP: dIP
- Source port: sPort
- Destination port: dPort
- Duration: duration
- Start time: sTime
- End time: eTime

Protocol number assigned by IANA (The internet Assigned Numbers Authority)
- ICMP = 1
- IPv4 = 4
- TCP = 6
- UDP = 17


### Filter rwfilter

rwfilter need to store in binary or pass to stdout then use rwcut

![image](images/index/screenshot_18-12-2023_00h33m11.png)

```bash
rwfilter suspicious-flows.silk --pro=17 --pass-stdout| rwcut --num-recs=6
```
![image](images/index/screenshot_18-12-2023_00h32m18.png)


### Statistic rwstats



## Day18 - Eradication: A gift that keep on giving

### top
```bash
top
```

use `q` to quit. Usually, we take memory dump of process to analyse it further before killing it, as killing it would cause us to lose that information. We assume that we have already done that and now we kill process

```bash
sudo kill <PID>
```

If we see the process again with different PID, it means that we successfully killed the process but it has been resurrected somehow.

Check the cronjobs, which are tasks that we ask the computer to perform on our behalf at a fixed interval. Often we can find traces of auto-starting processes.

run
```bash
crontab -l
```
There are not suspicious here.

```bash
sudo su
```
run with root then run `crontab -l` again. No new.

Check running services
```bash
systemctl list-unit-files | grep enabled
```

Check a specific service
```bash
systemctl status <service name>
```

Then we can see the info of the service and where it was loaded. No we stop it and remove it

```bash
sudo su
systemctl stop <service name>
systemctl status <service name>
systemctl disable <service name>
```
then go to folder and delete it
```bash
rm -rf /etc/systemd/<service name>
rm -rf /etc/systemd/system/service name
```

Check Linux Forensics room
<https://tryhackme.com/room/linuxforensics>


## test
{{< highlight go "linenos=table,hl_lines=8 15-17,linenostart=1" >}}

hugo v0.121.1-00b46fed8e47f7bb0a85d7cfc2d9f1356379b740+extended linux/amd64 BuildDate=2023-12-08T08:47:45Z VendorInfo=gohugoio
                   | EN  
-------------------+-----
  Pages            | 45  
  Paginator pages  |  0  
  Non-page files   | 14  
  Static files     | 78  
  Processed images |  0  
  Aliases          | 11  
  Sitemaps         |  1  
  Cleaned          |  0  

Built in 44 ms
Environment: "development"
Serving pages from memory
Running in Fast Render Mode. For full rebuilds on change: hugo server --disableFastRender
Web Server is available at http://localhost:1313/notes/ (bind address 127.0.0.1) 
Press Ctrl+C to stop
{{< / highlight >}}


## Day19 - Memory forensics: CrypTOYminers Sing Volala-lala-latility



## Day22 - Red- SSRF: Jingle Yours SSRF Bells: A Merry Command and Control Hackventure

### What is SSRF
- Server-side request forgery is a security vulnerability that occurs when an attacker tricks a web application into making unauthorized requests to internal or external resources on the server's behalf.

### Type of SSRF Attack
- Basic: the attacker sends a crafted request from the vulnerable server to internal or external resources. They may attempt to access files on the local file system, internal services, or databases that are not intended to be publicly accessible.
- Blind SSRF: the attacker does not directly see the response to the request. They may infer information about the internal network by measuring the time it takes for the server to respond or observing error message changes.
- Semi-blind SSRF: In semi-blind SSRF, the attacker does not receive direct responses in their browser or application. However, they rely on indirect clues, side-channel information, or observable effects within the application to determine the success or failure of their SSRF requests. This might involve monitoring changes in application behavior, response times, error messages, and other signs.

### Prerequisites for Exploitation
- Vulnerable input points: Web applications must have input fields susceptible to manipulation such as URLs or file upload functionalities.
- Lack of input validation: The application should have adequate input validation or effective sanitization mechanisms, allowing an attacker to craft malicious requests.

### How does SSRF Work?
- Identifying vulnerable input: the attacker locates an input field within the application that can be manipulated to trigger server-side requests. This could be a URL parameter in a web form, an API endpoint, or request parameter input such as the referrer.
- Manipulating the input: the attacker inputs a malicious URL or other payloads that cause the application to make unintended requests. This input could be a URL pointing to an internal server, a loopback address, or an external server under the attacker's control
- Requesting unauthorized resources: the application server, unaware of the malicious input, makes a request to the specified URL or resource. This request could target internal resources, sensitive services, or external systems.
- Exploiting the response: Depending on the application's behavior and the attacker's payload, the response from the malicious request may provide valuable information, such as internal server data, credentials, system credentials/information, or pathways for further exploitation.

### Practice: using SSRF to hack the command and control server

- Add hostname: modify: `/etc/hosts`, add the following line `10.10.142.98 mcgreedysecretc2.thm`


`http://MACHINE_IP/getClientData.php?url=http://IP_OF_CLIENT/NAME_OF_FILE_YOU_WANT_TO_ACCESS`

`http://MACHINE_IP/getClientData.php?url=file:////var/www/html/index.php`

`/etc/passwd`

`config.php`

`connection.php`

### Room SSRF
<https://tryhackme.com/room/ssrfqi>


## Day 23 - red - Coerced authentication: Relay all the way
### Rooms
Breaching Active Directory
<https://tryhackme.com/room/breachingad>

Compromising Active Directory
<https://tryhackme.com/module/hacking-active-directory>

### Tools
<https://github.com/Greenwolf/ntlm_theft.git>
