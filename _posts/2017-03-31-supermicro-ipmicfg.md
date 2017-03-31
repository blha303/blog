---
layout: post
title: SuperMicro IPMICFG
---

I've had to do this a couple times now, so I thought I would write up the process of setting an IP on a SuperMicro server with an IPMI management card.

1. Create a FreeDOS USB with [Rufus](https://rufus.akeo.ie). I used Rufus because it creates a working FreeDOS installation without needing to actually install it. The option to set up FreeDOS is, as far as I know, the preselected option when you open Rufus for the first time; just ensure it's selected the correct USB drive.

2. Get IPMICFG from [SuperMicro's FTP server](ftp://ftp.supermicro.com/utility/IPMICFG/).

3. Extract the contents of the DOS folder from the zip downloaded in the previous step to the FreeDOS USB. Create a new directory for them if you wish.

4. Boot your server from this USB. I found the rear ports to be more reliable for mass storage devices.

5. Use `cd` to enter the directory containing the files from step 3 if applicable, then run `ipmicfg` to see options. `ipmicfg -m` to show IP, `ipmicfg -dhcp on` to enable DHCP (a full power cycle is needed to acquire a DHCP address, i.e removing and replacing the power cord), `ipmicfg -k` to set subnet mask, `ipmicfg -g` to set gateway IP, `ipmicfg -user setpwd 2 password` to reset the administrator password (check the user ID with `ipmicfg -user list`).

6. ????

7. Server awayyyyyyyyyyyy
