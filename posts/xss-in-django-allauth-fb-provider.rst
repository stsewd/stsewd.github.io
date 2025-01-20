.. title: XSS in django-allauth <0.63.6
.. date: 2025-01-19
.. category: security, python, django
.. tags: security, python, django, xss
.. description: Details about a cross-site scripting vulnerability that I reported to django-allauth.

This post details a Cross-Site Scripting (XSS) vulnerability I discovered in `django-allauth <https://allauth.org/>`__, a popular Django package for authentication.
This vulnerability affected the Facebook provider only, and it was fixed in version `0.63.6 <https://allauth.org/news/2024/07/django-allauth-0.63.6-released/>`__ on July 12, 2024.

Background
----------

Before I found this vulnerability, I already reported another one to django-allauth,
a login CSRF vulnerability in its SAML provider, which was fixed in version `0.63.3 <https://docs.allauth.org/en/latest/release-notes/recent.html#id34>`__
(maybe I'll write a post about it if people are interested in more posts like this).

At `Read the Docs <https://about.readthedocs.com/>`__, we use django-allauth for user authentication.
I was in charge of integrating SAML into our authentication system, while working on that I noticed the CSRF vulnerability.
After reporting it and seeing how quick it was fixed, I decided to do a quick security audit of the project.

The vulnerability
-----------------

After grepping the codebase for common vulnerable patterns, I found this line of code that caught my attention:

.. raw:: html

   <iframe frameborder="0" scrolling="no" style="width:100%; height:121px;" allow="clipboard-write" src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2Fpennersr%2Fdjango-allauth%2Fblob%2F1512ac4fe0353d7a8d795c5e8b89a07f3a9a31f5%2Fallauth%2Fsocialaccount%2Fproviders%2Ffacebook%2Fprovider.py%23L179-L180&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showFullPath=on&showCopy=on"></iframe>

django-allauth `allows using Facebook as a provider for social authentication <https://docs.allauth.org/en/latest/socialaccount/providers/facebook.html>`__,
and allows using the regular form (``oauth2`` method) or the Facebook JavaScript SDK (``js_sdk`` method) to login.
When using the ``js_sdk`` method, the ``fb_data`` variable is passed to the template to be used in the frontend.

.. raw:: html

   <iframe frameborder="0" scrolling="no" style="width:100%; height:163px;" allow="clipboard-write" src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2Fpennersr%2Fdjango-allauth%2Fblob%2F1512ac4fe0353d7a8d795c5e8b89a07f3a9a31f5%2Fallauth%2Fsocialaccount%2Fproviders%2Ffacebook%2Ftemplates%2Ffacebook%2Ffbconnect.html&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showFullPath=on&showCopy=on"></iframe>

Which is then used in the `fbconnect.js <https://github.com/pennersr/django-allauth/blob/1512ac4fe0353d7a8d795c5e8b89a07f3a9a31f5/allauth/socialaccount/providers/facebook/static/facebook/js/fbconnect.js#L32>`__
script to initialize the Facebook SDK.

So, what's the problem here?
The ``fb_data`` variable is `marked as safe <https://docs.djangoproject.com/en/4.2/ref/utils/#django.utils.safestring.mark_safe>`__
(Django won't escape it when including it in a template)
after being transformed into a JSON string.
Since ``json.dumps`` doesn't escape HTML characters,
it's possible to inject arbitrary HTML and JavaScript code into the template.

Exploitation
------------

Using ``mark_safe`` by itself is not a vulnerability,
as long as the content is trusted and doesn't contain user input.
So the next step was to find a way to inject user-controlled content into the ``fb_data`` variable.

As shown below, most of the content in the ``fb_data`` variable is static:

.. raw:: html

   <iframe frameborder="0" scrolling="no" style="width:100%; height:394px;" allow="clipboard-write" src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2Fpennersr%2Fdjango-allauth%2Fblob%2F1512ac4fe0353d7a8d795c5e8b89a07f3a9a31f5%2Fallauth%2Fsocialaccount%2Fproviders%2Ffacebook%2Fprovider.py%23L164-L178&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showFullPath=on&showCopy=on"></iframe>

Except for ``loginOptions``, which includes the value from the ``scope`` query parameter:

.. raw:: html

   <iframe frameborder="0" scrolling="no" style="width:100%; height:205px;" allow="clipboard-write" src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2Fpennersr%2Fdjango-allauth%2Fblob%2F1512ac4fe0353d7a8d795c5e8b89a07f3a9a31f5%2Fallauth%2Fsocialaccount%2Fproviders%2Ffacebook%2Fprovider.py%23L139-L144&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showFullPath=on&showCopy=on"></iframe>

.. raw:: html

   <iframe frameborder="0" scrolling="no" style="width:100%; height:268px;" allow="clipboard-write" src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2Fpennersr%2Fdjango-allauth%2Fblob%2Fc11e1429d90aa12373fb97705e18b1d8c602c417%2Fallauth%2Fsocialaccount%2Fproviders%2Foauth2%2Fprovider.py%23L83-L91&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showFullPath=on&showCopy=on"></iframe>

With that, we now can inject arbitrary HTML and JavaScript using the ``scope`` query parameter.

But wait... In which page can we control the ``scope`` query parameter?
By following the code, I found that ``media_js`` is used in the ``providers_media_js`` template tag,
which is called in the `login_extra.html <https://github.com/pennersr/django-allauth/blob/0.63.5/allauth/templates/socialaccount/snippets/login_extra.html>`__ snippet,
and furthermore that snippet is included anywhere the social providers are listed,
like the login page (``/accounts/login/``), and the social account connections page (``/accounts/3rdparty/``).

Payload
-------

To exploit this vulnerability, an attacker could inject the following content in the ``scope`` query parameter:

.. code-block:: html

   </script><script>alert(document.domain)</script><script>

What this does is:

- Closes the ``script`` tag containing the ``fb_data`` variable.
- Injects a script that shows an alert with the current domain.
- Opens a new ``script`` tag, so the rest of the JSON content is not shown as plain text.

Proof of concept
----------------

I created a `proof of concept <https://github.com/stsewd/poc-xss-django-allauth>`__ to demonstrate the vulnerability, so you can see it in action,
you just need to have Python and `uv <https://docs.astral.sh/uv/getting-started/installation/>`__ installed:

It consists of a simple Django project with ``django-allauth==0.63.5`` installed, and a Facebook provider configured using the JavaScript SDK.

.. code-block:: bash

   $ git clone https://github.com/stsewd/poc-xss-django-allauth
   $ cd poc-xss-django-allauth
   $ uv run manage.py migrate
   # Create a user to log into the application.
   $ uv run manage.py createsuperuser
   $ uv run manage.py runserver

XSS in login page:
  - While logged out, go to ``http://127.0.0.1:8000/accounts/login/?scope=</script><script>alert(document.domain)</script><script>``.

XSS in social connections page:
  - Go to ``http://127.0.0.1:8000/accounts/login/``.
  - Log in with the user you created.
  - Go to ``http://127.0.0.1:8000/accounts/3rdparty/?scope=</script><script>alert(document.domain)</script><script>``.

Showing an alert is just a simple example,
but an attacker can execute any JavaScript code in the context of the user's session.

Mitigation
----------

You should never mark user-controlled content as safe,
but if you find yourself wanting to include JSON content in a template,
escaping will break the JSON format.

Luckily, Django has a built-in template filter to include JSON content in a template safely,
`json_script <https://docs.djangoproject.com/en/4.2/ref/templates/builtins/#json-script>`__.
Sadly, that filter wasn't available at the moment the allauth code was written, but it's been available since Django 2.1,
since allauth supports newer versions of Django,
it was possible to use it, as you can see in the `fix <https://github.com/pennersr/django-allauth/commit/8fead343c1d3e75cc842e0ee1e21a39c6d145155>`__.

Timeline
--------

- 11/07/2024: Found and reported the vulnerability to django-allauth.
- 12/07/2024: Maintainer confirmed the vulnerability and released version 0.63.6 with the fix.

Acknowledgements
----------------

- I'm always surprised by how quickly open source maintainers fix security vulnerabilities
  (so much faster than commercial software vendors), kudos to `Raymond Penners <https://github.com/pennersr/>`__, maintainer of django-allauth.
- It's also great I have the support at Read the Docs to spend part of my work time on security audits on packages we use.
  Even if the vulnerabilities don't affect our systems directly (we don't use the Facebook provider),
  it's nice to have the chance to give back to the community.

Are you still using django-allauth ``<0.63.6``? The fix was released more than 6 months ago, please update your dependencies!
Thank you for reading, and let me know if you'd like to see more posts like this!
