---
title: Neovim, instalación de plugins
tags: neovim vim plugins
intro: >
  Para ser más productivo con Neovim los plugins son tus aliados, en este post
  mostraré cómo instalarlos y administrarlos, además una lista de plugins
  esenciales para hacer de tu editor un IDE muy liviano.
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
        href=\"https://gist.github.com/nelstrom/1056049/784e252c3de653e204e9e128653010e19fbd493f\">
        este gist</a>."
%}

## Instalando vim-plug

Vim-plug depende de git, si no lo tienes instalado, ejecuta el siguiente comando:

```sh
# Ubuntu
sudo apt install git

# Fedora
sudo dnf install git
```

Para instalar vim-plug ejecuta el siguiente comando en la terminal:

```sh
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

{% include alert.html
  type="info"
  text="Debes tener instalado <code>curl</code> previamente, instálalo en
        Ubuntu con <code>sudo apt install curl</code>, o en Fedora con <code>sudo dnf
        install curl</code>."
%}

O si prefieres, descarga
[este archivo](https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim)
y guárdalo en `~/.local/share/nvim/site/autoload/plug.vim`.

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

Vim-plug tiene soporte directo con plugins alojados en GitHub (pero también se
puede instalar los que estén alojados en otros sitios, un repositorio git, o
de manera local).

En este post usaré plugins alojados en GitHub, para instalarlos sólo basta con
poner el nombre del usuario y del repositorio en el archivo `init.vim`.

Por ejemplo, para instalar
[este plugin](https://github.com/tpope/vim-surround), agrega lo siguiente en tu
`init.vim`.

```vim
call plug#begin('~/.local/share/nvim/plugged')

Plug 'tpope/vim-surround'  " Es buena idea agregar una descripción del plugin

call plug#end()
```

Pero con esto el plugin no está aún instalado, debes recargar tu `init.vim`
ejecutando `:so ~/.config/nvim/init.vim`. Y luego, ejecuta `:PlugInstall`.
Aparecerá una ventana con el progreso de instalación, cuando se termine de
instalar el plugin, ciérrala presionando <kbd>q</kbd>.

{% include image.html
  alt="Ejecución del comando :PlugInstall"
  url="https://raw.githubusercontent.com/junegunn/i/master/vim-plug/installer.gif"
  caption="Ejecución del comando :PlugInstall"
  normal=true
%}

Ahora si, el plugin se encontrará instalado, si deseas deshabilitarlo, basta
con comentar o eliminar esa línea. Pero esto no eliminará el plugin de tu
disco, para hacerlo ejecuta el comando `:PlugClean`.

Es importante mantener tus plugins al día, así que de vez en cuando ejecuta
`:PlugUpdate` para actualizarlos.

Y además de los plugins, mantener al día tu _administrador de plugins_ también
es importante, puedes hacerlo con `:PlugUpgrade`.

## Cómo usar y configurar los plugins

Cada plugin tiene su propia documentación y dependencias, asegúrate de leerlas,
no hace falta hacerlo a profundidad. La mayoría provee en su página algunas
configuraciones suficientes para comenzar a usarlo.

Si necesitas configurar algo específico, busca en su documentación
(`:h <nombre-del-plugin>`). Si notas un error, asegúrate de estar usando la
última versión (`:PlugUpdate`).

Las configuraciones de cada plugin van en tu `init.vim` luego de toda la lista
de plugins. Al igual que las demás configuraciones, trata de ser organizado y
documenta todo.

## Plugins esenciales

A continuación describiré algunos plugins que considero esenciales para
aumentar tu productividad, tu editor luzca bien y se asemeje a un _IDE
liviano_.

Para cada plugin presentaré una breve descripción, su página, una lista de
comandos y de ser el caso, algunas configuraciones necesarias para empezar a
usarlo. Para ello usaré un `init.vim` _abreviado_ de la siguiente manera.

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

Dentro de los plugins tenemos _color schemes_, o temas para tu Neovim.

#### One Dark

> Color scheme inspirado por el tema One Dark de Atom.

{% include image.html
  alt="One Dark"
  url="/assets/img/nvim/plugins/onedark.png" 
  normal=true
%}

```vim
Plug 'joshdick/onedark.vim'

...

