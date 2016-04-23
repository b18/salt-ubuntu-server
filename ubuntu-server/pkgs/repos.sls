# SaltStack
saltstack.key:
   cmd.run:
     - name: 'wget -O - https://repo.saltstack.com/apt/ubuntu/ubuntu14/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -'
     - unless: apt-key list | grep "SaltStack Packaging Team"
/etc/apt/sources.list.d/saltstack.list:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://ubuntu-server/files/etc/apt/sources.list.d/saltstack.list
    - require:
      - cmd: saltstack.key
    - require_in:
      - pkg: pkg-installed # Salt-Minion

# BitTorrent Sync
btsync.key:
   cmd.run:
     - name: 'wget -qO – http://linux-packages.getsync.com/btsync/key.asc | sudo apt-key add -'
     - unless: apt-key list | grep "SaltStack Packaging Team"
/etc/apt/sources.list.d/btsync.list:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://ubuntu-server/files/etc/apt/sources.list.d/btsync.list
    - require:
      - cmd: btsync.key
    - require_in:
      - pkg: pkg-installed # BTSync
