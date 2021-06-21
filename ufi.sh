#!/usr/bin/env bash
#

read -p "¿Cual es el nombre tu usuario?" usuario


echo "Actualizando sistema y instalndo repos basicos"
sleep 3

dnf clean all

dnf update -y

dnf autoremove -y

dnf -y install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

#APPS
clear
echo "Instalando APPS"
sleep 3

dnf install libwebp webp-pixbuf-loader libopenraw libopenraw-pixbuf-loader unrar libunrar p7zip p7zip-plugins gstreamer1-plugin-openh264 h264enc mozilla-openh264 openh264 x264 x264-libs libde265 x265 x265-libs gstreamer1 gstreamer1-libav gstreamer1-plugin-openh264 gstreamer1-plugins-bad-free gstreamer1-plugins-bad-free-extras gstreamer1-plugins-bad-free-fluidsynth gstreamer1-plugins-bad-free-wildmidi gstreamer1-plugins-bad-free-zbar gstreamer1-plugins-bad-freeworld gstreamer1-plugins-base gstreamer1-plugins-good gstreamer1-plugins-good-extras gstreamer1-plugins-good-gtk gstreamer1-plugins-good-qt gstreamer1-plugins-ugly gstreamer1-plugins-ugly-free gstreamer1-vaapi gstreamer1-svt-av1 svt-av1 svt-av1-libs gstreamer1-svt-vp9 rav1e rav1e-libs dav1d libdav1d libva libva-utils vlc redhat-lsb-core kernel-devel gnome-tweaks gnome-extensions-app eclipse-jdt grub-customizer rpmfusion-free-appstream-data rpmfusion-nonfree-appstream-data -y

cd /tmp

wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm

dnf install ./google-chrome-stable_current_x86_64.rpm -y

dnf group install --with-optional virtualization -y

dnf -y install qemu-kvm libvirt libguestfs-tools virt-install rsync

systemctl start libvirtd

systemctl enable libvirtd

dnf autoremove -y

clear
echo "Instalando APPS Flatpak"
sleep 3

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install discord spotify -y

#DOCKER
clear
echo "Instalando Docker"
sleep 3

dnf remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-selinux docker-engine-selinux docker-engine -y

dnf -y install dnf-plugins-core

dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo

dnf install docker-ce docker-ce-cli containerd.io docker-compose -y

systemctl enable --now docker

groupadd docker

usermod -aG docker $usuario

$usuario=''

dnf autoremove -y

# Aplicar cambios
clear

echo "Reiniciando PC"

init 6