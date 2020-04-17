# boot2plasma

This program is put together using [fasmg](https://flatassembler.net/download.php). It's Flat assembler with the new engine architecture and it's a very good assembler from [@tgrysztar](https://github.com/tgrysztar)

## How to run?

1. Download `b2plasma.img` from the release section
2. Install `qemu`
3. Run `qemu-system-i386 b2plasma.img`
4. Enjoy!

### QEMU installation

#### Linux
Depending on you distribution just use the distribution package manager. On Debian or Ubuntu use:
```sh
apt-get install qemu
```

### MacOS
Install `brew` from [Homebrew](https://brew.sh) and use this command:
```sh
brew install qemu
```

### Windows
Install `scoop` from [scoop package manager](https://scoop.sh)
```sh
scoop install qemu
```

## Alternative execution

There are two decent alternatives to mention here:

1. Dosbox
2. Oracle Virtual Box

### Dosbox

Dosbox has BOOT command. After you run Dosbox you have to mount filesystem with `b2plasma.img` file as a new drive.

Example series of commands in Dosbox:

```sh
mount c ~/Downloads/b2plasma
c:
boot b2plasma.img
```

### Oracle Virtual Box

I keep installation procedure of virtual box upon a user, just with few notes here:

- Use `Other/DOS` as system setup
- No need to setup hardrive space, boot `b2plasma.img` from a floppy drive. This makes the whole image only ~3KB in size
