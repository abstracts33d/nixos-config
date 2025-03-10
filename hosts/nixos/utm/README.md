# UTM VM keys setup

#### 1. Set UTM network driver to Emulated VLAN

#### 2. Add a port forwarding rule 22 => 2222

#### 3. Set nix and root password inside UTM
```
passwd
sudo passwd
```

#### 4. Setup keys
Copy (and chmod) id_main to /root/.ssh/id_ed25519
Copy (and chmod) id_ed25519 to /root/.ssh/id_ed25519_agenix
```
scp -P 2222 -i ~/.ssh/id_main  ~/.ssh/id_main root@127.0.0.1:/root/.ssh/id_ed25519
scp -P 2222 -i ~/.ssh/id_main  ~/.ssh/id_main.pub root@127.0.0.1:/root/.ssh/id_ed25519.pub

scp -P 2222 -i ~/.ssh/id_main  ~/.ssh/id_ed25519 root@127.0.0.1:/root/.ssh/id_ed25519_agenix
scp -P 2222 -i ~/.ssh/id_main  ~/.ssh/id_ed25519.pub root@127.0.0.1:/root/.ssh/id_ed25519_agenix.pub

ssh -i ~/.ssh/id_main -p 2222 root@127.0.0.1 chmod 600 /root/.ssh/id_ed25519
ssh -i ~/.ssh/id_main -p 2222 root@127.0.0.1 chmod 644 /root/.ssh/id_ed25519.pub

ssh -i ~/.ssh/id_main -p 2222 root@127.0.0.1 chmod 600 /root/.ssh/id_ed25519_agenix
ssh -i ~/.ssh/id_main -p 2222 root@127.0.0.1 chmod 600 /root/.ssh/id_ed25519_agenix.pub
```
