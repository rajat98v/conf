# Update the system clock
timedatectl set-ntp ture

- to check the service status use
timedatectl status

# Partition the disk
cfdisk

make 3 partition
1. /dev/sda1 : 300M ; EFI System
2. /dev/sda2 : 4G   ; Linux Swap
3. /dev/sda3 : rest ; Linux root (x86-64)

# Mount the file system
mount /dev/root_partition /mnt
mount /dev/efi_system_partion /mnt/boot
swapon /dev/swap_partition

# Install essential packages
- Use pacstrap script to install.
pacstrap /mnt base linux linux-firmware

# Config the system

genfstab -U /mnt >> /mnt/etc/fstab

# Chroot
get inside the newly installed system as root
arch-chroot /mnt

# Setup time zone
ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime

hwclock --systohc

# Localization
- edit /etc/locale.gen and uncomment `en_US.UTF-8 UTF-8`
nvim /etc/locale.gen
- generate the locale by running
local-gen
- create the locale.conf file and set the lang variable accordingly
```
nvim /etc/locale.conf
------
LANG=en_US.UTF-8
```
# setup your root password
passwd

# Set the hostname file
## Create hostname file and your hostname to it
nvim /etc/hostname
`rajatv-host-pc`

## create a hosts file
nvim /etc/hosts
```
127.0.0.1	localhost
::1		localhost
127.0.1.1	rajatv-host-pc
```

## To enable network don't forget to install dhcpcd and enable it
pacman -S dhcpcd
systemctl enable dhcpcd


pacman -S grub efibootmgr

mkdir /boot/efi
mount /dev/sda1 /boot/efi
grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi
grub-mkconfig -o /boot/grub/grub.cfg


## Install xorg
pacman -S xf86-video-intel xorg-server xorg-apps xorg-xini xterm xorg-fonts-100dpi xor-fonts-75dpi autorandr

## Install Xmonad Window manager

sudo pacman -S xmonad xmonad-contrib

- Create ~/.xinitrc
- Add line `exec xmonad` to xinitrc

xmonad --recomile
xmonad --restart

## Install touchpad driver
pacman -S xf86-input-synaptics synaptics

- copy the default config file
cp /usr/share/X11/xorg.conf.d/70-synaptics.conf /etc/X11/xorg.conf.d/
- change ownership of file from root to current user
sudo chown rajatv 70-synaptics.conf


## Install sudo
pacman -S sudo

## Add a new user account
useradd --create-home rajatv
passwd rajatv

## Add user to the wheel group
usermod --append --groups wheel rajatv

## Edit Sudoers Filecdoo
As root user
nvim /etc/sudoers

- Uncomment to line with `%wheel ALL=(ALL) ALL`

## Switch to new user

su - rajatv
whoami

## Install yay package manager for aur
cd /opt
sudo git clone https://aur.archlinux.org/yay-git.git
sudo chown -R rajatv:rajatv ./yay-git
cd yay-git
makepkg -si

## Install Sound
sudo pacman -S pulseaudio
yay -S pamix-git

