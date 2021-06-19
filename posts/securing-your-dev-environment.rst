.. title: Securing your development environment
.. date: 2021-07-24
.. category: security, development
.. description: Tips on how to secure how to secure your development environment from your computer to your terminal.

If you are a developer, chances are that you handle private code or production secrets.
If someone has access to those, you may be in serious problems with your bosses and clients.
I'll share with you some tips on how to secure your development environment **from your computer to your terminal**.

.. note::

   In this post I'd recommend some tools,
   for their usage please check their respective documentation,
   or search for alternatives for your Operating System.
   For some tools I have my configuration available at https://github.com/stsewd/dotfiles.

.. contents:: Contents
   :depth: 2
   :local:
   :backlinks: none

Passwords
---------

Using an strong password is good, but using the same password for each login isn't good,
if one system is compromised, **all your** accounts could be compromised.
The best password is the one that not even you know,
a password manager can help you to generate strong and unique passwords for each login.

Using a password manager requires you to have one master password,
this one you do need to remember,
so make sure to choose a strong one, and rotate that password every year or so.

.. figure:: /images/securing-your-dev-environment/password_strength.png
   :target: https://xkcd.com/936/
   :align: center

I recommend `Bitwarden <https://bitwarden.com/>`__ as password manager, it's Open Source.
The free version gives you a lot of features that usually require
a premium account in other services, and even the premium version is cheap.

Multi factor authentication
---------------------------

But even using a password manager isn't enough to protect your accounts,
the generated password could be exposed without you knowing it,
or your master password could be compromised.
Multi factor authentication (MFA) to the rescue!

