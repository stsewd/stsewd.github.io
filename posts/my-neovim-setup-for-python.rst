.. title: Mi Neovim Setup for Python Development
.. slug: my-neovim-setup-for-python
.. date: 2018-07-19
.. tags: neovim, python, draft
.. category: neovim
.. link:
.. description: Colección de plugins y configuraciones que uso en mi día a día con Python.
.. type: text

.. image:: /images/nvim/neovim-logo.png
   :target: /images/nvim/neovim-logo.png
   :alt: Logo de Neovim
   :align: center

Neovim?
-------

English

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

.. code:: vim

  " Indentación
  setlocal tabstop=8
  setlocal shiftwidth=4
  setlocal softtabstop=4

  " Folding
  setlocal foldmethod=indent
  setlocal foldnestmax=2
  setlocal foldlevel=1

  " Línea guía límite a los 80 caracteres
  setlocal colorcolumn=81


¿Sólo eso? ¡Si! uso otras configuraciones, pero son generales.
Puedes encontrarlas en

Plugins
-------

Si eres nuevos con plugins en Neovim, puedes leer :doc:`neovim-plugins`.
