# the Electric Tantra ISO Creation Environment 
Here are the scripts you can use to build the Electric Tantra Linux's ISO file using an installation of `void-linux` and its associated package manager that leverages `dracut` to assemble the initramfs and pack all of the internals into a neat ISO file you can burn on a flash drive. 

This is based on the `cursed-mklive` project from `Cursed Linux` which while spartan in its documentation, is not dissimilar from the `void-mklive` package in that front while boasting an easier workflow and functionality than the upstream variant as it simplifies the build into two top level scripts and with a more focused set of internal files requiring modification initially that enabled a wider canvas to craft the Electric Tantra Linux upon. 

## Dependencies
 - **xbps**>=*0.45*

## Usage

**Type:**

   ```bash 
    $ sudo bash run.sh
```

## rootfs

An inherented idiosyncracity I liked and thus kept from the `Cursed Linux` team was the included directory being called `rootfs`, which is a label better describing the directory's content to those not versed in the spartan documentation for `void-mklive` presently available. In essence, this folder contains a targeted selection of my dotfiles, modified for their employment in the context of the Live Environment, in the subdirectory `rootfs/etc/skel` which is used to populate the `anon` user's home directory. Due to this abstraction and the use of `anon` instead of my usual user name, including my dotfiles and associated repos as subdirectories ma 