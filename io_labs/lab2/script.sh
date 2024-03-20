#!/bin/bash

if [ "$(whoami)" != "root" ]; then
  sudo "$0" "$@"
  exit $?
fi

function prepare() {
    mkfs.ext4 /dev/vramdisk1
    mkfs.ext4 /dev/vramdisk5
    mkfs.ext4 /dev/vramdisk6
    
    mkdir /mnt/vramdisk1
    mkdir /mnt/vramdisk5
    mkdir /mnt/vramdisk6
    
    
    mount /dev/vramdisk1 /mnt/vramdisk1
    mount /dev/vramdisk5 /mnt/vramdisk5
    mount /dev/vramdisk6 /mnt/vramdisk6
}


function fill_virtual() {
    dd if=/dev/urandom of=/mnt/vramdisk1/file bs=1M count=5
    dd if=/dev/urandom of=/mnt/vramdisk5/file bs=1M count=5
    dd if=/dev/urandom of=/mnt/vramdisk6/file bs=1M count=5
}

function delete_files() {
    rm /mnt/vramdisk1/file
    rm /mnt/vramdisk5/file
    rm /mnt/vramdisk6/file
}

function copy_v_v() {
    fill_virtual
    echo "Copying files from virtual file to virtual file"
    pv /mnt/vramdisk1/file > /mnt/vramdisk5/file
    pv /mnt/vramdisk5/file > /mnt/vramdisk6/file
    pv /mnt/vramdisk6/file > /mnt/vramdisk1/file
    delete_files
}

function copy_v_r() {
    fill_virtual
    echo "Copying files from virtual file to real file"
    mkdir test
    pv /mnt/vramdisk1/file > test/1
    pv /mnt/vramdisk5/file > test/5
    pv /mnt/vramdisk6/file > test/6
    delete_files
}

function final() {
    umount /mnt/vramdisk1
    umount /mnt/vramdisk5
    umount /mnt/vramdisk6
    
    rmdir /mnt/vramdisk1
    rmdir /mnt/vramdisk5
    rmdir /mnt/vramdisk6
}

prepare
copy_v_v
copy_v_r
final