set termguicolors  " Activa true colors en la terminal
colorscheme onedark  " Activa tema onedark
```

{% include nvim/info.html
  web='https://github.com/joshdick/onedark.vim'
  info_link='https://github.com/joshdick/onedark.vim#options'
%}

---

#### NeoSolarized

> Paleta de colores [Solarized](http://ethanschoonover.com/solarized) para
> Neovim.

{% include image.html
  alt="NeoSolarized light"
  url="/assets/img/nvim/plugins/neosolarized-light.png" 
  normal=true
%}

{% include image.html
  alt="NeoSolarized dark"
  url="/assets/img/nvim/plugins/neosolarized-dark.png" 
  normal=true
%}

```vim
Plug 'iCyMind/NeoSolarized'

...

set termguicolors  " Activa true colors en la terminal
set background=dark  " Fondo del tema: dark/light
colorscheme NeoSolarized  " Activa tema NeoSolarized
```

{% include nvim/info.html
  web='https://github.com/iCyMind/NeoSolarized'
  info_link='https://github.com/iCyMind/NeoSolarized#options'
%}

---

#### Otros

- [Documentación de Neovim](https://github.com/neovim/neovim/wiki/Related-projects#colorschemes)

---

### Explorador de archivos

#### NerdTree

> Explorador de archivos, útil para ver la estructura de tu proyecto.

{% include image.html
  alt="NERDTree"
  url="/assets/img/nvim/plugins/nerdtree.png"
  normal=true
%}

```vim
Plug 'scrooloose/nerdtree'

...

let g:NERDTreeChDirMode = 2  " Cambia el directorio actual al nodo padre actual

" Archivos a ignorar
let g:NERDTreeIgnore = [
    \ '\.pyc$', '^__pycache__$', '^venv$',
    \ '^tags$'
    \]

let g:NERDTreeMinimalUI = 1  " Oculta texto de ayuda de la interfaz

" Abrir/cerrar NerdTree con F2
map <F2> :NERDTreeToggle<CR>
```

{% include nvim/info.html
  commands=":NERDTree"
  web='https://github.com/scrooloose/nerdtree'
  info_cmd=':h NERDTree'
%}

{% include alert.html
  type="info"
  text="Para cambiar entre paneles (NERDTree y tu buffer actual) presiona
        <kbd>Ctrl</kbd> + <kbd>ww</kbd>."
%}

---

### Barra de estado

#### Airline

> Barra de estado, con integración con varios plugins y herramientas externas
> como git.

{% include image.html
  alt="Airline"
  url="https://raw.githubusercontent.com/wiki/vim-airline/vim-airline/screenshots/demo.gif"
  normal=true
%}

```vim
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'  " Temas para airline

...

let g:airline#extensions#tabline#enabled = 1  " Mostrar buffers abiertos (como pestañas)
let g:airline#extensions#tabline#fnamemod = ':t'  " Mostrar sólo el nombre del archivo

" Cargar fuente Powerline y símbolos (ver nota)
let g:airline_powerline_fonts = 1

set noshowmode  " No mostrar el modo actual (ya lo muestra la barra de estado)
```

**Nota**: Para que tu barra de estado luzca como en la imagen, necesitas hacer
uso de la fuente Powerline, puedes instalar una de
[estas fuentes](https://github.com/ryanoasis/nerd-fonts)
([recomiendo esta](https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/DejaVuSansMono/Regular/complete/DejaVu%20Sans%20Mono%20Nerd%20Font%20Complete%20Mono.ttf))
y seleccionarla en las configuraciones de tu terminal.

{% include nvim/info.html
  web='https://github.com/vim-airline/vim-airline'
  info_cmd=':h airline'
%}

---

#### Otros

- [Lightline](https://github.com/itchyny/lightline.vim)

---

### Guías de indentación

#### IndentLine

> Muestra los niveles de indentación con líneas verticales.

{% include image.html
  alt="IndentLine"
  url="https://camo.githubusercontent.com/77b20e2e707ac1d85fd8bc12f16b5b7b7e72e186/687474703a2f2f692e696d6775722e636f6d2f4b566930542e6a7067"
  normal=true
%}

```vim
Plug 'Yggdroot/indentLine'

...

