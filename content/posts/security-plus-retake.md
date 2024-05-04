---
title: "Re-taking the CompTIA Security+ Exam"
date: 2024-04-28T10:50:29-04:00
slug: 2024-04-28-re-taking-the-comptia-security-plus
summary: "Kill me."
draft: true
categories:
  - notes
tags:
  - "CompTIA"
  - "Security+"
  - "Certification"
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
- [Chapter 02: Understanding Identify and Access Management](#chapter-02-understanding-identify-and-access-management)
  - [Authentication Concepts](#authentication-concepts)
    - [Group Policy](#group-policy)
    - [Smart Cards](#smart-cards)
    - [Key Fobs](#key-fobs)
    - [HOTP](#hotp)
    - [TOTP](#totp)
    - [Biometric Methods](#biometric-methods)
    - [Multifactor Authentication](#multifactor-authentication)
  - [Authentication Protocols](#authentication-protocols)
    - [Kerberos](#kerberos)
    - [NTLM](#ntlm)
    - [LDAP](#ldap)
      - [LDAPS](#ldaps)
    - [Single Sign-On](#single-sign-on)
      - [Transitive Trust](#transitive-trust)
      - [SAML](#saml)

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

Encryption is scrambling your data in a way that only you can unscramble it.

- It's used for covering up _Personally Identifiable Information_ (PII)

### Access Controls

So, like, uh - this is all about control and power.

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

Note that all this stuff is expensive. Also, encrypting and duplicating data takes up a huge amount of disk space and compute. So try to get away with the least amount of it as possible.

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

Stuff you can touch.

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

> ❗ The `ifconfig` command has been _depreciated_ on Debian Linux since 2009, but most other Linux distributions still support it.

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

| State        | Description                                                                                                          |
| ------------ | -------------------------------------------------------------------------------------------------------------------- |
| ESTABLISHED  | active open connection                                                                                               |
| LISTEN       | waiting for a connection request                                                                                     |
| CLOSE_WAIT   | waiting for a connection termination request                                                                         |
| TIME_WAIT    | waiting for enough time to pass to be sure that a remote system has received a TCP acknowledgement of the connection |
| SYN_SENT     | waiting for a SYN-ACK response after sending a SYN packet                                                            |
| SYN_RECEIVED | waiting for the ACK response after getting a SYN-ACK packet                                                          |

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

# Chapter 02: Understanding Identify and Access Management

---

Table of Contents:

- [Chapter 02: Understanding Identify and Access Management](#chapter-02-understanding-identify-and-access-management)
  - [Authentication Concepts](#authentication-concepts)
    - [Group Policy](#group-policy)
    - [Smart Cards](#smart-cards)
    - [Key Fobs](#key-fobs)
    - [HOTP](#hotp)
    - [TOTP](#totp)
    - [Biometric Methods](#biometric-methods)
    - [Multifactor Authentication](#multifactor-authentication)
  - [Authentication Protocols](#authentication-protocols)
    - [Kerberos](#kerberos)
    - [NTLM](#ntlm)
    - [LDAP](#ldap)
      - [LDAPS](#ldaps)
    - [Single Sign-On](#single-sign-on)
      - [Transitive Trust](#transitive-trust)
      - [SAML](#saml)
  - [Managing Accounts](#managing-accounts)
  - [Access Control Models](#access-control-models)
    - [Role-Based](#role-based)
      - [Group-Based](#group-based)
    - [Rule-Based](#rule-based)
    - [Discretionary](#discretionary)
    - [Mandatory](#mandatory)
    - [Attribute-Based](#attribute-based)

## Authentication Concepts

---

Basics:

- _identification_ - username, email address, etc
- _authentication_ - password, passkey, fingerprint scan, etc
- _AAA_ - authentication, authorization and accounting.

Authentication can be achieved through:

- Something you know (password)
- Something you have (smart card)
- Something you are (fingerprint)
- Somewhere you are (IP address location)
- Something you do (gestures on a touchscreen)

### Group Policy

Windows systems use _Group Policy Objects_ (GPOs) to manage multiple users/computers.

Basically, it boils down to giving admins a way to reuse policies by saving them in a _Group Policy Object_ that can be applied to many users or computers within an domain. Examples include:

- password polices
- firewall rules
- security/access rules
- account lockout policies

### Smart Cards

Smart cards use embedded certificates in conjunction with _Public Key Infrastructure_ (PKI) systems to work.

The Department of Defense uses two extra-turbo variants which include a photo ID and other readable info:

- _Common Access Card_ (CAC)
- _Personal Identity Verification_ (PIV)

### Key Fobs

Sometimes called tokens, these are synced up to a server to provide a _One-Time Password_ (OTP).

Similar to Google Authenticator on your phone, but as a stand-alone device.

### HOTP

Quick reference:

- HMAC - _Hash-based Message Authentication Code_
- HOTP - _HMAC-based One-Time Password_

How does HOTP work?

1. Generate a character sequence using a _secret key_ and a _incrementing counter_
1. Run it through HMAC to create a hash of the result
1. Convert the result into a 6-8 character HOTP value

> ❗ Once used, the HOTP code expires, but it will last _forever_ till it is used.

### TOTP

A _Time-based One-Time Password_ (TOTP) is similar to HOTP, except the _incrementing counter_ is swapped for a _timestamp_ in the generation algorithm.

> ❗ TOTP codes typically expire after 30 seconds.

### Biometric Methods

Secret lair shit

- Fingerprint scanners
- Retina scanners
- Iris scanners
- Voice recognition
- Facial recognition

Biometric is pretty reliable, but it is not _exact_ and can have errors/false positives.

- False Acceptance Rate (FAR)
- False Rejection Rate (FRR)
- Crossover Error Rate (CER) - where the FAR and FRR converge (lower is better)

### Multifactor Authentication

This is just a combination of two or more types of authentication.

- password + key fob
- retina scan + smart card
- etc

## Authentication Protocols

There are a few protocols that are important to know:

- Kerberos
- NTLM

### Kerberos

_Kerberos_ is another name for _Cerberus_, who is the three-headed watchdog of Hades.

- Each head represents birth, life and death, respectively.
- _Kerberos_ guards the gates to the underworld.

This is actually a pretty good name for this authentication protocol as _Kerberos_ guards the network by making users _mutually_ prove their identity before access is granted.

This is useful to guard against:

- _man-in-the-middle_ attacks
- _replay_ attacks

Additionally, it has three different "actors" (like the three heads) in the protocol:

| Actor                         | Description                                      |
| ----------------------------- | ------------------------------------------------ |
| Client                        | The entity seeking to gain access                |
| Application Server (AP)       | The service the entity wants to gain access to   |
| Key Distribution Server (KDS) | A trusted third party that issues access tickets |

The big selling point of _Kerberos_ is the ability to issue tickets that have an expiration, typically 10 hours for a given workday.

Also, _Kerberos_ works on Windows, Mac and Unix systems.

### NTLM

_New Technology LAN Manager_ (NTLM) is a Windows-only authentication protocol.

There are three versions:

| Version | Description                                                                                                                                |
| ------- | ------------------------------------------------------------------------------------------------------------------------------------------ |
| NTLM    | Simple MD4 has of a user's password. Not recommended as MD4 has been cracked.                                                              |
| NTLMv2  | Challenge-response protocol that uses a HMAC-MD5 hash based on username, logon domain, password, current time, and any other custom seeds. |
| NTML2   | Builds on _NTLMv2_ to include mutual authentication between the client and server.                                                         |

Microsoft recommends using the _Negotiate_ security package instead of picking one flavor manually.

- This will try to use _Kerberos_ first, and if not available, try NTLM instead.

### LDAP

_Lightweight Directory Access Protocol_ (LDAP) is an extension of the X.500 standard that is used specific the format and methods used to query "directories".

> In LDAP parlance, a _directory_ is a database of objects used to manage users, computers and other objects. Not to be confused with Linux directories aka folders.

_Active Directory_, a Windows administrative system, is based on LDAP. Additionally, Unix realms use LDAP to identify objects.

What's kind of neat about LDAP is that you can script it.

Take the following LDAP String for the `PeaPod.com` domain:

> `LDAP://CN=Homer,CN=Users,DC=PeaPod,DC=com`

This corresponds to:

| LDAP Chunk | Description                                                              |
| ---------- | ------------------------------------------------------------------------ |
| CN=Homer   | CN is short for common name, in this case 'Homer'                        |
| CN=Users   | CN in this context is referred to as a _container_, in this case 'Users' |
| DC=PeaPod  | DC is short for _domain component_, in this case 'PeaPod'                |
| DC=com     | The second _domain component_ in the domain name, 'com'                  |

#### LDAPS

_Lightweight Directory Access Protocol Secure_ (LDAPS) is the same as LDAP, but it has some extra security features.

- When a client connects to a server, a _Transport Layer Security_ (TLS) session is established
- TLS then encrypts any transmitted data

### Single Sign-On

_Single Sign-On_ (SSO) is a system that allows a user to provide credentials once to access multiple systems.

> This may seem like a security bottleneck, but it actually increases security posture as end users only have to account for one password or access method.

#### Transitive Trust

_Transitive Trust_ is an indirect trust relationship.

If you have three people, Adam, Bill and Cara, you can model it like so:

- Adam trusts Bill
- Bill trusts Cara
- Adam trusts Cara (Transitive Trust)

In LDAP, this can be applied to Domains. Take for example this _Parent_ Domain with two _Children_:

- `PeaPod.com` trusts `Blog.PeaPod.com`
- `PeaPod.com` trusts `Pictures.PeaPod.com`

Each of the _Children_ have _Transitive Trust_ with each other despite not having a direct relationship:

- `Blog.PeaPod.com` trusts `Pictures.PeaPod.com`
- `Pictures.PeaPod.com` trusts `Blog.PeaPod.com`

```
     Parent
       /\
      /  \
     /    \
Child_1   Child_2
```

#### SAML

_Security Assertion Markup Language_ (SAML) is an XML based format used by SSO in web browsers. It allows a web browser to pass a SAML document back to a server infrastructure so that

SAML defines three roles:

| Role              | Description                                                                                                                   |
| ----------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| Principal         | Typically a user, who logs on once.                                                                                           |
| Identity Provider | Creates, maintains and manages identiy information from _Principals_.                                                         |
| Service Provider  | Provides services to _Principals_, like a redirection to a login portal or sharing XML between backend systems after a login. |

## Managing Accounts

There's a bunch of crap that I don't want to note down because it's pretty self-explanatory.

## Access Control Models

There are xxx amount of _Access Control Models_ that are in common use.

> Note these are are post-fixed with _Access Control_

| Name            | Abbreviation            |
| --------------- | ----------------------- |
| Role-Based      | RBAC                    |
| Group-Based     | GBAC (I think)          |
| Rule-Based      | also, confusingly, RBAC |
| Discretionary   | DAC                     |
| Mandatory       | MAC                     |
| Attribute-Based | ABAC                    |

### Role-Based

Assigns access based on the role - a developer would be assigned the access levels associated with the developer role.

This is flexible as users can have more than one role.

#### Group-Based

_Group-Based Access Control_ are a subset of _Role-Based Access Control_ (they are basically the same).

Administrators create groups, and then assign users to the group, like the developer example above.

### Rule-Based

_Rule-Based Access Control_ is not associated with users - a common use case is ACL rules in a firewall.

Additionally, sometimes Rule-Based systems create or modify rules in an automated way in response to events.

### Discretionary

_Discretionary Access Control_ uses a system where every _object_ has an _owner_.

- The _owner_ has **full** control over who else can access the _object_

Microsoft _New Technology File System_ (NTFS) uses DAC.

- Every _object_ has a _Discretionary Access Control List_ (DACL) that specifies who has access to it.
- This has a security flaw in that Trojan Horses are somewhat easy to inject in this system

### Mandatory

_Mandatory Access Control_ uses security/sensitivity labels to identify _objects_ and _users_.

Below is an example of a label system that an admin might use.

| Security Label | Example  | Example          | Example    |
| -------------- | -------- | ---------------- | ---------- |
| Top Secret     | UFOs     | Nuclear Missiles | 007        |
| Secret         | Research | Legal            |            |
| Confidential   | Payroll  | Budget           | Healthcare |

### Attribute-Based

_Attribute-Based Access Control_ uses an evaluation approach.

Rules are generated based on values, which makes it suitable for use with _Software Defined Networks_ (SDNs)

# Chapter 03: Exploring Network Technologies and Tools

---

Stuff in this chapter:

<toc to come>

## Basic Networking Protocols

---

There are a bunch of protocols to memorize, here we go.

### TCP

_Transmission Control Protocol_ is a **guaranteed delivery** protocol.

It uses a three-way handshake to setup a connection.

- SYN - _synchronize_
- ACK - _acknowledge_

```
Client          Server
+----+          +----+
|    |   SYN    |    |
|    | ------>  |    |
|    |          |    |
|    | SYN/ACK  |    |
|    | <------  |    |
|    |          |    |
|    |   ACK    |    |
|    | ------>  |    |
+----+          +----+
```

### UDP

_User Datagram Protocol_ provides connectionless sessions - no three-way handshake, no guaranteed delivery.

Commonly used for video/audio, as well as ICMP traffic such as the `ping` tool.

### IP

_Internet Protocol_ identifies hosts in a TCP/IP network and delivers traffic from one host to another.

Two formats:

- IPv4 - `192.168.1.100`
- IPv6 - `2001:0db8:85a3:0000:0000:8a2e:0370:7334`

### ICMP

_Internet Control Message Protocol_ is used for testing basic connectivity.

The following tools all use ICMP:

- `ping`
- `pathping`
- `tracert`

Often Denial of Service (DoS) attacks use ICMP, and many firewalls block ICMP traffic.

### ARP

_Address Resolution Protocol_ resolves IPv4 address to _Media Access Control_ (MAC) address on a local network.

A common attack associated with this protocol is _Arp Poisoning_

### NDP

_Neighbor Discovery Protocol_ is similar to ARP but for IPv6.

## Use Cases for Protocols

---

Just rattling off some protocols isn't super useful, so let's look at some use cases.

### Voice and Video

There are a couple of useful protocols that build on UDP in this domain.

| Protocol                                   | Description                                                      |
| ------------------------------------------ | ---------------------------------------------------------------- |
| Real Time Transport Protocol (RTP)         | Foundational protocol used for audio and video                   |
| Voice over Internet Protocol (VoIP)        | Uses RTP to deliver real time audio                              |
| Secure Real-time Transport Protocol (SRTP) | Provides encryption, message authenticaion and integrity for RTP |

SRTP is used for preventing _replay attacks_

### File Transfer

_File Transfer Protocol_ (FTP)

- good for large amounts of data
- transmits in clear text
- has two modes, active and passive
- active uses TCP port 20 for data and 21 for control signals
- passive uses a **random** TCP port for data and 21 for control signals
- passive is also known as PASV

_Trivial File Transfer Protocol_ (TFTP)

- small amounts of data
- uses TCP port 69
- commonly disabled

_Secure Shell_ (SSH)

- encrypts traffic in transit
- can be used to encrypt FTP
- uses TCP port 22

_Secure Copy_ (SCP)

- based on SSH
- copies encrypted files over a network

_Secure Sockets Layer_ (SSL)

- used to secure HTTP traffic as HTTPS
- used to secure SMTP and LDAP as well
- has been compromised - not recommended for use

_Transport Layer Security_ (TLS)

- replacement for SSL

_Internet Security Protocol_ (IPsec)

- used to encrypt IP traffic
- native to IPv6
- works with IPv4
- used to create "tunnels" for VPN traffic
- uses UDP port 500

_Secure File Transfer Protocol_ (SFTP)

- extends **_SSH_** to transmit files in an encrypted format
- uses TCP port 22

_File Transfer Protocol Secure_ (FTPS)

- extends FTP and uses **_TLS_** to encrypt traffic
- uses either TCP port 989 or 990, or uses TLS to encrypt before sending over 20/21

> How to remember these two confusingly named things?
>
> - starting "S" in SFTP matches the staring "S" in SSH
> - ending "S" in FTPS matches the ending "S" in TLS
