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
para que este funcione. En los inicios de Vim, bastaba con copiar y pegar estos
archivos en cada directorio (lo cual se puede seguir haciendo en Neovim), pero
conforme tu lista de plugins crece, se hace difícil mantener al día todos los
plugins.

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
se descargan (usualmente desde [GitHub](https://github.com)) e instalan.

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

" Aquí irán los nombres de los plugins a instalar

call plug#end()

" Luego de esta línea puedes agregar tus configuraciones
" y mappings de Neovim
```

## Instalando plugins con vim-plug

Vim-plug tiene soporte directo con los plugins alojados en GitHub (pero también
se puede instalar los que estén alojados en otros sitios, un repositorio git, o
de manera local).

En este post usaré plugins alojados en GitHub, para instalarlos sólo basta con
poner el nombre del usuario y del repositorio en el `init.vim`.

Por ejemplo, para instalar [este
plugin](https://github.com/tpope/vim-surround), agrega lo siguiente en tu
`init.vim`.

```vim
call plug#begin('~/.local/share/nvim/plugged')

Plug 'tpope/vim-surround'  " Es buena idea agregar un comentario con una descripción del plugin

call plug#end()
```

Pero con esto el plugin no está aún instalado, debes recargar tu `init.vim`
ejecutando `:so ~/.config/nvim/init.vim`. Y luego, ejecuta `:PlugInstall`.
Aparecerá una ventana con el progreso de Instalación, cuando se termine de
instalar el plugin, ciérrala presionando <kbd>q</kbd>.

{% include image.html
  alt="Ejecución del comando :PlugInstall"
  url="https://raw.githubusercontent.com/junegunn/i/master/vim-plug/installer.gif" 
  caption="Ejecución del comando :PlugInstall"
  normal=true
%}

Ahora si, el plugin se encontrará instalado, si deseas des-habilitarlo, basta
con comentar o eliminar esa línea. Pero esto no eliminará el plugin de tu
disco, para eliminarlo ejecuta el comando `:PlugClean`.

Es importante mantener tus plugins al día, así que de vez en cuando ejecuta
`:PlugUpdate` para actualizarlos.

Y además de los plugins, mantener al día tu _administrador de plugins_ también
es importante, puedes hacerlo con `:PlugUpgrade`.

## Cómo usar y configurar los plugins

Cada plugin tiene su propia documentación y dependencias, asegúrate de leerlas,
no hace falta hacerlo a profundidad. La mayoría provee en su página de inicio
algunas configuraciones suficientes para comenzar a usarlo.

Si necesitas configurar algo específico, busca en su documentación
(`:h <nombre-del-plugin>`). Si notas un error, asegúrate de estar usando la
última versión (`:PlugUpdate`), si el problema continúa revisa si ya está
reportado en su página de GitHub
([_issues_](https://guides.github.com/features/issues/)).

Las configuraciones de cada plugin van en tu `init.vim` luego de toda la lista
de plugins. Al igual que las demás configuraciones, trata de ser organizado y
documenta todo.

## Plugins esenciales

A continuación describiré algunos plugins que considero esenciales para
aumentar tu productividad, tu editor luzca bien y se asemeje a un _IDE
liviano_.

Para cada plugin presentaré una breve descripción, la página, y de ser el caso,
algunas configuraciones necesarias para empezar a usarlo. Para ello usaré un
`init.vim` _abreviado_ de la siguiente manera.

```vim
Plug 'usuario/plugin'  " Comentario

...

let g:configuracion_del_plugin = 1
```

Recuerda que los nombres de los plugins deben ir entre las funciones de
vim-plug, como se indicó al principio. Y las configuraciones deben ir luego de
`call plug#end()`. Y por si acaso, los `...` son sólo un separador visual, no
necesitas ponerlos en tu `init.vim`.

{% include alert.html
  type="warning"
  text="<span class=\"glyphicon glyphicon-alert\"></span>
        No instales cada plugin que veas en este post, lee con cuidado su
        descripción y toma los que realmente vayas a utilizar o mejoren tu
        productividad."
%}

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