" No mostrar en ciertos tipos de buffers y archivos
let g:indentLine_fileTypeExclude = ['text', 'sh', 'help', 'terminal']
let g:indentLine_bufNameExclude = ['NERD_tree.*', 'term:.*']
```

{% include nvim/info.html
  web="https://github.com/Yggdroot/indentLine"
  info_cmd=":h indentLine.txt"
%}

---

#### Otros

- [Indent guides](https://github.com/nathanaelkane/vim-indent-guides)

---

### Auto completado

#### Deoplete

> Auto completado asíncrono para Neovim.

{% include image.html
  alt="Deoplete"
  url="https://raw.githubusercontent.com/mhartington/nvim-typescript/master/deoplete-tss.gif"
  normal=true
%}

```vim
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neco-syntax'  " Fuente general de auto completado

...

" Activar deoplete al iniciar Neovim
let g:deoplete#enable_at_startup = 1

" Cerrar automaticamente la ventana de vista previa (donde se muestra documentación, si existe)
augroup deopleteCompleteDoneAu
  autocmd!
  autocmd CompleteDone * silent! pclose!
augroup END
```

{% include nvim/info.html
  web="https://github.com/Shougo/deoplete.nvim"
  info_cmd=":h deoplete"
%}

{% include alert.html
  type="info"
  text="Para tener auto completado para un leguaje específico debes instalar
        una <i>fuente</i>, puedes encontrar una lista de varias fuentes
        <a href=\"https://github.com/Shougo/deoplete.nvim/wiki/Completion-Sources\">
          aquí
        </a>."
%}

##### Supertab

> Permite navegar entre las sugerencias de deoplete usando <kbd>Tab</kbd>.

```vim
Plug 'ervandew/supertab'

...

" Invertir direccion de navegacion (de arriba a abajo)
let g:SuperTabDefaultCompletionType = '<c-n>'
```

{% include nvim/info.html
  web="https://github.com/ervandew/supertab"
  info_cmd=":h supertab"
%}

##### Echodoc

> Muestra la firma de la función.

{% include image.html
  alt="echodoc"
  url="https://cloud.githubusercontent.com/assets/111942/19444981/a076d748-9460-11e6-851c-f249f8110b3b.gif" 
  normal=true
%}

```vim
Plug 'Shougo/echodoc.vim'

...

set noshowmode  " No mostrar el modo actual (echodoc hace uso de este espacio)

" Activar echodoc al iniciar Neovim
let g:echodoc_enable_at_startup = 1
```

{% include nvim/info.html
  web="https://github.com/Shougo/echodoc.vim"
  info_cmd=":h echodoc"
%}

---

#### Otros

- [YouCompleteMe](https://github.com/Valloric/YouCompleteMe)

---

### Snippets

#### Ultisnips

> Provee porciones de código reusables.

{% include image.html
  alt="Ultisnips"
  url="https://camo.githubusercontent.com/296aecf30e1607233814196db6bd3f5f47e70c73/68747470733a2f2f7261772e6769746875622e636f6d2f5369725665722f756c7469736e6970732f6d61737465722f646f632f64656d6f2e676966" 
  normal=true
%}

```vim
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'

...

" Expandir snippet con Ctrl + j
let g:UltiSnipsExpandTrigger = '<c-j>'

" Ir a siguiente ubicacion con Ctrl + j
let g:UltiSnipsJumpForwardTrigger = '<c-j>'
" Ir a anterior ubicacion con Ctrl + k
let g:UltiSnipsJumpBackwardTrigger = '<c-k>'
```

{% include nvim/info.html
  web="https://github.com/sirver/ultisnips"
  info_cmd=":h UltiSnips"
%}

---

### Analizador estático de código

#### ALE

> Analizador estático asíncrono.

{% include image.html
  alt="ALE"
  url="https://github.com/w0rp/ale/raw/master/img/example.gif?raw=true" 
  normal=true
%}

```vim
Plug 'w0rp/ale'

...

" Mostrar mejor mensajes de error
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
```

{% include nvim/info.html
  commands=":ALEFixSuggest :ALEFix"
  web="https://github.com/w0rp/ale"
  info_cmd=":h ale.txt"
%}

---

#### Otros

- [Neomake](https://github.com/neomake/neomake)

---

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

- [GitHub](https://github.com/)
- [Vim awesome](http://vimawesome.com/)
- [Documentación de Neovim](https://github.com/neovim/neovim/wiki/Related-projects#plugins)

---
