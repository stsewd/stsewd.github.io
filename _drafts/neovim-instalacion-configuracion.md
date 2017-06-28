---
title: Neovim, instalación y configuración básica
tags: neovim vim
---

En este post daré una pequeña introducción a Neovim, un editor de texto muy
diferente a los que estás acostumbrado a usar. Además detallaré paso a paso las
instrucciones para su instalación en Fedora y Ubuntu; y cómo configurarlo.

{% assign sudo_msg = '<span class="glyphicon glyphicon-alert"></span> Puede que necesites ejecutar estos comandos anteponiendo <strong>sudo</strong>.' %}

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
implementaciones con interfaz gráfica, como gVim).

## Neovim vs Vim

Así que Neovim es un reemplazo de Vim con una mejor experiencia para el
usuario, pero ¿qué realmente ofrece Neovim frente a Vim, además de tener un
código más limpio?

- Trae algunas configuraciones por defecto, que hacen que puedas usarlo de
  manera inmediata. [^1] [^2]
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

Antes de describir las ventajas de usar Neovim, debo aclarar que las mismas
**son válidas para Vim**, ya que es un reemplazo directo de Vim. Si eres
usuario de Vim, te recomiendo que pruebes Neovim.

Puedes **controlar todo con el teclado** a través de comandos, puede parecer un
poco complicado recordarlos (y al principio lo es), pero con práctica podrás
hacerlo de manera casi natural. Y no tires tu mouse, aún puedes usarlo para un
par de cosas en Neovim.

Te facilita la edición de texto, permitiéndote **automatizar tareas
repetitivas**, y las tareas tediosas las puedes lograr con un par de teclas.
Con el tiempo, sentirás que el **teclado es una extension más de tus manos**.

Es **altamente configurable**, es como si construyeras tu propio editor,
al final tendrás un editor **hecho a tu medida** que cubre tus necesidades
específicas.

Además te permite expandir su comportamiento a través de **plugins**, si
usas Vim, aún **puedes seguir usando los mismos plugins de Vim**, más los que
la comunidad ha desarrollado para Neovim. Y si te animas, puedes **crear tu
propio plugin** en tu lenguaje favorito (hace poco hice mi [primer
plugin](https://github.com/stsewd/open-plugin-page.nvim) en python), gracias a
la API que provee Neovim.

Y por último, trae **las mismas características que cualquier otro editor de
código**, como: auto completado, corrector ortográfico, pestañas (buffers en
Neovim), coloreado de sintaxis, búsqueda y reemplazo con expresiones regulares,
etc.

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

**Nota:** Tal vez ahora mismo nuestro editor luzca aburrido, nada _moderno_ ni
con un gran diseño, pero al finalizar esta serie de tutoriales tendrás un
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

## Instalando dependencias adicionales

Acabamos de instalar Neovim, pero aún nos falta instalar algunas dependencias
(opcionales) para sacarle más provecho a Neovim y no tener ningún problema al
instalar plugins.

### Proveedor de porta-papeles

Para que Neovim pueda copiar o pegar desde el porta-papeles de nuestro sistema,
necesitamos instalar un _proveedor_.

Tenemos dos alternativas `xclip` y `xsel`, ambas muy buenas. A continuación
tienes los comandos para instalar alguna de ellas.

#### Ubuntu

```sh
sudo apt install xclip
```

```sh
sudo apt install xsel
```

#### Fedora

```sh
sudo dnf install xclip
```

```sh
sudo dnf install xsel
```

### Interfaces de Python

Algunos plugins hacen uso de la [interfaz de
python](https://github.com/neovim/python-client) que Neovim provee.

Vamos a instalarlas para las dos versiones de Python (2 y 3), aunque todos los
plugins que instalemos usen Python 3.

### Ubuntu

Ubuntu ya incluye ambas versiones de Python, pero antes de instalar las
interfaces de Python, debemos instalar `pip` (una herramienta que nos ayuda a
descargar librerías de Python). Para ello ejecutamos los siguientes comandos:

```sh
sudo apt install python3-pip
```

```sh
sudo apt install python-pip
```

Ahora ya podemos instalar las interfaces de Neovim.

{% include alert.html
  type="warning"
  text=sudo_msg
%}

```sh
python3 -m pip install neovim
```

```sh
python -m pip install neovim
```

### Fedora

Las versiones actuales de Fedora sólo incluyen Python 3, así que debemos
instalar Python 2 (es opcional, como dije antes, todo lo que usemos será con
Python 3).

```sh
sudo dnf install python
```

Ahora ya podemos instalar las interfaces de Neovim, aunque puede Fedora ya lo
haya hecho cuando instalaste Neovim (actualizar con los comandos de la
siguiente sección si es el caso).

{% include alert.html
  type="warning"
  text=sudo_msg
%}

```sh
python3 -m pip install neovim
```

```sh
python -m pip install neovim
```

### Manteniendo las interfaces de Python al día

Es recomendable que cada cierto tiempo actualices las interfaces de Python, así
estarás al día con lo último que Neovim ofrece a través de su API.

{% include alert.html
  type="warning"
  text=sudo_msg
%}

```sh
python3 -m pip install --upgrade neovim
```

```sh
python -m pip install --upgrade neovim
```

### Interfaces de Ruby

Al igual que algunos plugins hacen uso de la interfaz de Python, otros usan la
interfaz de [Ruby](https://rubygems.org/gems/neovim/).

#### Ubuntu

Ubuntu no trae Ruby por defecto, así que tendremos que instalarlo con los
siguientes comandos.

```sh
sudo apt install ruby
sudo apt install ruby-dev
```

Ahora si podemos instalar la interfaz de Ruby.

{% include alert.html
  type="warning"
  text=sudo_msg
%}

```
gem install neovim
```

#### Fedora

Fedora no trae Ruby por defecto, así que tendremos que instalarlo con los
siguientes comandos.

```sh
sudo dnf install ruby
sudo dnf install ruby-devel
sudo dnf install gcc-c++
sudo dnf install redhat-rpm-config
```

Ahora si podemos instalar la interfaz de Ruby.

{% include alert.html
  type="warning"
  text=sudo_msg
%}

```
gem install neovim
```

## Comprobando las dependencias adicionales

<!-- Correr CheckHealth -->

## Primeros pasos con Neovim

- Abrir un archivo
- Guardar
- Salir
- Moverse por el archivo
- Modo normal e insertar
- Copiar
- Pegar
- Cortar
- Deshacer y rehacer
- Modo visual
- Buscar
- Ayuda

## Configuración básica

- Configuraciones desde el exmode
- Crear un archivo `init.vim`
- Poner un par de configuraciones
- Source so % para recargar las configuraciones
- Más configuraciones
- Cambiar de tema

## Alternativas

<!-- mencionar otros editores e ides con modo vim (atom, idea, etc) -->

## Recursos adicionales

¿Interesado en aprender más?

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

### Artículos

- [Moving to Neovim from Vim](https://jacky.wtf/weblog/moving-to-neovim/)

### Dotfiles

Los dotfiles no son más que archivos de configuración (que usualmente empiezan
con un `.`, de ahí su nombre). En varios dotfiles podrás encontrar
configuraciones para Vim/Neovim que podrían serte útiles.

- [Dotfiles en GitHub](https://github.com/search?utf8=%E2%9C%93&q=dotfiles&type=)
- [Mis dotfiles](https://github.com/stsewd/dotfiles)

<!-- links de lugares donde aprender más, mis dotfiles, etc -->

---
