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

Los archivos de un plugin deben estar en directorios específicos para que
funcionen. En los primeros inicios de Vim, bastaba con copiar y pegar estos
archivos en la ruta de instalación de Vim (lo cual se puede seguir haciendo en
Neovim), pero conforme tu lista de plugins crece, se hace un poco difícil
mantener al día todos los plugins.

Explicar lo que hace un plugin manager, la extructura común de los plugins

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
