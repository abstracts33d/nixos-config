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
      - [2. Setup secrets](#2-setup-secrets)
      - [3. Install configuration](#3-install-configuration)
      - [4. Set user password](#4-set-user-password)
  - [Secrets](#secrets-managements)


## Disclaimer
Installing Nix on macOS will create an entirely separate volume. It may exceed many gigabytes in size.


> [!NOTE]
> Don't worry, you can always [uninstall](https://github.com/DeterminateSystems/nix-installer#uninstalling) Nix later.

## Layout
```
.
├── apps         # Nix commands used to bootstrap and build configuration
├── home         # Homemanager configuration
├── iso          # Live image with ssh key
├── lib          # Custom library
├── hosts        # Host-specific configuration
├── modules      # macOS and nix-darwin, NixOS, and shared configuration
├── overlays     # Drop an overlay file in this dir, and it runs. So far, mainly patches.
```

## Installing
## For macOS
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
find apps/$(uname -m | sed 's/arm64/aarch64/')-darwin -type f \( -name apply -o -name build -o -name build-switch -o -name create-keys -o -name copy-keys -o -name check-keys -o -name rollback \) -exec chmod +x {} \;
```

### 5. Setup secrets

#### Install keys
Before generating your first build, these keys must exist in your `~/.ssh` directory.

| Key Name            | Platform         | Description                                 |
|---------------------|------------------|---------------------------------------------|
| id_ed25519          | macOS / NixOS    | Github key with access to `nix-secrets` && Primary key for encrypting and decrypting secrets. |

> [!NOTE]
> Upon updating the nix-secrets repository you should update your secret flake input with
>
> ```sh
> nix flake update secrets
> ```

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

### 2. Setup secrets

#### Install keys
Before generating your first build, these keys must exist in your `~/.ssh` directory.

| Key Name            | Platform         | Description                                                                |
|---------------------|------------------|----------------------------------------------------------------------------|
| id_ed25519          | macOS / NixOS    | Github key with access to `nix-secrets`. Primary key for encrypting and decrypting secrets. Copied over to host |

### 3. Install configuration

> [!IMPORTANT]
> For Nvidia cards, select the second option, `nomodeset`, when booting the installer, or you will see a blank screen.

> [!CAUTION]
> Running this will reformat your drive.

```sh
# Upgrade nix
nix-env --install --file '<nixpkgs>' --attr nix cacert -I nixpkgs=channel:nixpkgs-unstable

# Install (-h HOST -u USERNAME -i for IMPERMANENCE)
sudo nix run --extra-experimental-features 'nix-command flakes' github:abstracts33d/nixos-config#install -- -h utm -u s33d -i
```

> [!NOTE]
> Activate the swap device
> ```sh
> swapon /dev/swap-partition
> ```
> Then remount the store to increase its size:
>
> ```sh
> mount -o remount,size=10G,noatime /nix/.rw-store
> ```

### 4. Set user password
On first boot at the login screen:
- Use shortcut `Ctrl-Alt-F2` (or `Fn-Ctrl-Option-F2` if on a Mac) to move to a terminal session
- Login as `root` using the password created during installation
- Set the user password with `passwd <user>`
- Go back to the login screen: `Ctrl-Alt-F7`

# Secrets managements

From inside secrets repository
```
EDITOR="cp binary_file_path" agenix -e outptut.age
EDITOR="nvim" agenix -e outptut.age
```

> [!NOTE]
> Upon updating the nix-secrets repository you should update your secret flake input with
>
> ```sh
> nix flake update secrets
> ```
