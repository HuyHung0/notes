---
title: Docker Kali
---
# Tip and tricks

## Install docker kali
```bash
sudo apt update
sudo apt install docker.io
sudo systemctl enable docker --now
docker
```

Add docker to sudo group
```bash
sudo usermod -aG docker $SUSER
```
then logout and login again (better to restart)