---
title: "2024 01 16 Properly Close Open Port"
date: 2024-01-16T20:07:51+01:00
# weight: 1
# bookFlatSection: true
# bookToc: false
# bookHidden: true
# bookCollapseSection: true
# bookComments: true
# bookSearchExclude: true
---

Run the following command to scan for locally open port
```bash
nmap localhost
```

Now, using `netstat` to find the process that is using the port

```bash
netstat -lnp
```

we can see the PID and the name of the process that open the port. We need to kill them. However, if the process is automatically started by the system, we need to disable it. See the startup service
```bash
sudo service --status-all
```

To disable startup
```bash
sudo systemctl disable name.service
```
check if it is diabled
```bash
sudo systemctl is-enabled name.service
```

All process that killed: postgresql, cups, cups-browsed, lighttpd