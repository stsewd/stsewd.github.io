---
title: Neovim, instalación y configuración básica
tags: neovim vim
---

En este post daré una pequeña introducción a Neovim, un editor de texto muy
diferente a los que estás acostumbrado a usar. Además detallaré paso a paso las
instrucciones para su instalación en Fedora y Ubuntu; y cómo configurarlo.

{% include image.html
  alt="logo de neovim"
  url="/assets/img/nvim/neovim-logo.png" 
  href="http://neovim.io"
  caption="Logo de Neovim"
%}

## ¿Qué es Neovim?

[Neovim](https://neovim.io/charter/) es una refactorización del código de
[Vim](http://www.vim.org/), trata de ser un super-conjunto de este, llevando lo
bueno de Vim y dando una mejor experiencia _fuera de la caja_ al usuario.

**¿Entonces qué es Vim?** Vim es un editor de texto basado en modos (un lugar
para escribir, otro para insertar comandos, y así). Nació como mejora de Vi
(1976).  Su interfaz no es gráfica, sino basada en texto (aunque existen varias
implementaciones con interfaz gráfica, como gVim). Una característica muy
importante es que puede ser controlado totalmente con el **teclado**.

## Neovim vs Vim

Así que Neovim es un super-conjunto de Vim, e intenta dar una mejor experiencia
al usuario. ¿Qué realmente ofrece Neovim frente a Vim, además de tener un
código más limpio?

- Neovim viene con algunas configuraciones por defecto, que hacen que puedas
  usarlo de manera inmediata. [^1] [^2]
- Incluye un emulador de terminal.
- Mejor integración con características de terminales modernos (estilo del
  cursor, _truecolor_).
- Una mejor API que permite la comunicación con Neovim desde cualquier lenguaje
  de programación (de manera segura y asíncrona).

[^1]: <https://github.com/neovim/neovim/issues/2676>
[^2]: <https://github.com/neovim/neovim/issues/6289>

## ¿Por qué usar Neovim?

## Instalación

Para la instalación de Neovim he usado dos máquinas virtuales (Fedora y
Ubuntu), cada una con una instalación _limpia_. La versión de Ubuntu es
16.04.02, y la de Fedora es 25.1.3.

Si usas otra distro que no sea Ubuntu ni Fedora o usas Windows, puedes seguir
el proceso de instalación en la [documentación oficial de
Neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim).


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

## Comprobando la instalación

Para comprobar que todo ha salido bien, iniciamos Neovim. En la terminal ejecutamos el comando `nvim`.

```sh
nvim
```

Y podremos ver la pantalla de bienvenida de Neovim.

{% include image.html
  alt="Neovim en Ubuntu"
  url="/assets/img/nvim/neovim-ubuntu.jpg" 
  caption="Neovim en Ubuntu"
  normal=true
%}

{% include image.html
  alt="Neovim en Fedora"
  url="/assets/img/nvim/neovim-fedora.png" 
  caption="Neovim en Fedora"
  normal=true
%}

**Nota:** Tal vez ahora mismo nuestro editor no luzca tan _moderno_ ni con un
gran diseño, pero al finalizar este tutorial tendrás un editor sin nada que
envidiar al resto.

{% include image.html
  alt="Mi Neovim"
  url="/assets/img/nvim/my-neovim.png" 
  caption="Mi Neovim ahora"
  normal=true
%}

### Advertencia

> Si no estás familiarizado con Vim, te recomiendo que antes de seguir te
> acostumbres con lo básico de Vim/Neovim, para ello puedes seguir un tutorial
> interactivo que viene incluido en Neovim, teclea dos puntos en Neovim (`:`), en
> la parte inferior estará el cursor esperando a que ingreses un comando; escribe
> `Tutor` (con la `T` mayúscula), y luego presiona la tecla Enter. Se abrirá un
> tutorial interactivo, te recomiendo que al menos leas la lección número 1 o hasta que te
> sientas familiarizado con lo básico (moverte en un archivo; abrir y escribir un
> archivo; y salir de Neovim).

Si deseas aprender más sobre Vim/Neovim, al final de este post dejaré algunos
recursos para hacerlo.

## Dependencias adicionales

> A este punto, espero que ya estés familiarizado con lo básico de Neovim (leer
> nota de arriba).

Acabamos de instalar Neovim, pero aún nos falta instalar algunas dependencias
(opcionales) para sacarle más provecho a Neovim y no tener ningún problema al
instalar plugins.
## Configuración

<!-- Mostrar un init.vim minimal -->

## Alternativas

<!-- mencionar otros editores e ides con modo vim (atom, idea, etc) -->

## Recursos adicionales

<!-- links de lugares donde aprender más, mis dotfiles, etc -->
