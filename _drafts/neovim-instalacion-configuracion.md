---
title: Neovim, instalación y configuración
---

En este post daré una pequeña introducción a Neovim, un editor de texto muy
diferente a los que estás acostumbrado a usar, el cuál llevo usando alrededor
de un año. Además detallaré paso a paso las instrucciones para su instalación
en Fedora y Ubuntu; y cómo configurarlo.

{% include image.html
  alt="logo de neovim"
  url="/assets/img/nvim/neovim-logo.png" 
  href="http://neovim.io"
  caption="Logo de Neovim"
%}

## ¿Qué es Neovim?

<!-- Hacer un copy paste de la pagina oficial -->

## Neovim vs Vim

<!-- resaltas las mejoras con respecto a vim -->

## ¿Por qué usar Neovim?

## Instalación

<!-- hacer paro a paso para Ubuntu y fedora -->
Para la instalación de Neovim he usado dos máquinas virtuales (Fedora y
Ubuntu), cada una con una instalación _limpia_. La versión de Ubuntu es
16.04.02, y la de Fedora es 25.1.3.

Si usas otra distro que no sea Ubuntu ni Fedora o usas Windows, puedes seguir
el proceso de instalación en la [documentación oficial de
Neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim).

### Neovim

### Ubuntu

Primero debemos agregar la [PPA de
Neovim](https://launchpad.net/%7Eneovim-ppa/+archive/ubuntu/unstable) para así
poder instalar la última versión de Neovim. Ejecutamos el siguiente comando en
la terminal.

```sh
sudo add-apt-repository ppa:neovim-ppa/unstable
```

Luego, debemos actualizar los paquetes y procedemos a instalar Neovim.

```sh
sudo apt-get update
sudo apt-get install neovim
```

### Fedora

Para instalar la última versión de Neovim en Fedora, debemos ejecutar el
siguiente comando.

```sh
sudo dnf install neovim
```

## Configuración

<!-- Mostrar un init.vim minimal -->

## Alternativas

<!-- mencionar otros editores e ides con modo vim (atom, idea, etc) -->

## Recursos adicionales

<!-- links de lugares donde aprender más, mis dotfiles, etc -->
