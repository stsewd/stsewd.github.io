.. title: Files navigation in Neovim and more
.. date: 2019-09-06
.. category: neovim, fzf, plugins, nerdtree, navigation
.. description: How to navigate files and more in Neovim

If you work in a project with more than one file,
probably you'll be changing files very frequently or
search for a file that contains the code or text you are interested in.

I'll show you how I navigate in files from a project in Neovim and more.

File system tree
================

When you are new in a project, you'll want to know:

- How it's organized
- Where the current file is located
- What other files are around the file you are right now
- Where is the test of the current file
- Or if you are a C/Cpp programmer, where the header file is

NerdTree
--------

If you need to know the structure of a project you can use the ``tree`` command.
But, if you are already in Neovim, you can use the `NerdTree plugin <https://github.com/scrooloose/nerdtree>`__.

.. image:: /images/file-navigation-neovim/nerdtree.png
   :target: /images/file-navigation-neovim/nerdtree.png
   :alt: NerdTree
   :align: center

|

You can install it with `vim-plug <https://github.com/junegunn/vim-plug>`__:

.. code-block:: vim

   Plug 'scrooloose/nerdtree'

I have these settings for NerdTree:

.. code-block:: vim

   let g:NERDTreeChDirMode = 2  " Change cwd to parent node
   
   let g:NERDTreeMinimalUI = 1  " Hide help text
   let g:NERDTreeAutoDeleteBuffer = 1
   
   nnoremap <leader>n :NERDTreeToggle<CR>
   nnoremap <leader>N :NERDTreeFind<CR>

So, if I want to see the project structure I just press :kbd:`<leader> + n`.
If I want to see the files that are around the current file, I just press :kbd:`<leader> + N`.
   
If you like icons, you can get it in NerdTree with `Vim devicons <https://github.com/ryanoasis/vim-devicons>`__.

You can navigate on NerdTree like any other buffer.
For more information, read the manual ``:help NerdTree.txt``.

FZF & Ripgrep
=============

`FZF <https://github.com/junegunn/fzf>`__ is an interactive fuzzy finder for the command line that can be used with any list.

`Ripgrep <https://github.com/BurntSushi/ripgrep>`__ is an alternative to ``grep``,
it respects your ``.gitignore`` file by default.
And it's super fast.
Ripgrep can be used together with FZF.

You can install ripgrep with:

.. code-block:: bash

   # Ubuntu
   sudo apt install ripgrep

   # Fedora
  sudo dnf install ripgrep



FZF has a plugin for neovim, you can install it with:

.. code-block:: vim

   Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
   Plug 'junegunn/fzf.vim'  " General fuzzy finder

You can pass it the list results from any command.
By default it uses the ``find`` command.

Files & Buffers
---------------

FZF files

Fuzzy Search
------------

Global search, line search

Git
---

Show what I did to change branches