MFA is about using two or more pieces of evidence on authentication to be able to access a website or application [#mfa]_.
Your password is one factor (something you know),
the second factor is usually something you have.
Common ways of MFA are:

SMS
  This is using your phone number to receive a code via SMS to be able to authenticate.
  **Please don't use this method**, it's easy for an attacker to hijack your phone number [#sim-hijack]_,
  and if you are traveling, you won't be able to receive the codes.

App
  This is using an application in your phone that generates an OTP [#otp]_
  valid for 30 seconds for each login.
  Using an app is an excellent way of MFA,
  and you don't need Internet connection on your phone to be able to access the tokens.

  An app that I recommend is `andOTP <https://github.com/andOTP/andOTP>`__,
  it's Open Source, and has several features like using a PIN to unlock the codes,
  and making encrypted offline backups.

  When choosing an app, **don't use those that sync your codes to the cloud**,
  that kind of breaks the rule about something you (and only you) have.

Hardware keys
  They are similar to an app, they can provide an OTP,
  but the good thing is that they aren't attached to your phone.
  Popular hardware keys are `YubiKeys <https://www.yubico.com/>`__.
  **If you decide to get one, buy two!**
  The second key will act as your backup in case you lose or damage the other one.

  .. figure:: /images/securing-your-dev-environment/yubikey.png
     :target: https://commons.wikimedia.org/wiki/File:YubiKey-4-keychain-and-YubiKey-4-Nano.png
     :width: 50%
     :align: center

Not all services support MFA, but make sure to take some minutes to set it for those that do.
Most services will give you recovery codes in case you lose access to your MFA device,
**save them offline and in a secure location**!

Full disk encryption
--------------------

If someone steals your computer,
they can access all your files without having to know your user's password.
To prevent this, make use of full disk encryption on your computer.

On Linux systems, this is usually an option on installation
You could even make use of your YubiKey to protect your disk
(your password + an static password from your YubiKey).

.. note::

   Is also a good idea to automatically lock your computer on inactivity.

Securing your code
------------------

Even if you use full disk encryption,
if someone steals your computer while you are logged in,
they will have access to all your files and active sessions.
Sure, you can revoke your active sessions,
but doing so could take some time, and isn't possible to revoke access to your files.

In addition to full disk encryption you can encrypt individual directories, and set a lifetime.
This way your files will be secure even if someone has access to your un-locked computer.
A simple tool to archive this is `encFS <https://github.com/vgough/encfs>`__ (check for the ``-i`` option).

Is common to use SSH authentication with your version control system (VCS) provider
to avoid entering your password every time,
but this leaves the door open for anyone with access to your computer.
**Protect your private key with a passphrase,
and set a lifetime to your SSH agent** (``-t`` option, see ``man ssh-agent``),
this way you'll need to re-enter your passphrase every ``t`` minutes/hours.

Signing your commits
--------------------

Using a VCS like Git for your code is great
(you do have your code under a VCS, right?),
it allows you to keep track of your changes, revert changes, and more!
It is also useful to know who changed a particular piece of code and when,
which is great when doing audits over your code base.

But in fact, anyone can say to be you when committing changes,
Git for example makes use of a configuration file to set your name and email,
you don't need to provide anything else to say that you are that person!

This means that any of your coworkers could impersonate you,
or an attacker with access to your VCS provider could do so as well.
You don't want to be responsible for changes that you didn't make!

Luckily, Git allows you to sign your commits with a GPG key.
Someone could still use your email for their commits,
but they won't be able to sign those commits with your private GPG key.
GitLab has a great guide on how to sign your commits with GPG
https://docs.gitlab.com/ee/user/project/repository/gpg_signed_commits/.

.. figure:: /images/securing-your-dev-environment/signed-commit.png
   :target: /images/securing-your-dev-environment/signed-commit.png
   :align: center

   Commit signed (verified) on GitHub

.. note::

   Same as SSH, protect your private GPG key with a passphrase,
   and set a lifetime to your GPG agent (``default-cache-ttl`` and ``max-cache-ttl`` options, see ``man gpg-agent``).

Securing your terminal
----------------------

The terminal is a great friend,
and navigating the history with ``↑`` ``↓`` save you some typing,
but that history can also contain sensitive information.

The default number of history entries is usually high,
as a quick experiment, you can check how many entries you have with:

.. code:: bash

   cat $HISTFILE | wc -l

And how many of those entries possibly have secrets with:

.. code:: bash

   grep -E -i '(token)|(pass)|(secret)' $HISTFILE

Depending on the Shell you are using,
you can control the max number of entries with environment variables,
for zsh this is done with:

.. code:: bash

   export SAVEHIST=1000
   export HISTSIZE=$SAVEHIST

Choose the number of entries at your discretion,
not big enough that will keep things for a long period of time,
and not so small to not save you some typing.

Some times you need to enter secrets in your terminal,
but you don't want to save them in your history.
You can avoid adding your commands to the history
by prefixing them with a space.

Another way to enter into *incognito mode* is by un-setting the ``$HISTFILE`` environment variable
(thanks `@WhiteHatTux <https://github.com/WhiteHatTux>`__ for this tip!).

.. code:: bash

   unset HISTFILE


Securing your files and environment variables
---------------------------------------------

If you have files with sensitive information
that you can't encrypt because it needs to be readable (like configuration files),
at least give access only the appropriate users/processes.

To remove access from all users except yours, you can use:

.. code:: bash

   chmod og-rwx {file}

For extra protection, check the `SELinux <https://selinuxproject.org/page/Main_Page>`__ project.

If you need to expose some environment variables with secrets to your commands.
You can use `direnv <https://direnv.net/>`__ with an encrypted directory.
This way the environment variables will be set only when you are on that directory.

Securing your browser
---------------------

- If you are using a network that you don't have control over,
  use a VPN to connect to the Internet.
  `ProtonVPN <https://protonvpn.com/>`__ is a good free option.
- Take some time hardening your browser settings,
  for Firefox for example,
  I use `these <https://github.com/stsewd/dotfiles/blob/master/firefox-about.txt>`__.
- Use extra extensions to secure your browser:
  like disabling cookies and JS for unknown sites.
- Use a separate `profile <https://support.mozilla.org/en-US/kb/profile-manager-create-remove-switch-firefox-profiles>`__ for work.

Email
-----

Don't load external content by default.
This is usually an option in your email client,
`Protonmail <https://protonmail.com/>`__ has this option enabled by default.


.. figure:: /images/securing-your-dev-environment/gmail-disable-display-external-images.png
   :target: /images/securing-your-dev-environment/gmail-disable-display-external-images.png
   :align: center

   Option to disable loading external images on Gmail.

Use a secure channel for communication
--------------------------------------

Sometimes you'll need to share passwords or private information with other coworkers.
Use a secure channel with end to end encryption to do so (and delete the messages after you are done),
or use a password manager for your team,
or encrypt the secrets with their public GPG key.

Extra paranoia
--------------

- Avoid wireless devices when possible.
- Search for security related settings on every application you use.
- Be careful with the personal information you share with others.
- Use two phone numbers and two computers.
- Shred any document before throwing it to the trash.

Conclusions
-----------

Everything is about encryption and lifetimes.

In perfect conditions, you should have a dedicated computer for work,
and connect to the Internet using a secure network,
but this isn't always possible or provided by your employer.
Still, it's always good to have several layers of protection when handling sensitive information.

Did you already knew some of these tips?
Or do you have more to share?
Let me know in the comments!

----

.. [#mfa] https://en.wikipedia.org/wiki/Multi-factor_authentication
.. [#sim-hijack] https://en.wikipedia.org/wiki/SIM_swap_scam
.. [#otp] https://en.wikipedia.org/wiki/One-time_password
