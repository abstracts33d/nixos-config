# UTM VM keys setup

#### 1. Set UTM network driver to Emulated VLAN

#### 2. Add a port forwarding rule 22 => 2222

#### 3. Setup keys
Copy chown and chmod id_ed25519 to /root/.ssh/id_ed25519
```
ssh -i ~/.ssh/id_ed25519 -p 2222 root@127.0.0.1 mkdir -p /root/.ssh

scp -P 2222 -i ~/.ssh/id_ed25519  ~/.ssh/id_ed25519 root@127.0.0.1:/root/.ssh/id_ed25519
scp -P 2222 -i ~/.ssh/id_ed25519  ~/.ssh/id_ed25519.pub root@127.0.0.1:/root/.ssh/id_ed25519.pub
ssh -i ~/.ssh/id_ed25519 -p 2222 root@127.0.0.1 chmod 600 /root/.ssh/id_ed25519
ssh -i ~/.ssh/id_ed25519 -p 2222 root@127.0.0.1 chmod 644 /root/.ssh/id_ed25519.pub
ssh -i ~/.ssh/id_ed25519 -p 2222 root@127.0.0.1 chown nixos:wheel /root/.ssh/id_ed25519{,.pub}
```
