# ufi (Ultimate Fedora Installer)
Script para aprovisionar maquinas con S.O. Fedora (Codecs, Repos externos, Docker, QEMU y otras utilidades)

### Prerrequisitos

- Tener un S.O. Fedora ( fc34 en adelante )
- `curl` o `wget` debería estar instalados
- `git` debería estar instalado ( v2.4.11 en adelante)

### Instalación

UFI se instala ejecutando uno de los siguientes comandos en su terminal. Puede instalarlo a través de la línea de comandos con `curl`,` wget` u otra herramienta similar.

| Method    | Command                                                                                           |
|:----------|:--------------------------------------------------------------------------------------------------|
| **curl**  | `sh -c "$(curl -fsSL https://raw.githubusercontent.com/MrTech0/ufi/main/ufi.sh)"` |
| **wget**  | `sh -c "$(wget -O- https://raw.githubusercontent.com/MrTech0/ufi/main/ufi.sh)"`   |
| **fetch** | `sh -c "$(fetch -o - https://raw.githubusercontent.com/MrTech0/ufi/main/ufi.sh)"` |