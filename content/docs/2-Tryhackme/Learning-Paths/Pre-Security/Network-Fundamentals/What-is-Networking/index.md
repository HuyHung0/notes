---
title: "What Is Networking"
date: 2023-12-29T22:07:23+01:00
# weight: 1
# bookFlatSection: true
# bookToc: false
# bookHidden: true
# bookCollapseSection: true
# bookComments: true
# bookSearchExclude: true
---
# What is Networking?
## Internet
- The first iteration of the Internet was within the ARPANET project in the late 1960s. This project was funded by the United States Defence Department and was the first documented network in action. However it wasn't until 1989 when the Internet as we know it was invented by Tim Berners-Lee by the creation of the World Wide Web (WWW). It wasn't until this point that the Internet started to be used as a repository for storing and sharing information, just like it is today.
- Internet is made up of many small networks all joined together. These small networks are called private networks, where networks connecting these small networks are called public networks -- or the Internet.
- Devices will use a set of labels to identify themselves on a network.

## Identifying Devices on a Network
- Two means of identification:
  - An IP Address
  - A Media Access Control (MAC) Address

### IP Addresses
- An IP (Internet Protocol) address is a set of numbers that are divided into four octets. The value of each octet will summarize to be the IP address of the device on the network. This number is calculated through a technique known as IP addressing and subnetting.
- IP addresses can change from device to device but cannot be active simultaneously more than once within the same network.
- Devices can be on both a private and public network. Depending on where tey are will determine what type of IP address they have: a public or private IP address.
- A public address is used to identify the device on the Internet, whereas a private address is used to identify a device amongst other devices.
- Public IP addresses are given by your Internet Service Provider (or ISP) at a monthly fee.
- One version of IP addressing scheme is IPv4, which uses a numbering system of 2^32 IP addresses (4.29 billion)
- IPv6 is a new iteration of the IP addressing scheme
  - Supports up to 2^128 IP addresses (340 trillion-plus)
  - More efficient due to new methodologies

### MAC Addresses
- a MAC is a unique address assigned to a networking interface at the factory it was built at.
- The MAC address is a twelve-character hexadecimal number split into two's and separated by a colon.
  - First six characters represent the company that made the network interface
  - The last six is a unique number
  - Example: Intel: `a4:c3:f0`
- MAC addresses can be faked or "spoofed" in a process known as spoofing.


## Ping (ICMP)
- Ping is one of the most fundamental network tools available to us.
- Ping uses ICMP (Internet Control Message Protocol) packets to determine the performance of a connection between devices.
- The time taken for ICMP packets travelling between devices is measured by ping.
- Ping can be performed against devices on a network.

```bash
ping -c 4 8.8.8.8
```
`-c`: the number of packets

