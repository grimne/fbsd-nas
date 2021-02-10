# TrueNAS-like CLI disk and ZFS management for FreeBSD
## A basic set of scripts to run FreeBSD as NAS.

The scripts is heavily inspired by the amazing work of TrueNAS (formely known as FreeNAS), they really know what they are doing.

_fbsd-nas_ is created to get the basic disk and ZFS management functionality as used in TrueNAS source code but in the format of shell scripts. 

## Quickstart
### Global installation 
- Clone this repo
- Within the repo folder:
```
# sh install.sh
# nas usage
```
Make sure to run with super user privileges 

### Run as local user
- Clone this repo
- Within the repo folder:
```
# sh nas usage
```


## Background
The scripts derrived from reading the source of bhyve-vm and experimenting with TrueNAS which did not meet my needs. Although TrueNAS is great, it really is, it comes packed with alot of functionality, in wich 99% of them I dont use. Also it's, as intended, lacking the ability to modify and use the base OS to its full capacity.

So, for some people, me for instance, pure FreeBSD gives more freedom to customize and really be in control to allow whatever I wish to run, with or without extra layers like jails or vms.

### Hey, author! What did you expect?
First, some background about how I want my server to function:
* ZFS pool(s)
* Various jails
* Various VMs
* NFS share

Thats it! No need for all the other functionality TrueNAS brings.

## Why do this?
For a home or SOHO server with a small amount of load and traffic, things usually run quite smooth and without any bigger disruption. Instead of keeping notes about how to replace a failed disk in a pool, what commands to run when hot-swaping etc, I wanted a simple script with clear arguments to quickly perform necessary and fairly advanced tasks without depending on what answers internet provides.


## Included scripts and roadmap
### Disk
  * [x] Wipe disk
  * [x] Partition disk
    * [x] Specify data partition size
  * [x] Label disk/partition (serial, uuid, custom)
  * [x] Hot-Swap disk
### Encryption
  * [x] GELI init + disk encryption
  * [x] GELI attach
### zpool
  * [x] Create zpool
  * [ ] Destroy zpool
  * [ ] Expand zpool
  * [ ] Replace disk in pool
### ZFS/Dataset/ZVol
  * [ ] Create Dataset
  * [ ] Destroy dataset
  * [ ] Create ZVol
  * [ ] Destroy ZVol


_If requested and/or needed, support for multiple disks in wipe/partition and other areas where it makes sense_

## What is _not_ included
### TrueNAS swap magic
TrueNAS does some kind of magical stuff with swap. Each time a pool modification that includes adding a disk is done, a small swap partition is created. After each disk operation including zpool manipulation, it rebuilds the swap including the new disk. The operation is inverted if disk is removed. This will spread potential swap I/O over on each disk in the system that is used in a pool. The partition size is calculated with configured sytem swap as base: `swap size in gb * 1024 * 1024 * 1024 / "sectorsize" or 512`. The reason for this makes perfect sense if using small and/or slow boot drive(s), like USB-stick(s). As you might can imagine, its probably neither possible or feasible to create something like this using shell script. PRs are welcome though!

### Shares and services
This is BYOSAS - Bring Your Own Shares And Services.

### Also
- Alerts
- System stats
- User management to set permissions throughout shares and jails

...etc


## Script for importing GELI encrypted disks

```bash
#!/bin/sh
# If only works with bash, rewrite to sh which is more native

# Copy-paste from https://blog.haraschak.com/from-dev-to-label/

zpool='pool'
devices=(da12p1 da13p1 da14p1 da15p1 da16p1)

read -s -p 'Decryption password: ' pass
echo
for name in "${devices[@]}"; do
    echo "Decrypting: $name"
		echo -n "$pass" | geli attach -j - -k /root/geli.key "/dev/$name" || exit 1
done

sleep 2

echo "Importing pool: $zpool"
zpool import "$zpool"
zpool status
```
