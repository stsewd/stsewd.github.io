.. title: Neovim, Instalación de Plugins
.. slug: neovim-plugins
.. date: 2017-08-20
.. tags: neovim
.. category: neovim
.. link: 
.. description: Para ser más productivo con Neovim los plugins son tus aliados, en este post mostraré cómo instalarlos y administrarlos, además una lista de plugins esenciales para hacer de tu editor un IDE muy liviano.
.. type: text

.. role:: raw-html(raw)
   :format: html

.. |icon-cmd| replace:: :raw-html:`<i class="fa fa-terminal"></i>`
.. |icon-link| replace:: :raw-html:`<i class="fa fa-external-link"></i>`
.. |icon-info| replace:: :raw-html:`<i class="fa fa-info-circle"></i>`

.. image:: /images/nvim/neovim-logo.png
   :target: /images/nvim/neovim-logo.png
   :alt: Logo de Neovim
   :align: center

Plugins
-------

Los plugins de Vim/Neovim no son más que archivos ``.vim``
(vimscript [#vimscript]_) o al menos la mayoría,
ya que Neovim nos permite escribir plugins en cualquier lenguaje
(plugins remotos [#remote-plugins]_).

Los plugins permiten extender la funcionalidad de nuestro editor,
integrarlo con herramientas externas, darle color (temas),
o hasta proveer *mappings* que nos facilitan realizar ciertas acciones.

Administrador de plugins
------------------------

Los archivos que conforman un plugin deben estar en directorios específicos para que este funcione.
En los inicios de Vim, bastaba con copiar y pegar estos archivos en cada directorio
(lo cual se puede seguir haciendo en Neovim), pero conforme tu lista de plugins crece,
se hace difícil mantener al día todos los plugins.

Para solucionar este problema nacen los administradores de plugins,
que se encargan de mantener los plugins y sus dependencias al día con un par de comandos
y sin la necesidad de copiar cada archivo en cada directorio correspondiente.

Los administradores de plugins más populares son:

- `Vim packages <https://neovim.io/doc/user/repeat.html#packages>`_ (administrador nativo)
- `pathogen <https://github.com/tpope/vim-pathogen>`_
- `Vundle <https://github.com/VundleVim/Vundle.vim>`_
- `dein <https://github.com/Shougo/dein.vim>`_
- `vim-plug`_

Todos a excepción de pathogen administran los plugins de manera similar,
pones los nombres de los plugins en tu ``init.vim``,
ejecutas un comando y estos se descargan
(usualmente desde `GitHub <https://github.com>`_) e instalan.

El administrador de plugins que usaré para el resto del post es `vim-plug`_,
porque es el que menos configuraciones requiere y se integra muy bien con Neovim.
Puedes escoger el que desees, los plugins pueden ser instalados con cualquier administrador.

.. _`vim-plug`: https://github.com/junegunn/vim-plug

.. note::

   Si quieres saber más sobre la estructura de directorios de los plugins
   de Vim/Neovim puedes leer `este gist`__.

__ https://gist.github.com/nelstrom/1056049/784e252c3de653e204e9e128653010e19fbd493f

Instalando vim-plug
-------------------

Vim-plug depende de git, si no lo tienes instalado,
ejecuta el siguiente comando:

.. code:: bash

   # Ubuntu
   sudo apt install git

   # Fedora
   sudo dnf install git

Para instalar vim-plug ejecuta el siguiente comando en la terminal:

.. code:: bash

   curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

.. note::

   Debes tener instalado ``curl`` previamente,
   instálalo en Ubuntu con ``sudo apt install curl``,
   o en Fedora con ``sudo dnf install curl``.

O si prefieres, descarga
`este archivo <https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim>`_
y guárdalo en ``~/.local/share/nvim/site/autoload/plug.vim``.

Ahora abre tu archivo ``init.vim``.

.. code:: bash

   nvim ~/.config/nvim/init.vim

Al inicio agrega lo siguiente:

.. code:: vim

   " Directorio de plugins
   call plug#begin('~/.local/share/nvim/plugged')
   
   " Aquí irán los plugins a instalar
   
   call plug#end()
   
   " Luego de esta línea puedes agregar tus configuraciones y mappings

Instalando plugins con vim-plug
-------------------------------

Vim-plug tiene soporte directo con plugins alojados en GitHub
(pero también se puede instalar los que estén alojados en otros sitios,
un repositorio git, o de manera local).

En este post usaré plugins alojados en GitHub, para instalarlos sólo basta con
poner el nombre del usuario y del repositorio en el archivo `init.vim`.

Por ejemplo, para instalar `este plugin <https://github.com/tpope/vim-surround>`_,
sólo se necesita agregar lo siguiente en el archivo ``init.vim``.

.. code:: vim

   call plug#begin('~/.local/share/nvim/plugged')
   
   Plug 'tpope/vim-surround'  " Es buena idea agregar una descripción del plugin
   
   call plug#end()

Pero con esto el plugin no está aún instalado,
debes recargar tu ``init.vim`` ejecutando ``:so ~/.config/nvim/init.vim``.
Y luego, ejecuta ``:PlugInstall``. Aparecerá una ventana con el progreso de instalación,
cuando se termine de instalar el plugin, ciérrala presionando :kbd:`q`.

.. figure:: https://raw.githubusercontent.com/junegunn/i/master/vim-plug/installer.gif
   :target:https://raw.githubusercontent.com/junegunn/i/master/vim-plug/installer.gif
   :alt: Ejecución del comando :PlugInstall

   Ejecución del comando ``:PlugInstall``

Ahora si, el plugin se encontrará instalado,
si deseas deshabilitarlo, basta con comentar o eliminar esa línea.
Pero esto no eliminará el plugin de tu disco,
para hacerlo ejecuta el comando ``:PlugClean``.

Es importante mantener tus plugins al día, 
sí que de vez en cuando ejecuta ``:PlugUpdate`` para actualizarlos.

Mantener al día tu *administrador de plugins* también es importante,
puedes hacerlo con ``:PlugUpgrade``.

Cómo usar y configurar los plugins
----------------------------------

Cada plugin tiene su propia documentación y dependencias,
asegúrate de leerlas, no hace falta hacerlo a profundidad.
La mayoría provee en su página algunas configuraciones suficientes para comenzar a usarlo.

Si necesitas configurar algo específico, busca en su documentación (``:h <nombre-del-plugin>``).
Si notas un error, asegúrate de estar usando la última versión (``:PlugUpdate``).

Las configuraciones de cada plugin van en tu ``init.vim`` luego de toda la lista de plugins.
Al igual que las demás configuraciones, trata de ser organizado y documenta todo.

Plugins esenciales
------------------

A continuación describiré algunos plugins que considero esenciales para aumentar tu productividad,
tu editor luzca bien y se asemeje a un *IDE liviano*.

Para cada plugin presentaré una breve descripción, su página, una lista de comandos
y de ser el caso, algunas configuraciones necesarias para empezar a usarlo.
Para ello usaré un ``init.vim`` *abreviado* de la siguiente manera.

.. code:: vim

   Plug 'usuario/plugin'  " Comentario

   ...

   let g:configuracion_del_plugin = 1

Recuerda que los nombres de los plugins deben ir entre las funciones de vim-plug,
Y las configuraciones deben ir luego de ``call plug#end()``.
Y por si acaso, los ``...`` son sólo un separador visual,
no necesitas ponerlos en tu ``init.vim``.

.. warning::

   No instales cada plugin que veas en este post,
   lee con cuidado su descripción y toma los que realmente vayas a utilizar
   o crees que mejoren tu productividad.

.. contents:: Lista
   :depth: 2
   :local:

Temas
~~~~~

Dentro de los plugins tenemos *color schemes*, o temas para tu Neovim.

One Dark
""""""""

  Color scheme inspirado por el tema One Dark de Atom.

.. figure:: /images/nvim/plugins/onedark.png
   :target: /images/nvim/plugins/onedark.png
   :alt: One Dark
   
   One Dark

.. code:: vim

   Plug 'joshdick/onedark.vim'

   ...

   set termguicolors  " Activa true colors en la terminal
   colorscheme onedark  " Activa tema onedark

- |icon-link| https://github.com/joshdick/onedark.vim
- |icon-info| https://github.com/joshdick/onedark.vim#options

NeoSolarized
""""""""""""

  Paleta de colores `Solarized <http://ethanschoonover.com/solarized>`_ para Neovim.

.. figure:: /images/nvim/plugins/neosolarized-light.png
   :target: /images/nvim/plugins/neosolarized-light.png
   :alt: NeoSolarized light

   NeoSolarized light

.. figure:: /images/nvim/plugins/neosolarized-dark.png
   :target: /images/nvim/plugins/neosolarized-dark.png
   :alt: NeoSolarized dark

   NeoSolarized dark

.. code:: vim

   Plug 'iCyMind/NeoSolarized'

   ...

   set termguicolors  " Activa true colors en la terminal
   set background=dark  " Fondo del tema: dark/light
   colorscheme NeoSolarized  " Activa tema NeoSolarized

- |icon-link| https://github.com/iCyMind/NeoSolarized
- |icon-info| https://github.com/iCyMind/NeoSolarized#options

Nova
""""

  Foto de Nova

Más
"""

- `Documentación de Neovim <https://github.com/neovim/neovim/wiki/Related-projects#colorschemes>`_

Explorador de archivos
~~~~~~~~~~~~~~~~~~~~~~

NerdTree
""""""""

  Explorador de archivos, útil para ver la estructura de tu proyecto.

.. figure:: /images/nvim/plugins/nerdtree.png
   :target: /images/nvim/plugins/nerdtree.png
   :alt: NERDTree

   NERDTree

.. code:: vim

   Plug 'scrooloose/nerdtree'
   
   ...
   
   let g:NERDTreeChDirMode = 2  " Cambia el directorio actual al nodo padre actual
   
   " Abrir/cerrar NERDTree con F2
   map <F2> :NERDTreeToggle<CR>

- |icon-cmd|

  - ``:NERDTree``
- |icon-link| https://github.com/scrooloose/nerdtree
- |icon-info| ``:h NERDTree``

.. note::

  Para cambiar entre ventanas (NERDTree y tu buffer actual)
  presiona :kbd:`Ctrl` + :kbd:`ww`.

Barra de estado
~~~~~~~~~~~~~~~

Airline
"""""""

  Barra de estado, con integración con varios plugins y herramientas externas como git.  

.. figure:: https://raw.githubusercontent.com/wiki/vim-airline/vim-airline/screenshots/demo.gif
   :target: https://raw.githubusercontent.com/wiki/vim-airline/vim-airline/screenshots/demo.gif
   :alt: Airline

   Airline

.. code:: vim

   Plug 'vim-airline/vim-airline'
   Plug 'vim-airline/vim-airline-themes'  " Temas para airline
   
   ...
   
   let g:airline#extensions#tabline#enabled = 1  " Mostrar buffers abiertos (como pestañas)
   let g:airline#extensions#tabline#fnamemod = ':t'  " Mostrar sólo el nombre del archivo
   
   " Cargar fuente Powerline y símbolos (ver nota)
   let g:airline_powerline_fonts = 1
   
   set noshowmode  " No mostrar el modo actual (ya lo muestra la barra de estado)

.. note::

   Para que tu barra de estado luzca como en la imagen,
   necesitas hacer uso de la fuente ``Powerline``,
   puedes instalar una de `estas fuentes <https://github.com/ryanoasis/nerd-fonts>`_
   (`recomiendo esta`__) y seleccionarla en las configuraciones de tu terminal.

__ https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/DejaVuSansMono/Regular/complete/DejaVu%20Sans%20Mono%20Nerd%20Font%20Complete%20Mono.ttf

- |icon-link| https://github.com/vim-airline/vim-airline
- |icon-info| ``:h airline``

Más
"""

- `Lightline <https://github.com/itchyny/lightline.vim>`_

Guías de indentación
~~~~~~~~~~~~~~~~~~~~

IndentLine
""""""""""

  Muestra los niveles de indentación con líneas verticales.

.. figure:: https://camo.githubusercontent.com/77b20e2e707ac1d85fd8bc12f16b5b7b7e72e186/687474703a2f2f692e696d6775722e636f6d2f4b566930542e6a7067
   :target: https://camo.githubusercontent.com/77b20e2e707ac1d85fd8bc12f16b5b7b7e72e186/687474703a2f2f692e696d6775722e636f6d2f4b566930542e6a7067
   :alt: IndentLine

   IndentLine

.. code:: vim

   Plug 'Yggdroot/indentLine'
   
   ...
   
   " No mostrar en ciertos tipos de buffers y archivos
   let g:indentLine_fileTypeExclude = ['text', 'sh', 'help', 'terminal']
   let g:indentLine_bufNameExclude = ['NERD_tree.*', 'term:.*']

- |icon-link| https://github.com/Yggdroot/indentLine
- |icon-info| ``:h indentLine.txt``

Más
"""

- `Indent guides <https://github.com/nathanaelkane/vim-indent-guides>`_

Auto completado
~~~~~~~~~~~~~~~

Deoplete
""""""""

  Auto completado asíncrono para Neovim.

.. figure:: https://raw.githubusercontent.com/mhartington/nvim-typescript/master/deoplete-tss.gif
   :target: https://raw.githubusercontent.com/mhartington/nvim-typescript/master/deoplete-tss.gif
   :alt: Deoplete

   Deoplete

.. code:: vim

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

- |icon-link| https://github.com/Shougo/deoplete.nvim"
- |icon-info| ``:h deoplete``

.. note::
   
   Para tener auto completado para un leguaje específico debes instalar una *fuente*,
   puedes encontrar una lista de varias fuentes `aquí`__.

__ https://github.com/Shougo/deoplete.nvim/wiki/Completion-Sources\

**Supertab**

  Permite navegar entre las sugerencias de deoplete usando :kbd:`Tab`.

.. code:: vim

   Plug 'ervandew/supertab'
   
   ...
   
   " Invertir direccion de navegacion (de arriba a abajo)
   let g:SuperTabDefaultCompletionType = '<c-n>'

- |icon-link| https://github.com/ervandew/supertab
- |icon-info| ``h supertab``

**Echodoc**

  Muestra la firma de la función.

.. figure:: https://cloud.githubusercontent.com/assets/111942/19444981/a076d748-9460-11e6-851c-f249f8110b3b.gif
   :target: https://cloud.githubusercontent.com/assets/111942/19444981/a076d748-9460-11e6-851c-f249f8110b3b.gif
   :alt: echodoc

   echodoc

.. code:: vim
   
   Plug 'Shougo/echodoc.vim'
   
   ...
   
   set noshowmode  " No mostrar el modo actual (echodoc hace uso de este espacio)
   
   " Activar echodoc al iniciar Neovim
   let g:echodoc_enable_at_startup = 1

- |icon-link| https://github.com/Shougo/echodoc.vim"
- |icon-info| ``:h echodoc``

Más
"""

- `YouCompleteMe <https://github.com/Valloric/YouCompleteMe>`_

----

.. [#vimscript] https://en.wikipedia.org/wiki/Vim_(text_editor)%23Vim_script
.. [#remote-plugins] https://neovim.io/doc/user/remote_plugin.html
