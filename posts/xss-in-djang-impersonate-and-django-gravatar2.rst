.. title: XSS in django-impersonate 1.9.3 and django-gravatar2 1.4.4
.. date: 2025-02-08
.. category: security, python, django
.. tags: security, python, django, xss
.. description: Details about two cross-site scripting vulnerabilities that I reported to django-impersonate and django-gravatar2.

This post details two cross-site scripting (XSS) vulnerabilities I discovered in `django-impersonate <https://pypi.org/project/django-impersonate/>`__,
and `django-gravatar2 <https://pypi.org/project/django-gravatar2/>`__.
I'm writing about them together because they share the same vulnerability,
and are similar in other aspects that I'll explain below.

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
Searching for the usage of the `get_redir_field` function,
I found it was used in two views related to listing users:

- `/impersonate/views.py:106 (list_users) <https://hg.code.netlandish.com/~petersanchez/django-impersonate/browse/impersonate/views.py?rev=ed7f09b3bb9f2168888c15562e29471ea82373c2#L106>`__
- `/impersonate/views.py:134 (search_users) <https://hg.code.netlandish.com/~petersanchez/django-impersonate/browse/impersonate/views.py?rev=ed7f09b3bb9f2168888c15562e29471ea82373c2#L134>`__

But only the `template <https://hg.code.netlandish.com/~petersanchez/django-impersonate/browse/impersonate/templates/impersonate/search_users.html?rev=ed7f09b3bb9f2168888c15562e29471ea82373c2#L11>`__
rendered from the ``search_users`` view includes the result of the `get_redir_field` function.

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

   "><script>alert(document.domain)</script><input type="hidden

What this does is:

- Uses a ``"`` to close the ``value`` attribute.
- Injects a script that shows an alert with the current domain.
- Opens a new tag so the rest of the HTML is not shown as broken.

The payload injected into the template would look like this:

.. code-block:: html

   <input type="hidden" name="next" value=""><script>alert(document.domain)</script><input type="hidden"/>

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
- A popup with the domain of the page should appear

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

`django-gravatar2 <https://pypi.org/project/django-gravatar2/>`__ allows you to integrate Gravatar

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
- Not activily maintained.

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
