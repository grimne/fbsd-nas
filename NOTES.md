# Notes

## Disk burn-in
A good tool is `badblocks` which is a part of `e2fsprogs`.
Calomen have a great guide on how to use this tool: https://calomel.org/badblocks_wipe.html
Or, use this script: https://github.com/Spearfoot/disk-burnin-and-testing


## ZFS on raw or gpart
Good question...

## Disk labeling
## Disk and partition labeling
The order of `/dev` is incrementing based in position in chassi and is decided during boot. Adding a new disk may mess up the order after reboot. Label the disks with serial number since its already written on the disk and made easy to label the tray. It provides a good overview of what disk is the faulty one and provides simplicity for importing regardless of `/dev` order.
```
# camcontrol identify /dev/da4 | grep 'serial\ number' | cut -d" " -f 11
```
Depends on `smartmontools` which is highly recommended to install anyway.

As mentioned above, if using raw disk into pools and let ZFS do what it does you cannot label the disk manually. Instead, set `kern.geom.label.disk_ident.enable="YES"` in `/boot/loaders.conf` (requires reboot) to get a ID ordered list of disks and their partitions:
```
ls /dev/diskid/
crw-r-----  1 root  operator  0x5c Mar 23 16:36 DISK-BHYVE-abc-123-xyz1
crw-r-----  1 root  operator  0x71 Mar 23 16:36 DISK-BHYVE-abc-123-xyz1p1
crw-r-----  1 root  operator  0x62 Mar 23 16:36 DISK-BHYVE-abc-123-xyz2
crw-r-----  1 root  operator  0x7a Mar 23 16:36 DISK-BHYVE-abc-123-xyz3
```
Another caveat is that `diskinfo -s /dev/da4` *usually* (not always) return the serial number as identifyer.

## VMs and jails
`vm-bhyve` + `iocage`

For simple setup, use shared `bridge` for both. Gets complicated when VLANs and/or LAGG is required