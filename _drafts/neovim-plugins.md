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

- [Vim packages](https://neovim.io/doc/user/repeat.html#packages) (administrador nativo)
- [pathogen](https://github.com/tpope/vim-pathogen)
- [Vundle](https://github.com/VundleVim/Vundle.vim)
- [dein](https://github.com/Shougo/dein.vim)
- [vim-plug](https://github.com/junegunn/vim-plug)

Todos a excepción de pathogen administran los plugins de manera similar,
pones los nombres de los plugins en tu `init.vim`, ejecutas un comando y estos
se descargan (usualmente desde [GitHub](https://github.com)) e instalan.

El administrador de plugins que usaré para el resto del post es
[vim-plug](https://github.com/junegunn/vim-plug), porque es el que menos
configuraciones requiere y se integra muy bien con Neovim. Puedes escoger el
que desees, los plugins pueden ser instalados con cualquier administrador.

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

Ahora abre tu archivo `init.vim`.

```sh
nvim ~/.config/nvim/init.vim
```

Al inicio agrega lo siguiente:

```vim
" Especifíca el directorio de plugins
call plug#begin('~/.local/share/nvim/plugged')

" Aquí irán los plugins a instalar

call plug#end()

" Luego de esta línea puedes agregar tus configuraciones y mappings
```

## Instalando plugins con vim-plug

Vim-plug tiene soporte directo con plugins alojados en GitHub (pero también se
puede instalar los que estén alojados en otros sitios, un repositorio git, o
de manera local).

En este post usaré plugins alojados en GitHub, para instalarlos sólo basta con
poner el nombre del usuario y del repositorio en el archivo `init.vim`.

Por ejemplo, para instalar
[este plugin](https://github.com/tpope/vim-surround), sólo se necesita agregar
lo siguiente en el archivo `init.vim`.

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

Mantener al día tu _administrador de plugins_ también es importante, puedes
hacerlo con `:PlugUpgrade`.

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

#### Polyglot

> Colección de varios plugins de resaltado de sintaxis.

```vim
Plug 'sheerun/vim-polyglot'
```

{% include nvim/info.html
  web="https://github.com/sheerun/vim-polyglot"
  info_link="https://github.com/sheerun/vim-polyglot#troubleshooting"
%}

---

#### Otros

Alternativamente puedes instalar un plugin específico para cada lenguaje.
Por ejemplo:

##### [CSS](https://github.com/hail2u/vim-css3-syntax)

```vim
Plug 'hail2u/vim-css3-syntax', { 'for': 'css' }
```

##### [Html](https://github.com/othree/html5.vim)

```vim
Plug 'othree/html5.vim', { 'for': 'html' }
```

##### [JavaScript](https://github.com/pangloss/vim-javascript)

```vim
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
```

##### [Markdown](https://github.com/plasticboy/vim-markdown)

```vim
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
```

---

### Ir a definición

Varios IDEs ofrecen la funcionalidad de "ir a definición" (go to ...). Neovim
también lo hace, y para ello almacena un índice de identificadores con su
localización en un archivo `tag`.

Ir a definición de la palabra sobre el cursor:

- <kbd>Ctrl</kbd> + <kbd>]</kbd>.
- <kbd>Ctrl</kbd> + click izquierdo.

Para generar este archivo haremos uso de un programa llamado `ctags`.

```sh
# Instalar en ctags en Ubuntu
sudo apt install exuberant-ctags

# Instalar ctags en Fedora
sudo dnf install ctags
```

[Lista de lenguajes soportados por `ctags`](http://ctags.sourceforge.net/languages.html).
Si tu lenguaje no está en la lista, hay varios plugins que ofrecen esta
funcionalidad a modo de funciones, como
[tern for vim](https://github.com/ternjs/tern_for_vim#tern-for-vim),
[jedi-vim](https://github.com/davidhalter/jedi-vim#features).

{% include alert.html
  type="info"
  text="Puedes leer más sobre los archivos tag y vim
        <a href=\"http://vim.wikia.com/wiki/Browsing_programs_with_tags\">aquí</a>."
%}

{% include alert.html
  type="warning"
  text="Neovim no genera este archivo de manera automática, sólo se encarga de
        leerlo, pero existen plugins que nos facilitan esta tarea."
%}

#### Gutentags

> Administrador de archivos `tag`.

```vim
Plug 'ludovicchabant/vim-gutentags'

...

" Nombre del archivo generado
let g:gutentags_ctags_tagfile = '.tags'
```

{% include nvim/info.html
  web="https://github.com/ludovicchabant/vim-gutentags"
  info_cmd=":h gutentags"
%}

---

### Buscador de archivos

#### CtrlP

> Buscador de archivos y buffers.

```vim
Plug 'ctrlpvim/ctrlp.vim'

...

" Archivos ignorados
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|node_modules)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }

" Ignorar archivos en .gitignore
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
```

{% include nvim/info.html
  web="https://github.com/ctrlpvim/ctrlp.vim"
  info_cmd=":h ctrlp"
%}

---

### Búsqueda y reemplazo

#### FAR

> Búsqueda y reemplazo en varios archivos.

{% include image.html
  alt="far"
  url="https://cloud.githubusercontent.com/assets/9823254/20861878/77dd1882-b9b4-11e6-9b48-8bc60f3d7ec0.gif" 
  normal=true
%}

```vim
Plug 'brooth/far.vim'
```

{% include nvim/info.html
  commands=":F :Far"
  web="https://github.com/brooth/far.vim"
  info_cmd=":h far.vim"
%}

---

#### Incsearch

> Búsqueda incremental mejorada.

{% include image.html
  alt="incsearch"
  url="https://cloud.githubusercontent.com/assets/3797062/3866152/40e11c48-1fc4-11e4-8cfd-ace452a19f90.gif" 
  normal=true
%}

```vim
Plug 'haya14busa/incsearch.vim'

...

" Maps requeridos
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" Quitar resaltado luego de buscar
let g:incsearch#auto_nohlsearch = 1
```

{% include nvim/info.html
  web="https://github.com/haya14busa/incsearch.vim"
  info_cmd=":h incsearch.txt"
%}

---

### Utilidades

#### Surround

> Facilita poner/quitar/cambiar comillas, paréntesis, tags, etc sobre un texto.

```vim
Plug 'tpope/vim-surround'
```

{% include nvim/info.html
  web="https://github.com/tpope/vim-surround"
  info_cmd=":h surround"
%}

---

#### Repeat

> Repetir acciones de plugins con <kbd>.</kbd>.

```vim
Plug 'tpope/vim-repeat'
```

{% include nvim/info.html
  web="https://github.com/tpope/vim-repeat"
  info_link="https://github.com/tpope/vim-repeat#repeatvim"
%}

---

#### Eunuch

> Provee comandos de sistemas UNIX.

```vim
Plug 'tpope/vim-eunuch'
```

{% include nvim/info.html
  commands=":Delete :Move :Rename :Chmod :Mkdir"
  web="https://github.com/tpope/vim-eunuch"
  info_cmd=":h eunuch"
%}

---

#### Auto-pairs

> Inserta pares de comillas y paréntesis.

```vim
Plug 'jiangmiao/auto-pairs'
```

{% include nvim/info.html
  web="https://github.com/jiangmiao/auto-pairs"
  info_cmd=":h AutoPairs.txt"
%}

---

#### Nerdcommenter

> Facilita agregar y quitar comentarios.

```vim
Plug 'scrooloose/nerdcommenter'

...

let g:NERDSpaceDelims = 1  " Agregar un espacio después del delimitador del comentario
let g:NERDTrimTrailingWhitespace = 1  " Quitar espacios al quitar comentario
```

{% include nvim/info.html
  web="https://github.com/scrooloose/nerdcommenter"
  info_cmd=":h NERDCommenter"
%}

---

### Git

#### Fugitive

> Provee comandos de git.

```vim
Plug 'tpope/vim-fugitive'
```

{% include nvim/info.html
  commands=":Gstatus :Gcommit :Gdiff"
  web="https://github.com/tpope/vim-fugitive"
  info_cmd=":h fugitive"
%}

---

#### Gitgutter

> Muestra cambios hechos en el archivo en la columna de signos.

{% include image.html
  alt="incsearch"
  url="https://camo.githubusercontent.com/f88161827e0cbb3144455b9e5c7582fdd5b5fc83/68747470733a2f2f7261772e6769746875622e636f6d2f616972626c6164652f76696d2d6769746775747465722f6d61737465722f73637265656e73686f742e706e67" 
  normal=true
%}

```vim
Plug 'airblade/vim-gitgutter'

...

" Actualizar barra cada 250 mili segundos
set updatetime=250
```

{% include nvim/info.html
  web="https://github.com/airblade/vim-gitgutter"
  info_cmd=":h gitgutter.txt"
%}

---

#### Nerdtree git plugin

> Muestra el estado de los archivos en Nerdtree.

{% include image.html
  alt="nerdtree git plugin"
  url="https://camo.githubusercontent.com/3fe0388df11cb787f36e1fa108398fd3f757eef4/687474703a2f2f692e696d6775722e636f6d2f6a534377476a552e6769663f31" 
  normal=true
%}

```vim
Plug 'xuyuanp/nerdtree-git-plugin'
```

{% include nvim/info.html
  web="https://github.com/xuyuanp/nerdtree-git-plugin"
  info_link="https://github.com/xuyuanp/nerdtree-git-plugin#faq"
%}

---

## Buscando plugins

No existe un repositorio oficial de plugins para Neovim, por lo que hace que la
búsqueda de nuevos plugins (bien mantenidos y sin errores) sea un poco difícil.

### [GitHub](https://github.com/search)

Como habrás observado, la mayoría de plugins están alojados en GitHub, así que
es un buen lugar para buscar. 

Trata de buscar repositorios con la palabra `vim`, `neovim`, `nvim` o que
terminen en `.vim` (los que son sólo compatibles con Neovim tienen la extensión
`.nvim`).

### [Dotfiles](https://github.com/search?l=Vim+script&q=dotfiles&type=Repositories&utf8=%E2%9C%93)

Otra manera de buscar plugins es buscando en los `dotfiles` de varios usuarios
([mis dotfiles](https://github.com/stsewd/dotfiles)).

### [Vim awesome](http://vimawesome.com/)

Colección de plugins más usados. Ten en cuenta que la mayor parte (todos en
realidad) son plugins para Vim, así que tal vez no encuentres mejores
alternativas para Neovim.

### [Documentación de Neovim](https://github.com/neovim/neovim/wiki/Related-projects#plugins)

Lista de varios plugins que hacen uso de las características de Neovim.

---
