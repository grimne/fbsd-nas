# Notes

## Disk burn-in
A good tool is `badblocks` which is a part of `e2fsprogs`.
Calomen have a great guide on how to use this tool: https://calomel.org/badblocks_wipe.html
Or, use this script: https://github.com/Spearfoot/disk-burnin-and-testing


## ZFS on raw or gpart
Good question...

## Disk labeling
The order of `/dev` is incrementing based in position in chassi and is decided during boot. Adding a new disk may mess up the order after reboot. Label the disks with serial number since its already written on the disk and made easy to label the tray. It provides a good overview of what disk is the faulty one and provides simplicity for importing regardless of `/dev` order.
```
# camcontrol identify /dev/da4 | grep 'serial\ number' | cut -d" " -f 11
```
Depends on `smartmontools` which is highly recommended to install anyway

## VMs and jails
`vm-bhyve` + `iocage`

For simple setup, use shared `bridge` for both. Gets complicated when VLANs and/or LAGG is required