#!/usr/bin/env bash
#

function TiempoInicio {
	tinicio=`date +%s`
}

function TiempoFin {
	tfin=`date +%s`
	(( total = $tfin - $tinicio ))
	(( dias = $total / ( 24 * 60 * 60) ))
	(( rdias = $total % ( 24 * 60 * 60) ))
	(( horas = $rdias / ( 60 * 60) ))
	(( rhoras = $rdias % ( 60 * 60) ))
	(( minutos = $rhoras / 60 ))
	(( rminutos = $rhoras % 60 ))
	if (( $dias != 0 ))
	then
		demora="$dias días,"
	fi
	if (( $horas != 0 ))
	then
		demora+=" $horas horas,"
	fi
	if (( $minutos != 0 ))
	then
		demora+=" $minutos minutos y"
	fi
	
	echo "Ha tardado: $demora $rminutos segundos"
	echo
}

function VerificarFedora {
  if [ "`uname -r | grep .fc3.. | wc -l`" = 0 ] # Compruebo si el SO es Fedora 3x
  then
    echo "Este Script es para aprovisionar una maquina Fedora, y debe correr sobre Fedora 3x"
    echo
    exit 1
  fi
}

function VerificarRoot {
  if [ "`id -u`"  != 0 ] # Compruebo si soy root 
  then
    echo "`whoami`: Tienes que ser root para actualizar el kernel"
    echo
    exit 2
  fi
}

function ExtraRepo{

clear

echo "Actualizando sistema y instalndo repos basicos"
sleep 3

dnf clean all

dnf update -y

dnf autoremove -y

dnf -y install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

}

# Instalando Google repo y google-chrome-stable

function RepoChrome{

clear

cd /etc/yum.repos.d/

echo '[google-chrome]' > google-chrome.repo
echo 'name=google-chrome' >> google-chrome.repo
echo 'baseurl=http://dl.google.com/linux/chrome/rpm/stable/x86_64' >> google-chrome.repo
echo 'enabled=1' >> google-chrome.repo
echo 'gpgcheck=1' >> google-chrome.repo
echo 'gpgkey=https://dl.google.com/linux/linux_signing_key.pub' >> google-chrome.repo

cd /tmp

}

# Instalando flatpak y Repo Flathub

function RepoFlatpak{

clear

echo "Instalando APPS Flatpak"

sleep 3

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

}

#DOCKER
function RepoDocker{

clear

echo "Instalando Docker"
sleep 3

dnf remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-selinux docker-engine-selinux docker-engine -y

dnf -y install dnf-plugins-core

dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo

}

#APPS

function InstalarApps{

clear

echo "Instalando APPS"

sleep 3

dnf install libwebp webp-pixbuf-loader libopenraw libopenraw-pixbuf-loader unrar libunrar p7zip p7zip-plugins gstreamer1-plugin-openh264 h264enc mozilla-openh264 openh264 x264 x264-libs libde265 x265 x265-libs gstreamer1 gstreamer1-libav gstreamer1-plugin-openh264 gstreamer1-plugins-bad-free gstreamer1-plugins-bad-free-extras gstreamer1-plugins-bad-free-fluidsynth gstreamer1-plugins-bad-free-wildmidi gstreamer1-plugins-bad-free-zbar gstreamer1-plugins-bad-freeworld gstreamer1-plugins-base gstreamer1-plugins-good gstreamer1-plugins-good-extras gstreamer1-plugins-good-gtk gstreamer1-plugins-good-qt gstreamer1-plugins-ugly gstreamer1-plugins-ugly-free gstreamer1-vaapi gstreamer1-svt-av1 svt-av1 svt-av1-libs gstreamer1-svt-vp9 rav1e rav1e-libs dav1d libdav1d libva libva-utils vlc redhat-lsb-core kernel-devel gnome-tweaks gnome-extensions-app eclipse-jdt grub-customizer rpmfusion-free-appstream-data rpmfusion-nonfree-appstream-data -y

#Instalar chrome

dnf install google-chrome-stable -y

# Instalar Discord
flatpak install discord spotify -y

# Instalar spotify

flatpak install spotify -y

#Instalar Docker

dnf install docker-ce docker-ce-cli containerd.io docker-compose -y

groupadd docker

#Indicar nombre usuario

read -p "¿Cual es el nombre de tu usuario personal" usuario

usermod -aG docker $usuario

$usuario=''

#Limpiamos dependencias

dnf autoremove -y
}

function ArrancaServicio{

systemctl start libvirtd

systemctl enable libvirtd

systemctl enable --now docker

}

# Aplicar cambios
function Reiniciar {
  read -p "¿Quieres reiniciar el sistema? [s/N]: " respuesta
  if [ ! -z $respuesta ]
  then
    if [ $respuesta == "s" ] || [ $respuesta == "S" ]
    then 
      echo "---------------------------"
      echo "    Rebotaaaaaaandooo...   "
      echo "---------------------------"
      sleep 1
      init 6
    fi
  fi 
  echo
}

############ Fin de la Seccion de funciones ########################################

############# Programa Principal ###################################################
TiempoInicio
clear
VerificarFedora 
VerificarRoot
echo "--------------------------------------------------------------------------"
echo "ufi.sh -> Aprovisionador de maquinas Fedora's"
echo "--------------------------------------------------------------------------"
echo
ExtraRepo
RepoChrome
RepoFlatpak
RepoDocker
InstalarApps
ArrancaServicio
TiempoFin
Reiniciar
############# Fin del Programa Principal ###########################################
