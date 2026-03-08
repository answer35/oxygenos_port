#!/bin/bash
# port requirements

if [ "$(id -u)" != "0" ] && [ "$(uname -m)" == "x86_64" ]  && [  "$(uname)" == "Linux" ];then
    echo "请以 root 用户运行"
    echo "please run with sudo"
    exit
fi

OS="$(uname)"
ARCH="$(uname -m)"

if [ "$OS" == "Linux" ]; then
    . /etc/os-release
fi

# Debian / Ubuntu
if [ "$OS" == "Linux" ] && [ "$ARCH" == "x86_64" ] && [[ "$ID" == "ubuntu" || "$ID" == "debian" ]]; then
    echo "Device arch: Linux x86_64 (Debian/Ubuntu)"
    apt update -y
    apt upgrade -y
    apt install -y aria2 python3 busybox zip unzip p7zip-full openjdk-21-jre zstd bc android-sdk-libsparse-utils xmlstarlet

    if [ $? -ne 0 ]; then
        echo "Installation may fail. Please perform manually:"
        echo "apt install -y aria2 python3 busybox zip unzip p7zip-full openjdk-21-jre zstd bc xmlstarlet"
    fi
fi

# Fedora
if [ "$OS" == "Linux" ] && [ "$ARCH" == "x86_64" ] && [ "$ID" == "fedora" ]; then
    echo "Device arch: Linux x86_64 (Fedora)"
    dnf upgrade -y
    dnf install -y aria2 python3 busybox zip unzip p7zip p7zip-plugins java-21-openjdk zstd bc android-tools xmlstarlet
fi

# aarch64 (Debian/Ubuntu)
if [ "$OS" == "Linux" ] && [ "$ARCH" == "aarch64" ] && [[ "$ID" == "ubuntu" || "$ID" == "debian" ]]; then
    echo "Device arch: Linux aarch64"
    apt update -y
    apt upgrade -y
    apt install -y python3 busybox zip unzip p7zip-full openjdk-21-jre zipalign zstd xmlstarlet
fi

if [ "$(uname)" == "Darwin" ] && [ "$(uname -m)" == "x86_64" ];then
    echo "Device arch: MacOS X86_X64"
    pip3 install buysbox
    brew install aria2 openjdk zstd coreutils gdu gnu-sed gnu-getopt grep xmlstarlet
fi
