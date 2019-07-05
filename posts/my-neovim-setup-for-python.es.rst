.. title: Mi Configuración de Neovim para Python
.. slug: my-neovim-setup-for-python
.. date: 2018-07-19
.. tags: neovim, python
.. status: draft
.. category: neovim
.. link:
.. description: Colección de plugins y configuraciones que uso en mi día a día con Python.
.. type: text

.. image:: /images/nvim/neovim-logo.png
   :target: /images/nvim/neovim-logo.png
   :alt: Logo de Neovim
   :align: center

.. contents:: Contenidos
   :depth: 2

¿Neovim?
--------

Si eres nuevo en Neovim, puedes leer :doc:`neovim-installation-configuration`.

Si haz usado Python por algún tiempo sabrás que es muy fácil de aprender y la vez muy poderoso.
Para programar en Python lo único que necesitas es un simple editor de código,
no hace falta tener un IDE muy potente.

Pero a veces necesitamos un poco de ayuda para ser más productivos al programar en Python.
A continuación mostraré algunos plugins y configuraciones que uso en mi día a día mientras programo en Python.

Configuraciones
---------------

Configuraciones dedicadas a Python.
Este archivo se encuentra en ``after/ftplugin/python.vim``.
Estas configuraciones serán habilitadas únicamente para archivos Python.

.. code:: vim

  " Indentación
  setlocal tabstop=8
  setlocal shiftwidth=4
  setlocal softtabstop=4
  setlocal expandtab

  " Folding
  setlocal foldmethod=indent
  setlocal foldnestmax=2
  setlocal foldlevel=1

  " Línea guía límite a los 80 caracteres
  setlocal colorcolumn=81


¿Sólo eso? ¡Si! uso otras configuraciones, pero son más generales.
Puedes encontrarlas en mis `dotfiles <https://github.com/stsewd/dotfiles/blob/master/config/nvim/init.vim>`__.

Si no te quedaron claro las configuraciones, a continuación te las explico.
Recuerda que también puedes usar la auyda de Neovim para saber qué hace cada opción ``:h '<opcion>'``.
Por ejemplo para conocer sobre ``tabstop``, usa ``:h 'tabstop'``.

Indentación
~~~~~~~~~~~

La guía de estilo oficial de Python recomienda usar cuatro espacion para identar tu código.

¿Entonces qué hace un ocho ahí? Hay veces que unas personas prefieren usar tabulaciones,
así que uso ``setlocal tabsto=8`` para distinguir tabulaciones de una indentación con 4 espacios.

¿Presionar cuatro veces la tecla espacio? Eso no es muy productivo,
pero con ``setlocal expandtab``, Neovim cambia (expande) cada tabulación a cuatro escpacios por ti.

Folding
~~~~~~~

Cuando abres archivos muy grandes,
la navegación por el código fuente puede complicarse.

*Foldeando* tu código te permite tener una vista más general.

.. figure:: /images/nvim-python-setup/folding.png
   :target: /images/nvim-python-setup/folding.png
   :alt: Folding
   
   Código *foldeado*

Los comandos básicos para trabajar con foldings son:

- :kbd:`zR` (expandir todos los folds)
- :kbd:`za` (abrir/cerrar un fold)

Más información en ``:h folding``.

Línea guía
~~~~~~~~~~

La guía de estilo oficial de Python recomienda que cada línea de tu código tenga un máximo de 80 caracteres.
Con esta opción podrás tener una ayuda visual para no pasarte de ese límite.

Plugins
-------

Si eres nuevos con plugins en Neovim, puedes leer :doc:`neovim-plugins`.

Resaltado de syntaxis
~~~~~~~~~~~~~~~~~~~~~

`requirements.txt.vim <https://github.com/raimon49/requirements.txt.vim>`__:
resaltado de syntaxis de archivos ``requirements.txt``.

.. code:: vim

   Plug 'raimon49/requirements.txt.vim', { 'for': 'requirements' }

`polyglot <https://github.com/sheerun/vim-polyglot>`__:
resaltado de syntaxis mejorado para Python (y otros lenguajes).

.. code:: vim

   Plug 'sheerun/vim-polyglot'

Navegación
~~~~~~~~~~

.. code:: vim

   Plug 'kana/vim-textobj-user'  " Base
   Plug 'kana/vim-textobj-indent'  " Indentation text object (i)
   Plug 'bps/vim-textobj-python', { 'for': 'python' }

.. code:: vim

   Plug 'kana/vim-altr'

Autocompletado
~~~~~~~~~~~~~~

.. code:: vim

   Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
   Plug 'zchee/deoplete-jedi'

Linter
~~~~~~

.. code:: vim

   Plug 'w0rp/ale'  " Async lint engine

Ir a
~~~~

.. code:: vim

   Plug 'davidhalter/jedi-vim', { 'for': 'python' }

Tests
~~~~~

.. code:: vim

   Plug 'janko-m/vim-test' " Tests execution
   Plug 'kassio/neoterm'  " Terminal wrapper

Django
~~~~~~

.. code:: vim

   Plug 'tweekmonster/django-plus.vim'

Varios
~~~~~~

.. code:: vim

   Plug 'stsewd/isort.nvim', { 'do': ':UpdateRemotePlugins' }
