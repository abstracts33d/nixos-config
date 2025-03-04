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
      - [5. Setup secrets](#5-setup-secrets)
      - [6. Install configuration](#6-install-configuration)
      - [7. Make changes](#7-make-changes)
    - [For NixOS](#for-nixos)
      - [1. Burn and use the latest ISO](#1-burn-and-use-the-latest-iso)
      - [2. Install configuration](#2-install-configuration)
      - [3. Set user password](#3-set-user-password)


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
sudo hostname your-target-hostname
mkdir -p nixos-config && cd nixos-config && nix flake --extra-experimental-features 'nix-command flakes' clone github:abstracts33d/nixos-config --dest .
```

### 4. Make [apps](https://github.com/abstracts33d/nixos-config/tree/main/apps) executable
```sh
find apps/$(uname -m | sed 's/arm64/aarch64/')-darwin -type f \( -name build -o -name build-switch -o -name create-keys -o -name copy-keys -o -name check-keys -o -name rollback \) -exec chmod +x {} \;
```

### 5. Setup secrets

#### 5a. Create a private Github repo to hold your secrets
In Github, create a private [`nix-secrets`](https://github.com/abstracts33d/nix-secrets-example) repository with at least one file (like a `README`). You'll enter this name during installation.

#### 5b. Install keys
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

### 6. Install configuration
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

### 7. Make changes
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

### 2. Install configuration

> [!IMPORTANT]
> For Nvidia cards, select the second option, `nomodeset`, when booting the installer, or you will see a blank screen.

> [!CAUTION]
> Running this will reformat your drive to the `ext4` filesystem.

```sh
sudo hostname your-target-hostname
sudo nix run --extra-experimental-features 'nix-command flakes' github:abstracts33d/nixos-config#install
```

### 3. Set user password
On first boot at the login screen:
- Use shortcut `Ctrl-Alt-F2` (or `Fn-Ctrl-Option-F2` if on a Mac) to move to a terminal session
- Login as `root` using the password created during installation
- Set the user password with `passwd <user>`
- Go back to the login screen: `Ctrl-Alt-F7`
