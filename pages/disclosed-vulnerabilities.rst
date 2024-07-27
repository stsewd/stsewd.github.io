.. title: Publicly disclosed security vulnerabilities
.. slug: disclosed-vulnerabilities
.. type: text

Publicly disclosed security vulnerabilities
===========================================

I have responsibly reported several security vulnerabilities; some of the public ones are listed below.

- Stored XSS via integration of external issues in Sentry: `CVE-2024-41656 <https://github.com/getsentry/sentry/security/advisories/GHSA-fm88-hc3v-3www>`__ (2024)
- XSS in django-allauth: Fixed in `0.63.6 <https://github.com/pennersr/django-allauth/commit/8fead343c1d3e75cc842e0ee1e21a39c6d145155>`__ (2024)
- XSS in django-impersonate: Fixed in `1.9.3 <https://lists.code.netlandish.com/~petersanchez/public-inbox/%3Ct5pgizrp24etpcgo3sdbt2kvtmltwjybjzojg7tknuhpr56ffx@vmsradru5t34%3E>`__ and `1.9.4 <https://lists.code.netlandish.com/~petersanchez/public-inbox/%3Cqqzbdqtfgq66igm55u4vmn3upan2coj2liclyson6krn2hfrv3@75qdhehcghri%3E>`__ (2024)
- Login CSRF in the SAML implementation of django-allauth: `Fixed in 0.63.3 <https://github.com/pennersr/django-allauth/commit/1f631a1bcd5062518a7ba437457242eadfd521ab>`__ (2024)
- Cross site scripting on beta dashboard in Read the Docs: `GHSA-8v7c-r4x6-h796 <https://github.com/readthedocs/readthedocs.org/security/advisories/GHSA-8v7c-r4x6-h796>`__ (2024)
- Denial of service via regular expression in Django Wiki: `CVE-2024-28865 <https://github.com/django-wiki/django-wiki/security/advisories/GHSA-wj85-w4f4-xh8h>`__ (2024)
- CAS session takeover in Read the Docs for Business: `GHSA-pw32-ffxw-68rh <https://github.com/readthedocs/readthedocs.org/security/advisories/GHSA-pw32-ffxw-68rh>`__ (2024)
- XSS in search integrations when including search results from malicious projects in Read the Docs: `GHSA-qhqx-5j25-rv48 <https://github.com/readthedocs/readthedocs.org/security/advisories/GHSA-qhqx-5j25-rv48>`__ (2024)
- Creation of integrations for any project in Read the Docs: `GHSA-45hq-g76r-46wv <https://github.com/readthedocs/readthedocs.org/security/advisories/GHSA-45hq-g76r-46wv>`__ (2023)
- Arbitrary command execution on Windows in Vim: `CVE-2023-4736 <https://huntr.dev/bounties/e1ce0995-4df4-4dec-9cd7-3136ac3e8e71/>`__ (2023)
- Untrusted search path on Windows systems leading to arbitrary code execution  in GitPython: `CVE-2023-40590 <https://github.com/gitpython-developers/GitPython/security/advisories/GHSA-wfm5-v35h-vwf4>`__ (2023)
- Blind local file inclusion in GitPython: `CVE-2023-41040 <https://github.com/gitpython-developers/GitPython/security/advisories/GHSA-cwvm-v4w8-q58c>`__ (2023)
- Arbitrary write to files from builder server in Read the Docs: `GHSA-v7x4-rhpg-3p2r <https://github.com/readthedocs/readthedocs.org/security/advisories/GHSA-v7x4-rhpg-3p2r>`__ (2023)
- Write access to projects via API V2 for any logged-in user in Read the Docs: `GHSA-rqfv-8rrx-prmh <https://github.com/readthedocs/readthedocs.org/security/advisories/GHSA-rqfv-8rrx-prmh>`__ (2023)
- CAS session hijacking in Read the Docs for Businesses: `GHSA-4mgr-vrh5-hj8q <https://github.com/readthedocs/readthedocs.org/security/advisories/GHSA-4mgr-vrh5-hj8q>`__ (2023)
- Serving content from pull requests previews on main docs domains in Read the Docs: `GHSA-h4cf-8gv8-4chf <https://github.com/readthedocs/readthedocs.org/security/advisories/GHSA-h4cf-8gv8-4chf>`__ (2023)
- Cache poisoning: serving arbitrary content on documentation sites in Read the Docs: `GHSA-mp38-vprc-7hf5 <https://github.com/readthedocs/readthedocs.org/security/advisories/GHSA-mp38-vprc-7hf5>`__ (2023)
- Arbitrary code execution when using treesitter with injections in Neovim: `GHSA-6f9m-hj8h-xjgj <https://github.com/neovim/neovim/security/advisories/GHSA-6f9m-hj8h-xjgj>`__ (2023)
- Path traversal: access to files from any project in Read the Docs: `GHSA-5w8m-r7jm-mhp9 <https://github.com/readthedocs/readthedocs.org/security/advisories/GHSA-5w8m-r7jm-mhp9>`__ (2023)
- Symlink following: arbitrary file access from builder server in Read the Docs: `GHSA-hqwg-gjqw-h5wg <https://github.com/readthedocs/readthedocs.org/security/advisories/GHSA-hqwg-gjqw-h5wg>`__ (2023)
- Cache poisoning in Read the Docs: `GHSA-7fcx-wwr3-99jv <https://github.com/readthedocs/readthedocs.org/security/advisories/GHSA-7fcx-wwr3-99jv>`__ (2023)
- Arbitrary command execution in simple-git: `CVE-2022-25860 <https://www.cve.org/CVERecord?id=CVE-2022-25860>`__ (2022)
- Symlink following: arbitrary file access from builder server in Read the Docs: `GHSA-368m-86q9-m99w <https://github.com/readthedocs/readthedocs.org/security/advisories/GHSA-368m-86q9-m99w>`__ (2022)
- Allow serving of arbitrary HTML files from the main domain in Read the Docs: `GHSA-98pf-gfh3-x3mp <https://github.com/readthedocs/readthedocs.org/security/advisories/GHSA-98pf-gfh3-x3mp>`__ (2022)
- CSRF from documentation domains in Read the Docs: `GHSA-3v5m-qmm9-3c6c <https://github.com/readthedocs/readthedocs.org/security/advisories/GHSA-3v5m-qmm9-3c6c>`__ (2021)
- Serving arbitrary files in domains of other projects in Read the Docs: https://docs.readthedocs.io/en/stable/security.html#release-2-3-0 (2018)
