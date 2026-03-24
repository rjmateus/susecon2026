# Configuration
Add a file `/etc/salt/master.d/gitfs.conf` with:

```
fileserver_backend:
  - roots
  - git

gitfs_remotes:
  - https://github.com/rjmateus/susecon2026.git:
    - root: salt/states
    - base: main
```

Edit file: `/etc/salt/master.d/susemanager.conf`
```
# Configure external pillar
ext_pillar:
  - suma_minion: True
  - git:
    - main https://github.com/rjmateus/susecon2026.git:
      - root: salt/pillar
      - env: base
```

# Force Update
`salt-run fileserver.update`
`salt-run git_pillar.update`
`salt '*' saltutil.refresh_pillar`
