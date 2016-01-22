# AutoProx
Bash automation for Proxmox

## Why?
Like you, I love proxmox. But who wants to build the same node 100 times? I don't. So I built this.

#### Why not use the web API?
Not everyone has open port access to their boxes in their environment. I don't. I have free roam SSH access though, and luckily the good people who built proxmox provided a CLI based tool that I can call via SSH. Proxmox documentation itself describes PVESH as a "swiss army knife for developers and system administrators." Since this allows you to do anything from CLI that you can via GUI, it's all entirely scriptable. Just like programmers keep things DRY, admins should take the same approach to tasks.

## Examples
(will be updated as functionality imrpoves, also check command usage)

Scan your storage for templates:
`autoprox -F -d [name-of-server]`

Build a LXC from settings file:
`autoprox -x -s [settings file]`

Or create a script declaring just what will differ:
```
#!/bin/bash
autoprox -x -s [settings file] -i 200 -H 200 -P mydefaultpass
autoprox -x -s [settings file] -i 201 -H 201 -P mydefaultpass
autoprox -x -s [settings file] -i 202 -H 202 -P mydefaultpass
autoprox -x -s [settings file] -i 203 -H 203 -P mydefaultpass
autoprox -x -s [settings file] -i 204 -H 204 -P mydefaultpass
autoprox -x -s [settings file] -i 205 -H 205 -P mydefaultpass
autoprox -x -s [settings file] -i 206 -H 206 -P mydefaultpass
autoprox -x -s [settings file] -i 207 -H 207 -P mydefaultpass
```
