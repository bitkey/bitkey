In its current form BitKey is a swiss army knife of handy Bitcoin tools
built on top of Debian, which we created because we wanted something
like it for our own use case.

We're avid Bitcoin fans but after going to our first local Bitcoin
meetup we discovered the elephant in the room was that there was no easy
way to perform cold storage Bitcoin transactions where the wallet lives
on an air-gapped system physically disconnected from the Internet.

The idea was to see if we could use the TurnKey GNU/Linux build system
to create a self-contained read-only CD/USB stick with everything you
need to perform highly secure air-gapped Bitcoin transactions.

Overview, features, download
----------------------------

See http://bitkey.io

Building from source
--------------------

BitKey is built with `TKLDev`_, the TurnKey GNU/Linux build system.

Reporting a bug, issue or feature request
-----------------------------------------

The ideal bug/issue includes:

1) A detailed description of the issue.
2) How to reproduce the issue step by step.
3) Any extra information that might be relevant, such as your hardware,
   network card, boot media, any changes made prior to issue, etc.

The ideal feature request includes:

1) A detailed description of feature and component it relates to.
2) One or more use cases for the feature.
3) Any extra information that might be relevant.

Before creating a new issue on the `Issue Tracker`_, please check to see
if a similar issue already exists. If it does, post a comment showing it
also affects you.  Knowing an issue effects multiple users is useful
when we decide how to prioritize limited development resources. Please
try and include any additional information you think might help us close
the issue.

Contributing as a developer
---------------------------

BitKey, like TurnKey, is 100% free software and the code for all
components is right here on GitHub.  Developers with good ideas are
strongly encouraged to be bold and contribute code. Use the source Luke!

See the `guidelines and walk through`_.


.. _BitKey: http://bitkey.io
.. _TKLDev: http://www.turnkeylinux.org/tkldev
.. _Issue Tracker: https://github.com/bitkey/bitkey/issues/
.. _guidelines and walk through: https://github.com/turnkeylinux/tracker/blob/master/GITFLOW.rst