[pamix github](https://github.com/patroclos/PAmix)

# Brightness of screen
- Get the name of the output screen
xrandr --output
- outputname : eDPI1
- To change the brightness
xrandr --output eDPI1 --brightness 0.8

# Install terminal
sudo pacman -S alacritty

# Install Rofi
sudo pacman -S rofi
# Install torbrowser
sudo pacman -S torbrowser-launcher

# zsh
sudo pacman -S zsh
- directory history
- directory complete
- autocomplete
- find

# Notification manager
sudo pacman -S libnotify
yay -S deadd-notification-center

# Install rust

cd ~/git
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -o rust.sh
chmod +x ./rust.sh
./rust.sh

RUSHUP_HOME => ~/.rustup
CARGO_HOME => ~/.cargo

cargo, rustc, rustup => added at ~/.cargo/bin

This path will then be added to your PATH environment variable by
modifying the profile files located at:
setup will add `. "$HOME/.cargo/env"` to 
  /home/rajatv/.profile
  /home/rajatv/.bash_profile
  /home/rajatv/.bashrc
  /home/rajatv/.zshenv

To uninstall -> rustup self uninstall


# Mount External Hard Drive
- find out hardrive name
fdisk -l 
- create /mnt/disk
sudo mkdir /mnt/disk
- mount the drive
sudo mount -t ntfs3 /dev/sdc1 /mnt/disk
- open drive
cd /mnt/disk

# Gives the size of all mounted device
df: disk free
-h : Human redable
T : type of partiiton - ext4, ntfs

# File Permission & Ownership
ls -l
-rw-r--r-- 1 root root 1350 Dec 21 01:27 filename
-|rw-|r--|r-- 1 root root

File Type | User Permission | Group Permission |Others Permission|Number of Hardlinks to file | File Owner | File Group | File Size | DateTime | File Name

[Website](https://www.pluralsight.com/blog/it-ops/linux-file-permissions)

## Change Permission - chmod : change mode
u : current user
g: current user's group
o: not current user's group
a: All

- chmod ugo+rwx foldername to give read, write, and execute to everyone.
- chmod a=r foldername to give only read permission for everyone.

## Change Ownership - chown : change ownership

to change the ownership of file or folder
- chown name filename/foldername
- chown name:name filename/foldername
where name = group or user 
where name:name = group and user

recursively change username for directory
- chown -R name:name foldername

# Nvim
- Install xclip to get "+y working

# Command line utility

Fastest string search rust
[Ripgrep](https://github.com/BurntSushi/ripgrep)

Fuzzy file finder
[fzf](https://github.com/junegunn/fzf)
sudo pacman -S fzf
go

Multiplexer
[zellij](https://github.com/zellij-org/zellij)


Navi: cheetsheet commandline
[navi](https://github.com/denisidoro/navi#installation)
cargo install --locked navi


[mcfly](https://github.com/cantino/mcfly)

pacman -S atuin

Use direnv

# Setdesktop
## Keymapping

xmodmap ~/.Xmodmap
exec xmonad at last of .xinitrc
## Interception tools
sudo pacman -S interception-dual-function-keys
- if dir is not present make it
mkdir /etc/interception/dual-function-keys
- sudo -E nvim mykey.yaml
```yaml
TIMING:
    TAP_MILLISEC: 200
    DOUBLE_TAP_MILLISEC: 150

MAPPINGS:
    - KEY: KEY_ENTER
      TAP: KEY_ENTER
      HOLD: KEY_RIGHTCTRL
    - KEY: KEY_CAPSLOCK
      TAP: KEY_ESC
      HOLD: KEY_LEFTCTRL
```
- create file to create demon service which will execute the job before you login
sudo -E nvim /etc/interception/udevmon.d/my-keybo.yaml
```yaml
- JOB: "intercept -g /dev/input/by-id/usb-Gaming_KB_Gaming_KB-event-kbd | dual-function-keys -c /etc/interception/dual-function-keys/mykey.yaml | uinput -d /dev/input/by-id/usb-Gaming_KB_Gaming_KB-event-kbd"
  DEVICE:
    NAME: "Gaming KB  Gaming KB "
```
- Find right device one keyboard have normal keys other have media keys etc.
- Get the name of keyboard accurately by using below commands.
sudo uinput -p -d /dev/input/by-id/X
sudo uinput -p -d /dev/input/by-id/usb-Gaming_KB_Gaming_KB-event-kbd

### For more configuration see [dual-function-key](https://gitlab.com/interception/linux/plugins/dual-function-keys)


# Set neovim nvim




## Bash tutorial

- Run command together one-by-one use &&.

https://github.com/denisidoro/navi
https://github.com/jeffreytse/zsh-vi-mode
https://github.com/ellie/atuin
https://github.com/ajeetdsouza/zoxide
https://github.com/direnv/direnv
https://github.com/holman/boom
https://github.com/junegunn/fzf#reloading-the-candidate-list
https://github.com/santinic/how2
https://github.com/curusarn/resh
https://github.com/nvbn/thefuck
https://github.com/raylee/tldr-sh-client
https://github.com/Xfennec/progress
https://github.com/dim-an/cod
https://github.com/andys8/git-brunch
https://github.com/TaKO8Ki/awesome-alternatives-in-rust
https://awesomeopensource.com/projects/zsh-plugin
https://github.com/unixorn/awesome-zsh-plugins
https://safjan.com/top-popular-zsh-plugins-on-github/
https://github.com/sobolevn/git-secret
https://github.com/zsh-users/zsh-history-substring-search
https://github.com/larkery/zsh-histdb
https://github.com/zsh-users/zsh-autosuggestions
https://github.com/lukechilds/zsh-nvm
https://github.com/rossmacarthur/sheldon
https://github.com/arcticicestudio/nord-alacritty
https://github.com/simonmichael/hledger

# Config ToDo
- go up in terminal with keyboard vim keybinding and select with vim keybinding to like wincent
- auto update archlinux notification etc.
- auto fastest mirror setup
- xmonad Add name to top of window while in tab mod
