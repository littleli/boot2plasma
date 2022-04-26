# boot2plasma

This piece was awarded 2nd price in in the 2020 contest, PC Booter category, dedicated to [The 20th anniversary of the first official release of fasm](https://contest.flatassembler.net/)

- [How to run?](#how-to-run)
- [DOSBox](#dosbox)
- [QEMU](#qemu)
- [VirtualBox](#virtualbox)
- [Interaction](#interaction)
- [Preview](#preview)

Boot to plasma is an assembler-only port of EXAMPLE1.C from PMODE/W examples. This port is using [fasmg](https://flatassembler.net/download.php), the next generation assembler authored by [@tgrysztar](https://github.com/tgrysztar)

## How to run?

First you need to download the latest version of `b2plasma.img` from the [release section](https://github.com/littleli/boot2plasma/releases)

Now you need to install environment which can boot the image.

These are options you have:


### DOSBox

Packages with DOSBox for specific OS can be found on the [website](https://www.dosbox.com/download.php?main=1). You have to use [BOOT](https://www.dosbox.com/wiki/BOOT) command. After you run DOSBox you have to mount filesystem with `b2plasma.img` file as a new drive.

Example series of commands from the inside DOSBox:
```sh
mount c ~/Downloads/b2plasma
c:
boot b2plasma.img
```

### QEMU

Download and installation instructions are [here](https://www.qemu.org/download).

Executing command like this should do the trick.
```sh
qemu-system-i386 b2image.img
```

### VirtualBox

Download and installation instructions are on VirtualBox [website](https://www.virtualbox.org).

I keep installation procedure of virtual box upon a user, just with few notes here:

- Use `Other/DOS` as system setup
- No need to setup hardrive space, boot `b2plasma.img` from a floppy drive. This makes the whole image only ~3KB in size

## Interaction

After the boot, press `ESC` key to rotate color palette among:
- red + green
- green + blue
- blue + red

## Preview

[https://vimeo.com/419123046](https://vimeo.com/419123046)
