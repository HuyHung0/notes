---
title: CTF playbook
date: 2023-10-30

#author: "Huy Hung LE"
#linktitle: CTF playbook

description:

categories: "ctf"
tags: "ctf"
---

## Steganography image

### Some links
<https://pequalsnp-team.github.io/cheatsheet/steganography-101>

### View type - file

```bash
file <image>
```

### View image - feh, display, eog
```bash
feh <image>
display <image>
eog <image>
```
- `oeg`: preinstalled in debian
- `display`: need to install imagemagick
- `feh`: need to install feh

### View meta exiftool

```bash
exiftool <image>
```

or

```bash
exiftool  -all <image>
```

**Remark:** ```exiftool -all= <img>``` will delete all metadata an rewrite the file. It created another file `_original` for the original file.

### View text inside - strings

```bash
strings <image> | grep -i "flag"
```

### Extract embedded file - binwalk

```bash
binwalk -Me <file>
```
Option `-M`: Recursively scan extracted files

Option `-e`: Automatically extract known file types

### Filter color - stegonline.georgeom.net

Using website <https://stegonline.georgeom.net/upload> for viewing different color filter

### Check information about embedded file with password - steghide

```bash
steghide info <file>
```
Then extract with password
```bash
steghide extract -sf <file>
```

### Bruteforce password - stegseek
We dont use stegcracker since it takes very long time to crack. Instead, we use stegseek.

Download `deb` file at <https://github.com/RickdeJager/stegseek/releases>, then install it.
```bash
stegseek <file> <wordlist.txt>
```
It can also be used to detect and extract any unecrypted (meta) data from a steghide image.
```bash
stegseek --seed <file>
```

## Steganography - Video

### Extract frame - ffmpeg
```bash
ffmpeg -i <video> -vf fps=1 out%03d.jpg
```

fps is frame per second.