# General Purpose Nix Config for macOS + NixOS

## Table of Contents

- [Nix Config for macOS + NixOS](#nix-config-for-macos--nixos)
  - [Disclaimer](#disclaimer)
  - [Layout](#layout)
  - [Installing](#installing)
    - [For macOS (January 2025)](#for-macos-january-2025)
      - [1. Install dependencies](#1-install-dependencies)
      - [2. Install Nix](#2-install-nix)
      - [3. Initialize the template](#3-initialize)
      - [4. Make apps executable](#4-make-apps-executable)
      - [5. Apply your current user info](#5-apply-your-current-user-info)
      - [6. Setup secrets](#6-setup-secrets)
      - [7. Install configuration](#7-install-configuration)
      - [8. Make changes](#8-make-changes)
    - [For NixOS](#for-nixos)
      - [1. Burn and use the latest ISO](#1-burn-and-use-the-latest-iso)
      - [2. Setup secrets](#2-setup-secrets)
      - [3. Install configuration](#3-install-configuration)
      - [4. Set user password](#4-set-user-password)
  - [How to Create Secrets](#how-to-create-secrets)


## Disclaimer
Installing Nix on macOS will create an entirely separate volume. It may exceed many gigabytes in size.


> [!NOTE]
> Don't worry, you can always [uninstall](https://github.com/DeterminateSystems/nix-installer#uninstalling) Nix later.

## Layout
```
.
├── apps         # Nix commands used to bootstrap and build configuration
├── hosts        # Host-specific configuration
├── modules      # macOS and nix-darwin, NixOS, and shared configuration
├── overlays     # Drop an overlay file in this dir, and it runs. So far, mainly patches.
```

## Installing
## For macOS (January 2025)
This configuration supports both Intel and Apple Silicon Macs.

### 1. Install dependencies
```sh
xcode-select --install
```

### 2. Install Nix
Thank you for the [installer](https://zero-to-nix.com/concepts/nix-installer), [Determinate Systems](https://determinate.systems/)!
```sh
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```
After installation, open a new terminal session to make the `nix` executable available in your `$PATH`. You'll need this in the steps ahead.

> [!IMPORTANT]
>
> If using [the official installation instructions](https://nixos.org/download) instead, [`flakes`](https://nixos.wiki/wiki/Flakes) and [`nix-command`](https://nixos.wiki/wiki/Nix_command) aren't available by default.
>
> You'll need to enable them.
>
> **Add this line to your `/etc/nix/nix.conf` file**
> ```
> experimental-features = nix-command flakes
> ```
>
> **_OR_**
>
> **Specify experimental features when using `nix run` below**
> ```
> nix --extra-experimental-features 'nix-command flakes' run .#<command>
> ```

### 3. Initialize

```sh
mkdir -p nixos-config && cd nixos-config && nix flake --extra-experimental-features 'nix-command flakes' init -t github:abstracts33d/nixos-config
```

### 4. Make [apps](https://github.com/abstracts33d/nixos-config/tree/main/apps) executable
```sh
find apps/$(uname -m | sed 's/arm64/aarch64/')-darwin -type f \( -name apply -o -name build -o -name build-switch -o -name create-keys -o -name copy-keys -o -name check-keys -o -name rollback \) -exec chmod +x {} \;
```

### 5. Apply your current user info
Run this Nix command to replace stub values with your system properties, username, full name, and email.
> Your email is only used in the `git` configuration.
```sh
nix run .#apply
```
> [!NOTE]
> If you're using a git repository, only files in the working tree will be copied to the [Nix Store](https://zero-to-nix.com/concepts/nix-store).
>
> You must run `git add .` first.

### 6. Setup secrets

#### 8a. Create a private Github repo to hold your secrets
In Github, create a private [`nix-secrets`](https://github.com/abstracts33d/nix-secrets-example) repository with at least one file (like a `README`). You'll enter this name during installation.

#### 8b. Install keys
Before generating your first build, these keys must exist in your `~/.ssh` directory. Don't worry, I provide a few commands to help you.

| Key Name            | Platform         | Description                                                                              |
|---------------------|------------------|------------------------------------------------------------------------------------------|
| id_ed25519          | macOS / NixOS    | Github key with access to `nix-secrets`. Not copied to host, used only during bootstrap. |
| id_ed25519_agenix   | macOS / NixOS    | Primary key for encrypting and decrypting secrets. Copied over to host as `id_ed25519`.  |

Run one of these commands:

##### Copy keys from USB drive
This command auto-detects a USB drive connected to the current system.
> Keys must be named `id_ed25519` and `id_ed25519_agenix`.
```sh
nix run .#copy-keys
```

##### Create new keys
```sh
nix run .#create-keys
```
> [!NOTE]
> If you choose this option, make sure to [save the value](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account) of `id_ed25519.pub` to Github.
>
> ```sh
> cat /Users/$USER/.ssh/id_ed25519.pub | pbcopy # Copy key to clipboard
> ```

##### Check existing keys
If you're rolling your own, just check they are installed correctly.
```sh
nix run .#check-keys
```

### 7. Install configuration
Ensure the build works before deploying the configuration, run:
```sh
nix run .#build
```
> [!NOTE]
> If you're using a git repository, only files in the working tree will be copied to the [Nix Store](https://zero-to-nix.com/concepts/nix-store).
>
> You must run `git add .` first.

> [!WARNING]
> You may encounter `error: Unexpected files in /etc, aborting activation` if `nix-darwin` detects it will overwrite
> an existing `/etc/` file. The error will list the files like this:
>
> ```
> The following files have unrecognized content and would be overwritten:
>
>   /etc/nix/nix.conf
>   /etc/bashrc
>
> Please check there is nothing critical in these files, rename them by adding .before-nix-darwin to the end, and then try again.
> ```
> Backup and move the files out of the way and/or edit your Nix configuration before continuing.

### 8. Make changes
Finally, alter your system with this command:
```sh
nix run .#build-switch
```

## For NixOS
This configuration supports both `x86_64` and `aarch64` platforms.

### 1. Burn and use the latest ISO
Download and burn [the minimal ISO image](https://nixos.org/download.html) to a USB, or create a new VM with the ISO as base. Boot the installer.
> If you're building a VM on an Apple Silicon Mac, choose [64-bit ARM](https://channels.nixos.org/nixos-23.05/latest-nixos-minimal-aarch64-linux.iso).

**Quick Links**

* [64-bit Intel/AMD](https://channels.nixos.org/nixos-23.05/latest-nixos-minimal-x86_64-linux.iso)
* [64-bit ARM](https://channels.nixos.org/nixos-23.05/latest-nixos-minimal-aarch64-linux.iso)

### 2. Setup secrets

#### 2a. Create a private Github repo to hold your secrets

#### 2b. Install keys
Before generating your first build, these keys must exist in your `~/.ssh` directory. Don't worry, I provide a few commands to help you.

| Key Name            | Platform         | Description                                                                              |
|---------------------|------------------|------------------------------------------------------------------------------------------|
| id_ed25519          | macOS / NixOS    | Github key with access to `nix-secrets`. Not copied to host, used only during bootstrap. |
| id_ed25519_agenix   | macOS / NixOS    | Primary key for encrypting and decrypting secrets. Copied over to host as `id_ed25519`.  |

Run one of these commands:

##### Copy keys from USB drive
This command auto-detects a USB drive connected to the current system.
> Keys must be named `id_ed25519` and `id_ed25519_agenix`.
```sh
sudo nix run --extra-experimental-features 'nix-command flakes' github:abstracts33d/nixos-config#copy-keys
```

##### Create new keys
```sh
sudo nix run --extra-experimental-features 'nix-command flakes' github:abstracts33d/nixos-config#create-keys
```

##### Check existing keys
If you're rolling your own, just check they are installed correctly.
```sh
sudo nix run --extra-experimental-features 'nix-command flakes' github:abstracts33d/nixos-config#check-keys
```

### 3. Install configuration

> [!IMPORTANT]
> For Nvidia cards, select the second option, `nomodeset`, when booting the installer, or you will see a blank screen.

> [!CAUTION]
> Running this will reformat your drive to the `ext4` filesystem.

```sh
sudo nix run --extra-experimental-features 'nix-command flakes' github:abstracts33d/nixos-config#install
```

### 4. Set user password
On first boot at the login screen:
- Use shortcut `Ctrl-Alt-F2` (or `Fn-Ctrl-Option-F2` if on a Mac) to move to a terminal session
- Login as `root` using the password created during installation
- Set the user password with `passwd <user>`
- Go back to the login screen: `Ctrl-Alt-F7`

## How to create secrets
To create a new secret `secret.age`, first [create a `secrets.nix` file](https://github.com/ryantm/agenix#tutorial) at the root of your [`nix-secrets`](https://github.com/abstracts33d/nix-secrets-example) repository. Use this code:

> [!NOTE]
> `secrets.nix` is interpreted by the imperative `agenix` commands to pick the "right" keys for your secrets.
>
> Think of this file as the config file for `agenix`. It's not part of your system configuration.

**secrets.nix**
```nix
let
  user1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL0idNvgGiucWgup/mP78zyC23uFjYq0evcWdjGQUaBH";
  users = [ user1 ];

  system1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPJDyIr/FSz1cJdcoW69R+NrWzwGK/+3gJpqD1t8L2zE";
  systems = [ system1 ];
in
{
  "secret.age".publicKeys = [ user1 system1 ];
}
```
Values for `user1` should be your public key, or if you prefer to have keys attached to hosts, use the `system1` declaration.

Now that we've configured `agenix` with our `secrets.nix`, it's time to create our first secret.

Run the command below.

```
EDITOR=vim nix run github:ryantm/agenix -- -e secret.age
```

This opens an editor to accept, encrypt, and write your secret to disk.

The command will look up the public key for `secret.age`, defined in your `secrets.nix`, and check for its private key in `~/.ssh/.`

> To override the SSH path, provide the `-i` flag with a path to your `id_ed25519` key.

Write your secret in the editor, save, and commit the file to your [`nix-secrets`](https://github.com/abstracts33d/nix-secrets-example) repo.

Now we have two files: `secrets.nix` and our `secret.age`.

Here's a more step-by-step example:

## Secrets Example
Let's say I wanted to create a new secret to hold my Github SSH key.

I would `cd` into my [`nix-secrets`](https://github.com/abstracts33d/nix-secrets-example) repo directory, verify the `agenix` configuration (named `secrets.nix`) exists, then run
```
EDITOR=vim nix run github:ryantm/agenix -- -e github-ssh-key.age
```

This would start a `vim` session.

I would enter insert mode `:i`, copy+paste the key, hit Esc and then type `:w` to save it, resulting in the creation of a new file, `github-ssh-key.age`.

Then, I would edit `secrets.nix` to include a line specifying the public key to use for my new secret. I specify a user key, but I could just as easily specify a host key.

**secrets.nix**
```nix
let
  s33d = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL0idNvgGiucWgup/mP78zyC23uFjYq0evcWdjGQUaBH";
  users = [ s33d ];
  systems = [ ];
in
{
  "github-ssh-key.age".publicKeys = [ dustin ];
}
```

Finally, I'd commit all changes to the [`nix-secrets`](https://github.com/abstracts33d/nix-secrets-example) repository, go back to my `nixos-config` and run `nix flake update` to update the lock file.

The secret is now ready to use. Here's an [example](https://github.com/abstracts33d/nixos-config/blob/3b95252bc6facd7f61c6c68ceb1935481cb6b457/nixos/secrets.nix#L28) from my configuration. In the end, this creates a symlink to a decrypted file in the Nix Store that reflects my original file.
