.. title: Neovim, Instalación y Configuración Básica
.. slug: neovim-installation-configuration
.. date: 2017-07-06
.. tags: neovim
.. category: neovim
.. link: 
.. description: En este post daré una introducción a Neovim, un editor de texto muy diferente a los que estás acostumbrado a usar. Además detallaré paso a paso las instrucciones para su instalación en Fedora y Ubuntu; y cómo configurarlo.
.. type: text

.. |sudo-msg| replace::

   Puede que necesites ejecutar estos comandos anteponiendo **sudo**. 

.. image:: /images/nvim/neovim-logo.png
   :target: /images/nvim/neovim-logo.png
   :alt: Logo de Neovim
   :align: center

¿Qué es Neovim?
---------------

`Neovim`_ es una refactorización del código de `Vim`_,
es un fork, no un clon de este [#fork-no-clone]_.
Trae lo bueno de Vim con una mejor experiencia *fuera de caja* para el usuario.

**¿Entonces qué es Vim?** Vim es un editor de texto basado en modos
(un lugar para escribir, otro para insertar comandos, y así).
Nació como mejora de Vi (1976).
Su interfaz no es gráfica, sino basada en texto
(aunque existen varias implementaciones con interfaz gráfica, como gVim).

.. _Neovim: https://neovim.io/charter/
.. _Vim: http://www.vim.org/

Neovim vs Vim
-------------

¿Qué realmente ofrece Neovim frente a Vim,
además de tener un código más limpio?

- Configuraciones por defecto, que hacen que puedas usarlo de manera inmediata.
  [#configuraciones-defecto]_ [#configuraciones-defecto-documentacion]_
- Un emulador de terminal. [#emulador-terminal]_
- Mejor integración con características de terminales modernos
  (estilo del cursor, *truecolor* [#true-color]_).
- Una API que permite la comunicación con Neovim desde cualquier lenguaje de programación
  (de manera segura y asíncrona). [#api-neovim]_
- Mejor integración con el mouse.

¿Por qué usar Neovim?
---------------------

Antes de describir las ventajas de usar Neovim,
debo aclarar que las mismas **son válidas para Vim**,
ya que es un reemplazo directo de Vim.
Si eres usuario de Vim, te recomiendo que pruebes Neovim.

**Todo puede ser controlado con el teclado** a través de comandos,
puede parecer un poco complicado recordarlos (y al principio lo es),
pero están organizados de una manera lógica,
y con el tiempo se vuelven predecibles.

Facilita la edición de texto,
permitiéndote **automatizar tareas repetitivas**,
y las tareas tediosas las puedes lograr con un par de teclas.
Con el tiempo, sentirás que el **teclado es una extension más de tus manos**.

Es **altamente configurable**,
es como si construyeras tu propio editor,
al final tendrás un editor **hecho a tu medida**,
que cubre tus necesidades específicas.

Su comportamiento es expandible a través de **plugins**,
si usas Vim, **puedes seguir usando los mismos plugins de Vim**,
más los que la comunidad ha desarrollado para Neovim.
Y si te animas, puedes **crear tu propio plugin en tu lenguaje favorito**
(hace poco hice mi `primer plugin <https://github.com/stsewd/open-plugin-page.nvim>`_ en python).

Y por último,
trae **las mismas características que cualquier otro editor de código**,
como: auto completado, corrector ortográfico, pestañas, coloreado de sintaxis,
búsqueda y reemplazo con expresiones regulares, etc.

Con todas las características mencionadas Neovim será *el único editor* que necesites
para programar en cualquier lenguaje, o editar texto en general.

Instalación
-----------

Para la instalación de Neovim he usado dos máquinas virtuales:
 
- Ubuntu 16.04.02
- Fedora 25.1.3

Si usas otra distro que no sea Ubuntu ni Fedora o usas Windows,
puedes seguir el proceso de instalación en la
`documentación oficial de Neovim <https://github.com/neovim/neovim/wiki/Installing-Neovim>`_.

Si no deseas instalar nada en tu sistema, puedes hacer uso de la ``Appimage`` de Neovim.

.. code:: sh

   curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
   chmod u+x nvim.appimage

Ubuntu
~~~~~~

Para tener la última versión hay que agregar la
`PPA de Neovim <https://launchpad.net/%7Eneovim-ppa/+archive/ubuntu/unstable>`_.
Ejecuta el siguiente comando en la terminal.

.. code:: sh

   sudo add-apt-repository ppa:neovim-ppa/unstable

Luego, hay que actualizar los paquetes e instalar Neovim.

.. code:: sh

   sudo apt-get update
   sudo apt-get install neovim

Fedora
~~~~~~

Para instalar la última versión de Neovim en Fedora,
ejecuta el siguiente comando.

.. code:: sh

   sudo dnf install neovim

Comprobando la instalación
~~~~~~~~~~~~~~~~~~~~~~~~~~

Para comprobar que todo ha salido bien,
en la terminal ejecuta el comando ``nvim``.

.. code:: sh

   nvim

.. note::

   Si usaste la ``Appimage``, debes ejecutar ``./nvim.appimage``
   sobre el directorio donde la descargaste.

Podrás ver la pantalla de bienvenida de Neovim.

.. figure:: /images/nvim/neovim-ubuntu.jpg
   :target: /images/nvim/neovim-ubuntu.jpg
   :alt: Neovim en Ubuntu

   Neovim en Ubuntu

.. figure:: /images/nvim/neovim-fedora.png
   :target: /images/nvim/neovim-fedora.png
   :alt: Neovim en Fedora

   Neovim en Fedora

.. note::

   Tal vez ahora mismo Neovim luzca aburrido,
   nada *moderno* ni con un gran diseño,
   pero al finalizar esta serie de posts
   tendrás un editor sin nada que envidiarle al resto.

.. figure:: /images/nvim/my-neovim.png
   :target: /images/nvim/my-neovim.png
   :alt: Mi Neovim

   Mi Neovim ahora

¿Y ahora qué?
-------------

Has abierto Neovim por primera vez, si no has usado Vim antes,
puede que te estés haciendo algunas preguntas:
¿dónde están los menús? ¿cómo empiezo a escribir? o ¿cómo #@!?$# salgo?

Más adelante te mostraré todo esto,
por ahora lo que necesitas saber es que puedes moverte usando las teclas direccionales;
y para salir, presiona al menos tres veces la tecla :kbd:`Esc`,
luego presiona la tecla :kbd:`:`,
en la parte inferior aparecerá un pequeño espacio donde podrás ingresar texto,
ingresa ``q!`` y luego presiona :kbd:`Enter`.

Instalando dependencias adicionales
-----------------------------------

Has instalado Neovim,
pero aún hace falta instalar algunas dependencias (opcionales)
para sacarle más provecho y no tener ningún problema al instalar plugins.

Proveedor de portapapeles
~~~~~~~~~~~~~~~~~~~~~~~~~

Para que Neovim pueda copiar o pegar desde el portapapeles [#portapapeles]_ del sistema operativo,
hay que instalar un *proveedor*.

Existen dos alternativas ``xclip`` y ``xsel``, ambas muy buenas.
A continuación tienes los comandos para instalar alguna de ellas.

Ubuntu:

.. code:: sh

   sudo apt install xclip

.. code:: sh

   sudo apt install xsel

Fedora:

.. code:: sh

   sudo dnf install xclip

.. code:: sh

   sudo dnf install xsel

Interfaces de Python
~~~~~~~~~~~~~~~~~~~~

Algunos plugins hacen uso de la `interfaz de python`_ que Neovim provee.

.. _`interfaz de python`: https://github.com/neovim/python-client

Se hará la instalación para las dos versiones de Python (2 y 3),
aunque es seguro no instalar las interfaces de Python 2,
porque todos los plugins que se instalarán usan Python 3.

Ubuntu
""""""

Ubuntu ya incluye ambas versiones de Python,
pero antes hay que instalar ``pip``
(una herramienta para descargar y administrar librerías de Python).
Para ello ejecuta los siguientes comandos:

.. code:: sh

   sudo apt install python3-pip

.. code:: sh

   sudo apt install python-pip

Ahora ya puedes instalar las interfaces de Neovim.

.. warning::

   |sudo-msg|

.. code:: sh

   python3 -m pip install neovim

.. code:: sh

   python -m pip install neovim

Fedora
""""""

Las versiones actuales de Fedora sólo incluyen Python 3,
así que si necesitas instalar Python 2, puedes hacerlo con:

.. code:: sh

   sudo dnf install python

Ahora ya puedes instalar las interfaces de Neovim,
aunque puede que Fedora ya lo haya hecho cuando instalaste Neovim
(actualizar con los comandos de la siguiente sección si es el caso).

.. warning::

   |sudo-msg|

.. code:: sh

   python3 -m pip install neovim

.. code:: sh

   python -m pip install neovim

Manteniendo las interfaces de Python al día
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Es recomendable que cada cierto tiempo actualices las interfaces de Python,
así estarás al día con lo último que Neovim ofrece a través de su API.

.. warning::

   |sudo-msg|

.. code:: sh

   python3 -m pip install --upgrade neovim

.. code:: sh

   python -m pip install --upgrade neovim

Interfaces de Ruby
~~~~~~~~~~~~~~~~~~

Al igual que algunos plugins hacen uso de la interfaz de Python,
otros usan la interfaz de `Ruby`_.

.. _`Ruby`: https://rubygems.org/gems/neovim/

Ubuntu
""""""

Ubuntu no trae Ruby por defecto,
instálalo con los siguientes comandos.

.. code:: sh

   sudo apt install ruby
   sudo apt install ruby-dev

Ahora si podrás instalar la interfaz de Ruby.

.. warning::

   |sudo-msg|

.. code:: sh

   gem install neovim

Fedora
""""""

Fedora no trae Ruby por defecto,
instálalo con los siguientes comandos.

.. code:: sh

   sudo dnf install ruby
   sudo dnf install ruby-devel
   sudo dnf install gcc-c++
   sudo dnf install redhat-rpm-config

Ahora si podrás instalar la interfaz de Ruby.

.. warning::

   |sudo-msg|

.. code:: sh

   gem install neovim

Comprobando las dependencias adicionales
----------------------------------------

Has instalado las dependencias adicionales para Neovim,
pero ¿cómo saber que todo salió bien?
Neovim trae una herramienta que permite comprobarlo, ``checkhealth``.
Para hacer uso de esta herramienta hay que iniciar Neovim con un parámetro algo especial.

.. code:: sh

   nvim +checkhealth

Espera unos segundos a que Neovim haga las comprobaciones,
si todo salió bien debe aparecer algo como esto:

.. figure:: /images/nvim/checkhealth.png
   :target: /images/nvim/checkhealth.png
   :alt: resultado de correr checkhealth en Neovim
  
   Resultado de correr checkhealth en Neovim

Primeros pasos con Neovim
-------------------------

A continuación aprenderás lo básico para empezar a usar Neovim como un editor de código.
Al principio parecerá que es contra-productivo,
y que hay que teclear demasiado para realizar una simple acción;
existen otras maneras más eficientes de hacerlo,
pero el objetivo es que te sientas cómodo con la edición de texto antes de pasar a cosas más avanzadas.
Al final del post encontrarás varios recursos para aprender más sobre Neovim/Vim.

.. note::

   Todo lo que aprendas en esta sección también es válido para Vim.

Modos
~~~~~

Neovim tiene 3 modos principales:

- **Modo normal** - Donde todas las teclas son interpretadas como comandos.
- **Modo insertar** - Donde puedes escribir todo lo que teclees.
- **Modo visual** - Donde puedes seleccionar bloques de texto.

Para entrar y salir de cada modo:

- Para entrar al modo insertar, presiona :kbd:`i`.
- Para salir del modo insertar, presiona :kbd:`Esc`
- Para entrar al modo visual, presiona :kbd:`v`.
- Para salir del modo visual, presiona :kbd:`Esc`

**Cuando abres Neovim, el modo por defecto es el normal.**

.. note::

   Cada vez que sientas que te perdiste en un paso,
   presiona :kbd:`Esc` al menos tres veces,
   así podrás regresar al modo normal y empezar de nuevo.

Abrir un archivo
~~~~~~~~~~~~~~~~

Puedes abrir un archivo desde la terminal con:

.. code:: sh

   nvim mi-archivo.txt

Moviéndote por el editor
~~~~~~~~~~~~~~~~~~~~~~~~

Antes había dicho que puedes usar las teclas direccionales para moverte,
pero no es lo más eficiente cuando usas Neovim,
las teclas direccionales están lejos de tu *home row* [#home-row]_.
Puedes usar las siguientes teclas para moverte dentro del modo normal.

- :kbd:`h` - izquierda
- :kbd:`j` - abajo
- :kbd:`k` - arriba
- :kbd:`l` - derecha

.. figure:: /images/nvim/hjkl.png
   :target: /images/nvim/hjkl.png
   :align: center

   Cheatsheet http://vimsheet.com/

También puedes usar :kbd:`w` y :kbd:`b` para moverte entre palabras.

Al principio va a ser duro no hacerlo con las teclas direccionales,
intenta practicar hasta que te sientas cómodo,
y no llegar a perder la cabeza o `las teclas`_.

.. _`las teclas`: https://twitter.com/MasteringVim/status/879294993659310080

.. note::

   Puedes usar :kbd:`j` y :kbd:`k` para moverte en este blog.

Escribir sobre un archivo
~~~~~~~~~~~~~~~~~~~~~~~~~

Para empezar a escribir debes ingresar al modo insertar con :kbd:`i`.
Observa como la forma del cursor ha cambiado,
ingresa algún texto y cuando termines presiona :kbd:`Esc` para volver al modo normal.

Guardar
~~~~~~~

En modo normal presiona :kbd:`:`, escribe `w` y presiona enter.

Salir
~~~~~

En modo normal presiona :kbd:`:`, luego escribe ``q`` y presiona enter
(para salir sin guardar los cambios, debes escribir ``q!``).

Seleccionar texto
~~~~~~~~~~~~~~~~~

Presiona :kbd:`v` para entrar al modo visual,
mueve el cursor para realizar la selección.
Presiona :kbd:`Esc` para regresar al modo normal.

Copiar & pegar
~~~~~~~~~~~~~~

Selecciona un texto usando el modo visual, luego presiona :kbd:`y`.
Presiona :kbd:`p` para pegar después del cursor o :kbd:`P` para pegar antes del cursor.

Para copiar una palabra,
en modo normal presiona :kbd:`yiw` o para copiar la línea actual presiona :kbd:`yy`.

Cortar
~~~~~~

Selecciona un texto usando el modo visual, luego presiona :kbd:`d`.
Para cortar una palabra,
en modo normal presiona :kbd:`diw` o para cortar la línea actual presiona :kbd:`dd`.

Para pegar el texto cortado, presiona :kbd:`p`.

Copiar y pegar desde el portapapeles
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Si intentaste pegar texto fuera de Neovim,
o pegar algo que habías copiado al portapapeles,
te habrás dado cuenta que no funciona.
Para usar el portapapeles debes copiar usando :kbd:`"+y`,
y para pegar desde el portapapeles :kbd:`"+p`.

Deshacer y rehacer
~~~~~~~~~~~~~~~~~~

Para deshacer, en modo normal presiona :kbd:`u`;
y para rehacer :kbd:`Ctrl` + :kbd:`r`.

.. warning::

   Tal vez te veas tentado a usar :kbd:`Ctrl` + :kbd:`z`,
   si lo hiciste y tu editor se *cerró* no te preocupes,
   sólo escribe :kbd:`fg` en la terminal y tendrás de regreso tu editor.

Auto completado
~~~~~~~~~~~~~~~

Mientras estás en modo insertar,
escribe el inicio de una palabra y presiona :kbd:`Crtl` + :kbd:`p` o :kbd:`Ctrl` + :kbd:`n` para iterar sobre las sugerencias.

Modo línea de comandos
~~~~~~~~~~~~~~~~~~~~~~

Neovim tiene otro modo, el modo línea de comandos.
Aparece debajo del editor donde puedes ingresar un comando,
luego de ejecutarlo (con :kbd:`Enter`) el editor retorna al modo normal.

¿Te suena familiar, no?,
¡ya lo has usado para guardar y salir!
Para ingresar a este modo teclea :kbd:`:` desde el modo normal.

De ahora en adelante cuando veas caracteres precedidos de ``:``
sabrás que me refiero a que ejecutes un comando en el modo línea de comandos.
Por ejemplo para guardar ``:w``.

.. note::

   Mientra estás en el modo línea de comandos puedes usar :kbd:`Tab` para autocompletar.

.. note::

   El comando ``:w`` es una abreviación de ``:write`` ¡pruébalo!

Trabajando con varios archivos
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Para trabajar con varios archivos solemos usar pestañas, Neovim tiene pestañas,
pero no son exactamente lo mismo que en los demás editores [#vim-buffers]_,
en su lugar usaremos ``buffers``.

Podemos abrir varios archivos desde la terminal con:

.. code:: sh

   nvim archivo-uno.txt archivo-dos.txt

O si ya tienes Neovim abierto,
puedes usar el comando ``:e <archivo>``,
por ejemplo ``:e archivo-uno.txt``.

Podrá parecer que no hay otro archivo abierto, pero lo hay.
Puedes listar todos los buffers con ``:ls``;
para cambiar al siguiente buffer usa ``:bnext`` y para el anterior ``:bprevious``;
para cerrar el buffer actual ``:bdelete``.

.. note::
  
   Los comandos ``:bn`` y ``:bp`` son una abreviación de ``:bnext`` y ``:bprevious``.

Buscar
~~~~~~

En modo normal presiona :kbd:`/`,
ingresa la palabra a buscar y presiona :kbd:`Enter`.
Muévete a la siguiente o anterior coincidencia con :kbd:`n` y :kbd:`N`.

Obteniendo ayuda
~~~~~~~~~~~~~~~~

Para obtener ayuda puedes usar el comando ``:help [tema]``,
por ejemplo ``:help :w`` para obtener ayuda sobre el comando ``:w``.

.. note::

   El comando ``:help`` puede ser abreviado como ``:h``.

Aprendiendo desde Neovim
~~~~~~~~~~~~~~~~~~~~~~~~

Neovim incluye un tutorial interactivo,
ejecuta el comando ``:Tutor`` para empezarlo.

Configurando Neovim
-------------------

Neovim puede ser configurado desde el modo línea de comandos,
prueba mostrando los números de las líneas ejecutando ``:set number``.
¿Quieres ver el nombre del archivo que estás editando en la ventana de la terminal? ``:set title``.

Si cierras Neovim, todas las configuraciones se perderán,
para mantenerlas se usa un archivo ``init.vim``,
el cual es cargado cada vez que se inicia Neovim.

init.vim
~~~~~~~~

.. note::

   Si usas Vim, este archivo cumple la misma función que el archivo ``.vimrc``.

Este archivo se localiza en ``~/.config/nvim/init.vim``, si no existe, créalo.

.. code:: sh

   cd ~/.config/
   mkdir nvim
   touch nvim/init.vim

Abre el archivo y agrega la línea:

.. code:: vim

   set number

Para que los cambios tengan efecto debes volver a abrir Neovim,
o puedes ejecutar el commando ``:so ~/.config/nvim/init.vim``.

El archivo de configuraciones puede llegar a ser muy grande,
así que trata de documentar todo lo que pongas sobre este
(puedes agregar comentarios con ``"``),
y no copies y pegues cualquier configuración sin entenderla,
así tendrás un ``init.vim`` ordenado.

.. note::

   Es recomendable poner tu ``init.vim`` sobre un sistema de control de versiones,
   como `git`_.

.. _`git`: http://www.git-scm.com

A continuación tienes un ``init.vim`` con algunas configuraciones mínimas.

.. gist:: abeb79100eba64184668fd3b1b13bff9

.. note::
   
   Para que los cambios de ``set termguicolors`` tomen efecto debes volver a abrir Neovim.

.. note::

   Para ver todos los temas escribe ``:colorscheme`` da un espacio y luego usa :kbd:`Tab` para iterar sobre estos.

Mappings
--------


Se ha usado varios comandos para interactuar con Neovim, pero no parece ser tan
productivo tener que escribirlos cada vez para cambiar de buffer o guardar un
archivo.

Neovim nos permite definir nuestros propios atajos de teclado (mappings). Por
ejemplo, si quisiéramos usar :kbd:`Ctrl` + :kbd:`s` para guardar,
bastaría con poner esta línea en el archivo `init.vim`.

.. code:: vim

   nnoremap <C-s> :w<CR>

A menudo verás combinaciones que usan ``<leader>``,
nos referiremos a esta como la tecla líder,
está reservada para atajos definidos por el usuario.
Por defecto la tecla líder es :kbd:`\\`,
pero es un poco difícil de teclear,
por lo que se suele usar la tecla :kbd:`Espacio` o :kbd:`,` como sustituto.

A continuación un par de mappings que te podrían ser de utilidad.

.. gist:: 4a02ce40968bf16050d96c4f8ec9e7cb

Configurando la terminal
------------------------

¿Sientes que tu terminal no encaja del todo con Neovim?

Ocultar la barra de menú
~~~~~~~~~~~~~~~~~~~~~~~~

La barra de menú que ves es la de tú terminal, no la de Neovim.

Accede al menú ``Editar`` y selecciona ``Preferencias``.
En la pestaña ``General`` desmarca ``Mostrar la barra de menús en las terminales nuevas por omisión``.

.. figure:: /images/nvim/hide-menu-bar.png
   :target: /images/nvim/hide-menu-bar.png
   :alt: Ocultar la barra de menú de la terminal en Ubuntu
    
   Ocultar la barra de menú de la terminal en Ubuntu

.. warning::
  
   Tendrás de volver a abrir la terminal para ver los cambios.

.. note::
   
   Si quieres ver las opciones para configurar tu terminal,
   presiona :kbd:`Shift` y luego da clic derecho sobre la terminal,
   o si prefieres hacerlo sin el mouse :kbd:`Shift` + :kbd:`F10`.

Ocultar las barras de scroll
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Cuando abres Neovim verás las barras de scroll horizontal y vertical de tu terminal,
pero si intentas usarlas, podrás darte cuenta que no funcionan como esperas.

Abre el menú de opciones de tú terminal y ve a ``Perfiles`` y a ``Preferencias del perfil``.
Dirígete a la pestaña ``Desplazamiento`` y desmarca la opción ``Mostrar barra de desplazamiento``.

.. figure:: /images/nvim/hide-scroll-bar.png
   :target: /images/nvim/hide-scroll-bar.png
   :alt: Ocultar la barra de scroll de la terminal en Ubuntu
  
   Ocultar la barra de scroll de la terminal en Ubuntu

.. note::
   
   Puedes moverte rápidamente hacia arriba o hacia abajo con :kbd:`Ctrl` + :kbd:`u` y :kbd:`Ctrl` + :kbd:`d`.

Tipo y tamaño de letra
~~~~~~~~~~~~~~~~~~~~~~

Para cambiar el tipo y tamaño de la letra de Neovim,
basta con cambiarla en la terminal.

Abre el menú de opciones de tú terminal y ve a ``Perfiles`` y a ``Preferencias del perfil``.
En la pestaña ``General`` marca ``Tipo de letra personalizado``,
y selecciona el tipo y tamaño de letra.

.. figure:: /images/nvim/custom-font.png
   :target: /images/nvim/custom-font.png
   :alt: Configurar el tipo y tamaño de letra de la terminal en Ubuntu

   Configurar el tipo y tamaño de letra de la terminal en Ubuntu

Resultado final
---------------

.. figure:: /images/nvim/final-nvim-ubuntu.png
   :target: /images/nvim/final-nvim-ubuntu.png
   :alt: Neovim final en Ubuntu

   Neovim final en Ubuntu

.. figure:: /images/nvim/final-nvim-fedora.png
   :target: /images/nvim/final-nvim-fedora.png
   :alt: Neovim final en Fedora

   Neovim final en Fedora

Alternativas
------------

¿Te gustaron ciertas características de Neovim pero no te atreves a abandonar tu actual editor?
Puedes hacerlo de manera progresiva o disfrutar varias de las características de Neovim sin usarlo de manera directa.

La mayoría de de editores e IDEs incluyen plugins para asemejarse a Vim/Neovim.
Los que recomiendo son:

- `Atom <http://atom.io>`_ + `Atom Vim mode plus <https://github.com/t9md/atom-vim-mode-plus>`_
- `IntelliJ IDEA <https://www.jetbrains.com/idea/>`_ y derivados (pycharm, webstorm, android studio, etc) + `IdeaVim <https://github.com/JetBrains/ideavim>`_
- `Eclipse <https://www.eclipse.org/>`_ + `Vrapper <https://marketplace.eclipse.org/content/vrapper-vim>`_

Conclusión y recomendaciones
----------------------------

Aprender a usar Neovim es duro,
pasará algún tiempo hasta que te sientas cómodo,
y para hacerlo, debes empezar desde ahora a usarlo.

No trates de memorizar todos los comandos que veas,
apréndelos conforme los necesites.

No llenes tu ``init.vim`` con configuraciones que no sabes lo que hacen,
ni copies totalmente las configuraciones de otras personas,
toma lo que vas a estar seguro que usarás.

Luego de aprender lo básico,
el siguiente paso es empezar a usar plugins y a aprender desde la documentación oficial de Neovim.

Recursos adicionales
--------------------

¿Interesado en aprender más?
Neovim es un reemplazo directo de Vim,
así que todo lo que aprendas para Vim podrás aplicarlo en Neovim.

Tutoriales online
~~~~~~~~~~~~~~~~~

- `Learn vim progressively <http://yannesposito.com/Scratch/en/blog/Learn-Vim-Progressively/>`_
- `Vim Tips & Tricks <https://bluz71.github.io/2017/05/15/vim-tips-tricks.html>`_
- `Learn X in Y minutes <https://learnxinyminutes.com/docs/vim/>`_

Cheat Sheets
~~~~~~~~~~~~

- `Graphical vi-vim Cheat Sheet and Tutorial <http://www.viemu.com/a_vi_vim_graphical_cheat_sheet_tutorial.html>`_
- `A Great Vim Cheat Sheet <http://vimsheet.com/>`_

Vídeos
~~~~~~

- `Vim casts <http://vimcasts.org/>`_
- `Vim meetups <https://www.youtube.com/watch?v=XA2WjJbmmoM&list=PL8tzorAO7s0jy7DQ3Q0FwF3BnXGQnDirs>`_

Libros
~~~~~~

- `Vim for humans <https://vimebook.com/>`_
- `Vim Galore <https://github.com/mhinz/vim-galore>`_
- `Learn Vimscript the Hard Way <http://learnvimscriptthehardway.stevelosh.com/>`_

Vídeo juegos
~~~~~~~~~~~~

- `Vim adventures <https://vim-adventures.com/>`_

Artículos
~~~~~~~~~

- `Moving to Neovim from Vim <https://jacky.wtf/weblog/moving-to-neovim/>`_

Dotfiles
~~~~~~~~

Los dotfiles no son más que archivos de configuración
(que usualmente empiezan con un ``.``, de ahí su nombre).
En varios dotfiles podrás encontrar configuraciones para Vim/Neovim que podrían serte útiles.

- `Dotfiles en GitHub <https://github.com/search?utf8=%E2%9C%93&q=dotfiles&type=>`_
- `Mis dotfiles <https://github.com/stsewd/dotfiles>`_

----

.. [#fork-no-clone] https://neovim.io/doc/user/nvim.html#nvim
.. [#configuraciones-defecto] https://github.com/neovim/neovim/issues/2676
.. [#configuraciones-defecto-documentacion] https://neovim.io/doc/user/vim_diff.html#nvim-defaults
.. [#emulador-terminal] https://neovim.io/doc/user/nvim_terminal_emulator.html
.. [#true-color] https://github.com/neovim/neovim/pull/2198
.. [#api-neovim] https://neovim.io/doc/user/api.html
.. [#home-row] http://www.dictionary.com/browse/home-row
.. [#portapapeles] El lugar donde se almacena lo que copias con :kbd:`Ctrl-c`.
.. [#vim-buffers] http://joshldavis.com/2014/04/05/vim-tab-madness-buffers-vs-tabs/
