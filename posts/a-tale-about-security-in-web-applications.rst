.. title: A tale about security in web applications, or how I helped to save a bank from bankruptcy
.. date: 2021-06-18
.. category: security, experience
.. description: A short tale about the importance of good security practices while developing or auditing safe critical systems.

Hi friend, today I'm going to tell you a little story.
Some things may look familiar, or even you could feel related to some situations.
I assure you, **it's mere coincidence**.

A new experience
----------------

This tale takes place in Ecuador.
It was during the lockdown that some friends contacted me to help them with a security audit.
They were forming a team (with special abilities?),
and there was missing someone with programming/web skills.

I was a little nervous to say yes,
since I haven't had much experience with security in the field.
But it was comforting to know that my teammates had vast experience in it.
I was excited to learn new things from them, and how the world of security, auditing, and banking works.
Oh, and I would get one of those fancy permits (salvoconducto) to go outside during lockdown.

- Wait, "banking"?
- Oh, sorry I didn't tell you, the security audit was for a small bank.

First flight
------------

And *the day* arrived.
We started with their homepage, and some small web applications.
It didn't take me much time to start finding small security bugs.
And then not so small, but not *that* critical either,
mostly things returning too much data or returning data when they shouldn't.
And it was from some old applications, so there wasn't much surprise in there,
and the data exposed wasn't from all their clients.

After reporting some of those bugs that seemed important to get fixed soon
we moved on to our next target: **the online banking application**.

We started with a black box test (no user).
It wasn't long since we started to find minor security bugs.
And we found some indications that the API may not be doing an appropriate check for authorization,
but without a user, it wasn't easy to guess (yet!).

- What indications?
- Well, most of their APIs required a user ID to be present in the request.
  So, instead of relying on some session cookie or authorization token previously validated by the server,
  **they were asking the client to explicitly pass the user's ID**.
- Oh, I see, that smells bad.

Access granted
--------------

After we got tired of guessing what some APIs would do and their parameters,
we created a new user and started our gray box testing.
The first thing we did was to check those precious API requests,
the parameters being sent, cookies, etc.
And then, the test we all were waiting for.
Changing the user from the request to another one...
Bingo! We got access. I mean, **damn, we got access???**

After that shocking reveal, we kept digging for more endpoints to test.
The obvious one was to try to transfer money from/to other accounts, but there was a little problem.
An OTP_ was required for each transaction.
So we first made a real transaction to check how the API works...
We realized that the OTP wasn't needed at all! **It was being validated from the client side!**
So, yes, we were able to transfer money to any account **and** from any account.
The user IDs were all incremental,
which means that you could easily steal money from everyone in the bank.

.. _OTP: https://en.wikipedia.org/wiki/One-time_password

- Damn! THAT IS SHOCKING! Someone could have easily emptied the accounts of everyone!
  But it would have been very obvious if it has happened.
- Or just steal 50 cents from everyone in the bank each month.
  Do you really know exactly how much money do you have in your bank account?
  Would you even care if only 50 cents were missing?
- That's a low and long game to play, but still easy to track.
- Or you could just buy things, and pay with a wire transfer.
  That way the money goes to several people instead of just one.
  There are more ways you could exploit this without anyone noticing it, for sure.

Interlude - about boxes
-----------------------

- So, you did a black and gray box tests, is there a white one? and what those colors mean?
- The color thing is about how much information and access you have to the application.
  In a black box test, you don't know anything about the system internals.
  In a gray box test, you have some knowledge of the application, like the architecture,
  technologies being used and intern access to the application (like a user!).
  And finally the white one, you have access to the source code.
  But we didn't do that one.

Consequences
------------

At this point more than shocked, **I was scare and disappointed**.
Scare of knowing this vulnerability existed and was **easy to exploit**.
The money from all the people was in danger, maybe even their lives!
And disappointed to know that this application has been sold to this bank (and others!) for a lot of money,
and the company behind it has been doing so for more than 15 years.
And also, that all these banks have been for many security audits,
and **NO ONE** found any of the things we reported.

- What do you mean with their lives were in danger?
- You could disagree with me on this one,
  personally I think that a bank is a SCS_,
  Nothing good can happen
  if something goes wrong with people's money,
  or all their savings.
- No one found that after several audits? WOW! Why do you think they missed them?
  And how the developers missed that!?
- Sadly. Laziness, inexperience and negligence.
  Here people don't like to go very *technical*,
  but instead go with degrees and certifications ($$$).
  And when doing the audit, they only run automated tools
  without doing any manual checking, or trust that the apps are secure,
  or everyone in the team knows only about networking.
  And from the developers side, what can I say?
  Most developers here don't know what a unit test is,
  or are afraid to say "I'm not qualified to build this, we need someone else".

.. _SCS: https://en.wikipedia.org/wiki/Safety-critical_system

Not surprised
-------------

I can't say this was *that* shocking,
I mean, I have seen things like this on several apps in my country before,
but seeing this happening in a bank... that's another thing.

- So, what happened after you reported this?
- Well, the company behind the application negated that the bug existed,
  but we provided enough proofs in our report that invalidated all those claims.
  And they even charged the bank for fixing those vulnerabilities.
- WTF? That's unethical.
- Yeah, but sadly I learned that's how the banking/enterprise world works.

**We found more shocking things**, but I may tell you that in another occasion.

The end
-------

**If you are a developer**, please always make sure to write tests for you code,
especially if you are dealing with sensitive data.
If you feel you may not have enough experience to work on something,
don't be afraid to say so, and ask for help.

**If you are doing a security audit**,
please bring a diverse team,
or be clear with the client about what things you may not be dealing with.

**If you are looking to do a security audit at your company**,
I may know a great team with experts in different areas that `you could hire <link://filename/pages/about.rst>`__.

.. note::

   This tale may have been inspired by a real situation,
   and some things may have been exaggerated (or maybe not?).
