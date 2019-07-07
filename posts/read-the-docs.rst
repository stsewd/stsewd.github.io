.. title: Read the docs
.. slug: read-the-docs
.. date: 2019-07-06
.. tags: read the docs, documentation
.. category: documentation
.. description: When we write software, people tell us to write docs for it, but we forgot to read the docs very often
.. type: text

When we write software,
people tell us to write docs for it.
But when we use software,
we forgot to read their docs very often.

A couple of days ago,
I was struggling to remember what the format in ``/etc/passwd`` means.
Immediately I search for it in Google and found a blog post about it.
Then I stopped to ask myself: why are you searching this on Google and reading it from a blog post?
This should be documented in Linux itself!

After a minutes, I found the `manpage <https://en.wikipedia.org/wiki/Man_page>`__ for it
(it was the same content of the blog post!).
Then I realized that so many times I search for things in other sites
but their official documentation.

So, in the next paragraphs I'm going to tell you (or remind you)
where you can search for the official docs of common development tools.

Linux command docs
~~~~~~~~~~~~~~~~~~

``--help`` or ``-h``,
probably one fo the most obvious options that we check before executing a command in the terminal,
and that most of the tools have.
Here you can see the list of options and a short description of what that option does.

Its common usage is:

.. code:: bash

   command --help

Example:

.. code:: bash

   ls --help

or

.. code:: bash

   command subcommand --help

Example:

.. code:: bash

   git add --help

Man pages,
most of the Linux tools has a respective man page (apart from the ``--help`` option).
Man pages have a more detailed documentation than the ``--help`` option from the command.

Most of the time you'll need to run:

.. code:: bash

   man command

Example

.. code:: bash

   man ls

But not only commands have man pages,
it also includes documentation of the format used in some configuration files,
kernel functions, libraries (usually the ones used in C).

How to access to those man pages?
Each man page belongs to a section,
each section is represented by a number::

  1   Executable programs or shell commands
  2   System calls (functions provided by the kernel)
  3   Library calls (functions within program libraries)
  4   Special files (usually found in /dev)
  5   File formats and conventions eg /etc/passwd
  6   Games
  7   Miscellaneous (including macro packages and conventions), e.g. man(7), groff(7)
  8   System administration commands (usually only for root)
  9   Kernel routines [Non standard]

Knowing the section you can get the man page with:

.. code:: bash

   man <section> keyword

Example:

.. code:: bash

   man 1 ls
   man 2 fork
   man 3 printf
   man 5 /etc/passwd

Some times the result from the ``--help`` option or
from the man pages can be very extensive,
and difficult to extract what you need,
or missing clear examples.

Fortunately there is the `tldr <https://github.com/tldr-pages/tldr>`__ project,
which has community-driven simplified man pages with common usage examples.

Did you always forget the correct options to untar a file?

.. code:: bash

   tldr tar

     Archiving utility.
     Often combined with a compression method, such as gzip or bzip.
     More information: <https://www.gnu.org/software/tar>.

   - Create an archive from files:

     tar -cf target.tar file1 file2 file3

   - Extract an archive in a target directory:

     tar -xf source.tar -C directory

   ...

If you use Python,
you can install it using ``pip install tldr``.

From your editor
~~~~~~~~~~~~~~~~

It's useful to setup your editor to show you the documentation from the name that your cursor is under.
Take a look at `langserver <https://langserver.org/>`__ for a *global* solution and
install the proper plugin for your editor.

I use `Neovim <https://neovim.io/>`__ as my main editor.
So I'm going to tell you what I currently use in Neovim.

First, in Neovim you have the ``:help`` command to get the help of the editor itself.
Neovim also offers the ``K`` command,
which runs a program to lookup the keyword under the cursor.
This program can be setup for different file types,
see ``:help K``.

For instance, try this C code and press ``K`` under the ``printf`` function.

.. code:: c

   #import <stdio.h>

   int main() {
       printf("Hello, world\n");
       return 0;
   }

For a general and *nicer* solution I use the `coc plugin <https://github.com/neoclide/coc.nvim>`__.

Online documentation
~~~~~~~~~~~~~~~~~~~~

Some libraries or programs don't include their documentation when you downloaded it,
but probably they have their documentation online.
Note that I'm not referring to a blog post or a tutorial.

How do you know where to find the online documentation?

- Most of the time you can find a link to the documentation in the web site of the library or project.
- Some times you can find a link to the online documentation in the repository page
  (like in the ``README`` file).
- You can also find a link to their documentation in the package page
  (like npm or pypi).
- If everything else fails, you can just use Google to find it.

By the way,
for Python packages,
most of the time they have their documentation hosted in https://readthedocs.org/.

Python docs
~~~~~~~~~~~

I'm a Python developer,
so searching for docs from methods and functions is my daily task.

When I'm not inside my editor, I use these methods:

The help function
'''''''''''''''''

Python has a built in function called ``help``,
you can use it inside the interpreter like this:

.. code:: python

   >>> help(open)
   >>> my_string = 'hello world'
   >>> help(my_string.upper)

The argument can be any function, method, object or module.

pydoc
'''''

`pydoc <https://docs.python.org/3/library/pydoc.html>`__ is a command line tool shipped with Python.
It's what the ``help`` function uses under it.
You can use it from your terminal like this:

.. code:: bash
    
   pydoc open

The official online docs
''''''''''''''''''''''''

For a more extensive documentation,
with several common usage examples.
See the online docs in https://docs.python.org/.

Conclusions
~~~~~~~~~~~

If you ever find yourself reading the usage instructions for a tool or method/function from another site having the official docs at hand,
probably is because:

#. The project doesn't have docs (not so common) -- Help to written if it's the case!
#. The project doesn't have good documentation (a little more common) -- Help to improve it if it's the case!
#. The documentation isn't written in the language you know (very common) -- Help to translate it if it's the case!
