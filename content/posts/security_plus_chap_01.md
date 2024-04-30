---
title: "Re-taking the CompTIA Security+ Exam"
date: 2024-04-28T10:50:29-04:00
draft: true
tags: ["CompTIA", "Security+", "Certification"]
---

# Overview

---

This is going to be a long one.

- I forgot to renew my CompTIA Security+ certification, so I'm re-taking it.
- What a treat.
- I'm using [CompTIA Security+ Get Certified Get Ahead: SY0-501 Study Guide](https://www.amazon.com/CompTIA-Security-Get-Certified-Ahead/dp/1939136059) by **Darril Gibson** because the kindle edition was cheap and recommended.

Let's see how it goes!

> _Note that I'm just jotting stuff down for my own benefit, I'm not promising any kind of coherence heh._

# Table of Contents

---

- [Overview](#overview)
- [Table of Contents](#table-of-contents)
- [Chapter 01: Understanding Core Security Goals](#chapter-01-understanding-core-security-goals)
  - [Confidentiality](#confidentiality)
    - [Encryption](#encryption)
    - [Access Controls](#access-controls)
    - [Stenography and Obfuscation](#stenography-and-obfuscation)
    - [Confidentiality: Summary](#confidentiality-summary)
  - [Integrity](#integrity)
    - [Hashing](#hashing)
    - [Digital Signatures, Certificates and Non-Repudiation](#digital-signatures-certificates-and-non-repudiation)
  - [Availability](#availability)
    - [Redundancy and Fault Tolerance](#redundancy-and-fault-tolerance)
    - [Patching](#patching)
    - [Cost](#cost)
  - [Risk Concepts](#risk-concepts)
  - [Control Types](#control-types)
    - [Technical Controls](#technical-controls)
    - [Administrative Controls](#administrative-controls)
    - [Physical Controls](#physical-controls)
    - [Preventative Controls](#preventative-controls)
    - [Detective Controls](#detective-controls)
    - [Corrective Controls](#corrective-controls)
    - [Deterrent Controls](#deterrent-controls)
    - [Compensating Controls](#compensating-controls)
  - [Virtualization](#virtualization)
    - [Hypervisors](#hypervisors)
      - [Type I](#type-i)
      - [Type II](#type-ii)
    - [Container Virtualization](#container-virtualization)
    - [Snapshots](#snapshots)
    - [Virtual Desktops](#virtual-desktops)
    - [VMs as Files](#vms-as-files)
    - [Risks](#risks)
      - [VM Escape](#vm-escape)
      - [VM Sprawl](#vm-sprawl)
      - [Loss of Confidentiality](#loss-of-confidentiality)
  - [CLI Tools](#cli-tools)
    - [Windows vs Linux](#windows-vs-linux)
    - [ping](#ping)
    - [ipconfig](#ipconfig)
    - [ifconfig](#ifconfig)
    - [ip](#ip)
    - [netstat](#netstat)
    - [tracert](#tracert)
    - [arp](#arp)
  - [Chapter 01 Wrap](#chapter-01-wrap)

# Chapter 01: Understanding Core Security Goals

---

The CIA triad

- _Confidentiality_ - Prevents the unauthorized disclosure of data.
- _Integrity_ - Provides assurances that the data has not changed.
- _Availability_ - Indicates that data/services are... you guessed it: available, when needed.

I'm going to break these down a bit by section.

## Confidentiality

---

Confidentiality prevents the unauthorized disclosure of data.

### Encryption

Encryption is just fucking up you data in a way that only you can un-fuck it.

- It's used for covering up _Personally Identifiable Information_ (PII)

### Access Controls

So, like, uh - this is all about control and power and shit.

- _Identification_ - User names, claiming a user name, etc.
- _Authentication_ - How users prove their identify. Passwords, fingerprints, etc.
- _Authorization_ - Permissions for a given user. The DB devs has access to the DBs, or whatever.

### Stenography and Obfuscation

Stenography is _hiding data within data_.

- It's a form of obfuscation.
- An example would be using the bits in an image to hide some sort of message.
- You can also embed a text file in an image using simple tools like WinRAR.

### Confidentiality: Summary

Confidentiality is achieved by a combination of the following:

- _Encryption_ for scrambling data with a cypher of some sort (AES, for example).
- _Access Controls_ are used to provide control over who sees what.
- _Stenography and Obfuscation_ are broadly used to hide data within other data - like text in a picture.

## Integrity

---

Integrity provides assurances that data has not changed.

> When data has changed because of unauthorized access, it is said to have lost integrity.

### Hashing

Hashing is the main technique used to enforce integrity.

It works by generating a unique number for whatever the contents of a given blob are.

> A good real-world example is when you download a Go binary.
> The Go authors provide a hash so that you can verify that the binary is the same as the one hosted on their website.

Some common algorithms include:

- MD5 _Message Digest 5_
- SHA _Secure Hash Algorithm_
- HMAC _Hash-based Message Authentication Code_

### Digital Signatures, Certificates and Non-Repudiation

Similar in concept to a handwritten signature.

Digital Signatures use a PKI (Public Key Infrastructure) in concerts with certificates to achieve non-repudiation.

Common usages:

- Sign an email
- Audit logs

## Availability

---

Availability is pretty straightforward. It indicates that data and/or services are... available.

This ties in closely to SLAs (Service Level Agreements).

### Redundancy and Fault Tolerance

To achieve high availability, your system has to have good redundancy and fault tolerance.

- _Redundancy_ - duplication of data and/or compute.
- _Fault Tolerance_ - the system can heal when an error occurs.

I think about this as trying to remove _single points of failure_ (SPOF) by providing duplicates.

Couple of examples:

- _Server Redundancy_ - failover clusters or virtualization
- _Site Redundancy_ - hot site, warm site or cold site for disaster recovery
- _Disk Redundancy_ - RAID-1 (mirroring) RAID-5 (parity striping) RAID-10 (mirror striping)
- _Alternate Power_ - a generator or an uninterruptible power supply (UPS)
- _Cooling Systems_ - HVAC systems
- _Load Balancing_ - horizontal scaling of a web service
- _Backups_ - data duplication

### Patching

Availability can also be affected by how up-to-date your software is. So keep it up-to-date!

### Cost

Note that all this shit is expensive. Also, encrypting and duplicating data takes up a huge amount of disk space and compute. So try to get away with the least amount of it as possible.

## Risk Concepts

---

A lot of what IT organizations try to do is reduce risk (aka provide security).

Let us provide some definitions:

- _Risk_ - possibility or likelihood of a threat exploiting a vulnerability
- _Threat_ - anything likely to compromise confidentiality, integrity or availability
- _Vulnerability_ - a weak point, a chink in the armour, a poorly configured wifi router
- _Risk Mitigation_ - reducing risk, lessening the surface area for attacks
- _Security Incident_ - an event that compromises an IT system and/or data.

## Control Types

---

CompTIA tests for the following "controls":

By "Type"

- Technical
- Administrative
- Physical

By "Goal"

- Preventive
- Detective
- Corrective
- Deterrent
- Compensating

### Technical Controls

Controls that are, _you guessed it_, implemented with technology.

Here are some examples:

- Encryption
- Antivirus Software
- Intrusion Detection Systems (IDS)
- Intrusion Prevention Systems (IPS)
- Firewalls
- Least Privilege

### Administrative Controls

This is a mix of assessments, people training, and human controlled system configuration.

- Risk Assessments
- Vulnerability Assessments
- Penetration Tests
- Awareness Meetings
- Training
- System Configuration
- Change Management
- Contingency Planning
- Media Protection
- Physical/Environmental Protection

### Physical Controls

Shit you can touch.

- Locks
- Doors
- Fences
- Security Guards
- Hot/Cold Aisles
- Fire Lanes

### Preventative Controls

Like getting a regular checkup instead of waiting for something bad to happen before going to the doctor.

- Hardening
- Security Awareness & Training
- Security Guards
- Change Management
- Account Disablement Policy

### Detective Controls

Scopin' out the scene or whatever.

- Log Monitoring
- Trend Analysis
- Security Audits
- Video Surveillance
- Motion Detection

### Corrective Controls

For _reversing_ the impact of an incident after it has occurred.

- Intrusion Prevention Systems (IPS)
- Backups
- System Recovery

### Deterrent Controls

"Please don't walk on the grass".

- Cable Locks
- Hardware Locks

### Compensating Controls

I think of this a "auxiliary controls" or "supplementary controls".

The example given is:

1. You need a smart card to access the system.
1. It takes a while to get one.
1. In the mean time, you get a Time-based One-Time Password (TOTP) to access the system with.

The TOTP is the _compensation_ used to overcome the lack of a smart card.

## Virtualization

---

Using one beefy machine to host multiple virtual machines is a nice way to reduce costs and ease physical maintenance.

Some terms for 'ya:

- _Hypervisor_ - software that creates, runs and manages virtual machines (VMs)
- _Host_ - physical system on which the hypervisor runs
- _Guest_ - an OS running on a host is a guest

### Hypervisors

Two primary types, Type I and Type II.

#### Type I

These run directly on system hardware, with no need for an OS to act as an intermediary layer.

> These are often referred to as _bare-metal hypervisors_

Examples:

- [KVM](http://www.linux-kvm.org/page/Main_Page) _Kernel-Based Virtual Machine_
- [RHEV](http://www.redhat.com/products/virtualization/) _Red Hat Enterprise Virtualization_
- [VMware ESXi](http://www.vmware.com/products/datacenter-virtualization/vsphere/compare-editions.html)

#### Type II

These run on an OS. Not as efficient as Type I, but easier to configure/use.

Examples:

- Oracle VirtualBox
- VMware Fusion
- Windows Virtual PC
- Parallels Desktop

### Container Virtualization

This is similar to Virtualization, but on a smaller scale. Generally used to isolate apps and their dependencies. Docker, or BSD jails. That sorta thing.

### Snapshots

One nice thing about VMs is that it's very easy to take a snapshot of a system at a given time, which you can then backup to if shit gets weird.

### Virtual Desktops

Another nicety of virtualization is the ability to provision desktops environments... _virtually_.

This is referred to as either:

- Virtual Desktop Infrastructure (VDI)
- Virtual Desktop Environment (VDE)

These can either be _persistent_ or _non-persistent_ depending on the needs of the system.

### VMs as Files

VMs are just files - it's easy to move them around, or copy and paste to new locations. This portability is a very nice feature when trying to migrate systems or recover from incidents or human error.

### Risks

Virtualization is convenient and cost-effective, but there is a basic security flaw in hosting many virtual machines on the same underlying hardware.

#### VM Escape

This is when a user gains access to the underlying host from within a guest OS.

#### VM Sprawl

I've seen this firsthand. Because VMs are so trivial to create, it's very easy to accumulate way too many of this things. This is huge security issue because the attack surface is huge. It's also costly, both in resource usage and admin cost.

#### Loss of Confidentiality

Because VMs are just files, it's easy for a disgruntled admin to extract sensitive PII from the files.

## CLI Tools

One of my favorite topics: the glorious command line.

> This test doesn't really _test_ your knowledge of these things so much as makes you memorize a bunch of command names and flags, but whatever.

There are some general differences between Unix style commands and Windows commands, let's take a look.

### Windows vs Linux

Windows uses both the `/` character and the `-` character to indicate a flag.

Linux systems only use `-` characters to indicate flags.

> `ping /?` is equivalent to `ping -?` on Windows; only `ping -?` will work on Linux

_Most_ Windows commands are not case sensitive, whereas Linux commands are.

> `pInG -6 lOcAlHoSt` works on Windows; only `ping -6 localhost` will work on Linux

### ping

The `ping` CLI tool is used to check connectivity to remote systems.

You can also:

- See if a system can resolve valid host names to IP addresses
- Test the Network Interface Card (NIC)
- Probe the security posture of a network

How does this work?

1. The `ping` command sends Internet Control Message Protocol (ICMP) **_echo request_** packets to a remote system
1. The remote system responds with ICMP **_echo reply_** packets if it's operational.

Examples:

`ping 192.168.1.1`

- _Windows_ - four packets are sent
- _Linux_ - ping continues till `Ctrl-C` is pressed

`ping -t 192.168.1.1`

- _Windows_ - ping continues till `Ctrl-C` is pressed

`ping -c 4 192.168.1.1`

- _Linux_ - four packets are sent (notice the `-c 4` flag)

Check Name Resolution:

Name resolution is the process of getting the IP address of a host name e.g. `www.google.com`. Domain Name Servers (DNS) owned by Internet Service Providers (ISPs) are what do this resolution. You can use `ping` to ensure this is working correctly.

Here's what happens when I run `ping www.google.com` on my Mac:

```
❯ ping www.google.com
PING www.google.com (172.253.62.104): 56 data bytes
64 bytes from 172.253.62.104: icmp_seq=0 ttl=60 time=10.938 ms
64 bytes from 172.253.62.104: icmp_seq=1 ttl=60 time=13.967 ms
64 bytes from 172.253.62.104: icmp_seq=2 ttl=60 time=9.325 ms
64 bytes from 172.253.62.104: icmp_seq=3 ttl=60 time=11.883 ms
64 bytes from 172.253.62.104: icmp_seq=4 ttl=60 time=44.315 ms
64 bytes from 172.253.62.104: icmp_seq=5 ttl=60 time=18.018 ms
64 bytes from 172.253.62.104: icmp_seq=6 ttl=60 time=13.364 ms
^C
--- www.google.com ping statistics ---
7 packets transmitted, 7 packets received, 0.0% packet loss
round-trip min/avg/max/stddev = 9.325/17.401/44.315/11.278 ms
~
```

You can see that it will send back the IP for the google homepage.

> Notice that I had to press `Ctrl-C` to get it to stop.

One gotcha is that many firewalls will block ICMP traffic as it's pretty easy to use `ping` to perform a denial-of-service attack.

### ipconfig

The `ipconfig` command is used on **_Windows_** systems to show information about _Transmission Control Protocol/Internet Protocol_ (TCP/IP) configuration for a given system. This includes:

- IP Address
- Subnet Mask
- Default Gateway
- MAC Address
- Domain Name System (DNS) server
- Network Interface Card (NIC)

Common Commands:

`ipconfig`

Basic info

`ipconfig /all`

Comprehensive listing for each NIC

`ipconfig /displaydns`

Shows the contents of the _DNS cache_ and all the mappings of `host name -> ip address`.

> Each time the system queries the DNS server to resolve a host name to an IP address, the result is stored in the _DNS cache_.

`ipconfig /flushdns`

Erase the contents of the DNS cache

### ifconfig

The `ifconfig` command is used on **_Linux_** systems to show information about _Transmission Control Protocol/Internet Protocol_ (TCP/IP) configuration for a given system.

> The `ifconfig` command has been _depreciated_ on Debian Linux since 2009, but most other Linux distributions still support it.

The same commands as `ipconfig` seen above can be used (use a `-` instead of a `/` for the flags) in addition the expanded features below:

`ifconfig eth0`

Shows the configuration for the first Ethernet interface (NIC) on a Linux system.

`ifconfig eth0 promisc`

Enables _promiscuous_ mode on the first Ethernet interface (use `-promisc` to reverse).

> _Promiscuous mode_ allows a NIC to process _all_ traffic it receives, including traffic not explicitly addressed to it. Useful when you want a protocol analyzer to be able to sniff all traffic on a NIC.

`ifconfig eth0 allmulti`

Enables _multicast mode_ on the NIC, allowing the NIC to process _all_ multicast traffic (use `-allmulti` to disable).

> By default, a NIC will only process multicast traffic for multicast groups it is a part of.

### ip

The `ip` command is a newer Linux command with many of the same features of `ifconfig`, but it can't enable promiscuous mode.

Common commands:

`ip link show`

Similar to `ifconfig`, this will show basic details about the NICs on a system.

`ip link set eth0 up`

Enable a NIC, `eth0` in this case.

`ip -s link`

Show statistics on the NICs on a given system.

### netstat

The `netstat` command is short for _network statistics_.

Common Commands:

`netstat`

Display all open TCP connections.

`netstat -a`

Display all open TCP and UDP ports that a system is listening on, and all open connections.

`netstat -r`

Display the routing table.

`netstat -e`

Display network statistics.

`netstat -s`

Display network _packet_ statistics by protocol.

`netstat -n`

Display addresses and port numbers in numerical order.

`netstat -p <protocol>`

Display statistics on a specific protocol _e.g. tcp_

Connections can have a few different states, which `netstat` will show:

- ESTABLISHED _active open connection_
- LISTEN _waiting for a connection request_
- CLOSE*WAIT \*waiting for a connection \*\*\_termination*\*\* request\*
- TIME*WAIT \_waiting for enough time to pass to be sure that a remote system has received a TCP acknowledgement of the connection*
- SYN*SENT \_waiting for a SYN-ACK response after sending a SYN packet*
- SYN*RECEIVED \_waiting for the ACK response after getting a SYN-ACK packet*

### tracert

This lists the routers between two systems.

Two common variants:

`tracert www.google.com`

This will resolve IPs to host names

`tracert -d www.google.com`

The `-d` flag will not resolve IP addresses, which will speed up the command.

### arp

The `arp` command is used to resolve IP address to MAC addresses and then store the results in the _ARP cache_.

> Note that the `arp` tool is not the same as the `ARP` protocol

Common commands:

`arp`

Shows help on Windows, and the _ARP cache_ on Linux

`arp -a`

Shows the _ARP cache_ on Windows and Mac

`arp -a <ip-address>`

Shows the _ARP cache_ for the specified IP address

#
