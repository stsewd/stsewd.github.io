---
title: Neovim, instalación de plugins
tags: neovim vim plugins
intro: >
  En este post mostraré cómo instalar y administrar plugins en Neovim, además
  una lista de plugins esenciales.
---

{% include image.html
  alt="logo de neovim"
  url="/assets/img/nvim/neovim-logo.png" 
  href="http://neovim.io"
  caption="Logo de Neovim"
%}

## Plugins

Los plugins de Vim/Neovim no son más que archivos `.vim`
(vimscript[^vimscript]) o al menos la mayoría, ya que Neovim nos permite
escribir plugins en cualquier lenguaje (plugins remotos[^remote-plugins]).

Los plugins permiten extender la funcionalidad de nuestro editor, integrarlo
con herramientas externas, darle color (temas), o hasta proveer _mappings_ que
nos facilitan realizar ciertas acciones.

[^vimscript]: <https://en.wikipedia.org/wiki/Vim_(text_editor)#Vim_script>
[^remote-plugins]: <https://neovim.io/doc/user/remote_plugin.html>

## Administrador de plugins

Los archivos que conforman un plugin deben estar en directorios específicos
para que este funcione. En los primeros inicios de Vim, bastaba con copiar y
pegar estos archivos en cada directorio (lo cual se puede seguir haciendo en
Neovim), pero conforme tu lista de plugins crece, se hace difícil mantener al
día todos los plugins.

Para solucionar este problema nacen los administradores de plugins, que se
encargan de mantener los plugins y sus dependencias al día con un par de
comandos y sin la necesidad de copiar cada archivo en cada directorio
correspondiente.

Los administradores de plugins más populares son:

- [pathogen](https://github.com/tpope/vim-pathogen)
- [Vundle](https://github.com/VundleVim/Vundle.vim)
- [dein](https://github.com/Shougo/dein.vim)
- [vim-plug](https://github.com/junegunn/vim-plug)

Todos a excepción de pathogen administran los plugins de manera similar,
pones los nombres de los plugins en tu `init.vim`, ejecutas un comando y estos
se descargan (usualmente desde GitHub) e instalan.

El administrador de plugins que usaré para el resto del post es
[vim-plug](https://github.com/junegunn/vim-plug), porque es el que menos
configuraciones requiere y se integra muy bien con Neovim. Tú puedes escoger el
que desees, los plugins pueden ser instalados con cualquier administrador de
plugins.

{% include alert.html
  type="info"
  text="Si quieres saber más sobre la estructura de directorios de los plugins
        de Vim/Neovim puedes leer <a
        href=\"https://gist.github.com/nelstrom/1056049/784e252c3de653e204e9e128653010e19fbd493f\">este
        gist</a>."
%}

## Instalando vim-plug

Ejecuta el siguiente comando de la terminal:

```sh
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

O si prefieres, descarga [este
archivo](https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim) y
guárdalo en `~/.local/share/nvim/site/autoload/plug.vim`.

Ahora abre tu `init.vim`.

```sh
nvim ~/.config/nvim/init.vim
```

Al inicio agrega lo siguiente:

```vim
" Especifíca el directorio para los plugins
call plug#begin('~/.local/share/nvim/plugged')

" Aquí iran los nombres de los plugins a instalar

call plug#end()

" Luego de esta línea puedes agregar tus configuraciones
" y mappings de Neovim
```

## Instalando plugins con vim-plug

Explicar vim-plug

## Cómo usar y configurar los plugins

## Plugins esenciales

Describir como se van a describir los plugins

### Temas

- one dark
- Neosolarized
- Documentación oficial de Neovim

### Barra de estado

- lightline
- airline

### Explorador de archivos

- nerdtree

### Auto completado

- deoplete

### Snippets

- utilsnippets

### Analizador estático de código

- neomake
- ale

### Resaltado de sintaxis

- General y algunos específicos

### Saltar a función

- gutemtags

### Utilidades

- Repeat
- Ennuch
- Surround
- Auto pair
- matchit

### Pantalla de inicio

- startify

### Buscador de archivos

- ctrl-p

### Listar métodos y funciones

- tagbar

### Guías de indentación

- indent line

### Búsqueda y reemplazo

- Far
- search index
- visual start

### Git

- fugitive
- gitgutter

## Buscando plugins

- Github
- Vim awesome
- Docs oficial de Neovim: https://github.com/neovim/neovim/wiki/Related-projects#plugins

---
