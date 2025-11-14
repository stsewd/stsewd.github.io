.. title: Finding security-related commits on GitHub
.. date: 2025-11-13
.. category: security
.. tags: security, github
.. description: How to find commits that fix security issues on GitHub by searching for specific commit messages.

Did you know you can easily search for commits that fix security issues on GitHub?
Just search for commits with "Merge commit from fork" or "Merge pull request from GHSA".

Why this works?
When there is a security issue, some projects use `GitHub Advisories`_ to manage them.
GitHub allows you to create private pull requests to fix the issue in private.
However, when the pull request is merged,
GitHub strips the original commit message and replaces it with "Merge commit from fork", this can't be changed when using the GitHub UI.
In the past, it used to include a link to the advisory, so you can also search for "Merge pull request from GHSA", which is less generic.

.. _GitHub Advisories: https://docs.github.com/en/code-security/security-advisories/guidance-on-reporting-and-writing-information-about-vulnerabilities/privately-reporting-a-security-vulnerability

How can this be useful?

- If you're a nerd like me who enjoys reading code and learning about security issues, you can find interesting commits to read. Some big projects appear in the results ;)
- If you're a government-backed hacker looking for 0-days, you can monitor commits with these messages to find security issues that are not yet disclosed. Please don't...

Try it:

- Search for `Merge commit from fork <https://github.com/search?q=%22Merge+commit+from+fork%22&type=commits>`__
- Search for `Merge pull request from GHSA <https://github.com/search?q=%22Merge+pull+request+from+GHSA%22&type=commits>`__

Note: Did you find a commit from me? Don't worry, those are already fixed and disclosed issues ;)

If you are paranoid about people monitoring your project for commits like this,
you can merge the private pull request via the command line to preserve your original commit message.
Hopefully GitHub will allow customizing the commit message in the future from the UI.
This is the workflow I use when handling fixes from a security advisory:

- Create a private fork from the advisory.
- Set the fork as a remote: ``git remote add security-{advisory-id} <advisory-fork-url>``.
- Create a new branch: ``git checkout -b fix-security-issue-{advisory-id}``.
- Push the branch to the advisory fork: ``git push -u security-{advisory-id}``.
- Create a pull request in the advisory fork.
- When the fix is ready to be merged, do it via the command line:
  ``git checkout main && git merge security-{advisory-id} && git push origin main``.

That's all, hope you found this useful!
