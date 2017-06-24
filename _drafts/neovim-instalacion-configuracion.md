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
- Incluye un emulador de terminal. [^3]
- Mejor integración con características de terminales modernos (estilo del
  cursor, _truecolor_).
- Una API que permite la comunicación con Neovim desde cualquier lenguaje de
  programación (de manera segura y asíncrona). [^4]
- Mejor integración con el mouse.

[^1]: <https://github.com/neovim/neovim/issues/2676>
[^2]: <https://github.com/neovim/neovim/issues/6289>
[^3]: <https://neovim.io/doc/user/nvim_terminal_emulator.html>
[^4]: <https://neovim.io/doc/user/api.html>

## ¿Por qué usar Neovim?

Antes de describir las ventajas de usar Neovim, tengo que aclarar que las
mismas **son válidas para Vim**, ya que Neovim es un reemplazo directo de Vim,
así que si ya eres un usuario de Vim, te recomiendo que pruebes Neovim.

En Neovim puedes **controlar todo con el teclado** a través de comandos, puede
sonar un poco complicado tratar de recordar un montón de comandos (y al
principio lo es), pero con práctica podrás recordarlos de manera casi natural.
Y no tires tu mouse, aún puedes usarlo para un par de cosas en Neovim.

Neovim te facilita la edición de texto, permitiéndote **automatizar tareas
repetitivas**, y varias tareas tediosas las puedes lograr con un par de teclas.
Con el tiempo, sentirás que el **teclado es una extension más de tus manos**.

Neovim es **altamente configurable**, es como si construyeras tu propio editor,
al final tendrás un editor de texto **hecho a tu medida** que cubre tus
necesidades específicas.

Además Neovim te permite expandir su comportamiento a través de **plugins**, si
usas Vim, aún **puedes seguir usando los mismos plugins de Vim**, más los que
la comunidad ha desarrollado para Neovim. Y si te animas puedes **crear tu
propio plugin** en tu lenguaje favorito (hace poco hice mi [primer
plugin](https://github.com/stsewd/open-plugin-page.nvim) en python), gracias a
la API que provee Neovim.

Y por último, Neovim trae **las mismas características que cualquier otro
editor de código**, como: auto completado, corrector ortográfico, pestañas
(buffers en Neovim), coloreado de sintaxis, búsqueda y reemplazo con
expresiones regulares, etc.

Con todas las características mencionadas Neovim será _el único editor_ que
necesites para programar en cualquier lenguaje, o editar texto en general.

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

**Nota:** Tal vez ahora mismo nuestro editor luzca aburrido y no tan _moderno_
ni con un gran diseño, pero al finalizar esta serie de tutoriales tendrás un
editor sin nada que envidiar al resto.

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

### Tutoriales online

- [Learn vim progressively](http://yannesposito.com/Scratch/en/blog/Learn-Vim-Progressively/)
- [Vim Tips & Tricks](https://bluz71.github.io/2017/05/15/vim-tips-tricks.html)
- [Graphical vi-vim Cheat Sheet and Tutorial](http://www.viemu.com/a_vi_vim_graphical_cheat_sheet_tutorial.html)
- [Learn X in Y minutes](https://learnxinyminutes.com/docs/vim/)

### Vídeos

- [Vim casts](http://vimcasts.org/)
- [Vim meetups](https://www.youtube.com/watch?v=XA2WjJbmmoM&list=PL8tzorAO7s0jy7DQ3Q0FwF3BnXGQnDirs)

### Libros

- [Vim for humans](https://vimebook.com/)
- [Vim Galore](https://github.com/mhinz/vim-galore)

### Vídeo juegos

- [Vim adventures](https://vim-adventures.com/)

<!-- links de lugares donde aprender más, mis dotfiles, etc -->

---
