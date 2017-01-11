BitKey is a swiss army knife of handy Bitcoin tools built on top of
Debian, which we created to scratch our own itch.

Backstory
=========

We're avid Bitcoin fans but after going to our first local Bitcoin
meetup we discovered the elephant in the room was that there was no easy
way to perform cold storage Bitcoin transactions where the wallet lives
on an air-gapped system physically disconnected from the Internet.

We used the TurnKey GNU/Linux build system to create a self-contained
read-only CD/USB stick with everything you need to perform any type of
Bitcoin transaction transaction.

Apps: batteries included!
=========================

Apps that are allowed network access in online mode:

- Electrum with wrapper that stores wallet on a USB in a LUKS encrypted
  loopback filesystem. During creation, displays passphrase strength
  estimates such as entropy and crack time.

- coinbin: swiss army knife of bitcoin tools

Apps that are not allowed network access even in online mode:

- warpwallet: scrypt+pbkdf2 secure brainwallet

  http://maxtaco.github.io/bitcoin/2014/01/16/how-jason-bourne-stores-his-bitcoin/ 

- bitaddress: paper wallet generator
- qrcode generator: encodes anything as a qrcode
- zxcvbn: realistic password strength estimator

Advanced tools for Bitcoin ninjas:

- bx: the Bitcoin command line tool (AKA libbitcoin-explorer)

Other:

- Chromium web browser: runs in incognito mode by default (only
  visible in online mode)

- Network manager

- Text editor
- File manager

Usage modes
===========

See https://bitkey.io for a detailed introduction and usage guide.

BitKey Live CD/USB supports three modes of operation
selected from a boot time menu.

High security - Cold storage boot modes
---------------------------------------

Two cold storage modes:

1) cold-offline: create wallet, sign transactions
2) cold-online: watch wallet, prepare transactions

If the instructions are carefully followed, cold storage modes creates
an airgap which ensures that your wallet's private keys are never known
to any computer connected to the Internet.

Medium security - Hot-online boot mode
--------------------------------------

Allows you to create & watch wallet, prepare & sign transactions.

In hot online mode, the private keys are known to a computer connected
to the Internet. This is the most convenient mode because you only need
one computer. After booting BitKey resides in RAM and saves nothing to
your hard drive.

The flip side is smaller security margins: 

1) You need to trust that your copy of BitKey hasn't been tampered with
   and that the original signed BitKey image hasn't been compromised.

2) If you use a network enabled app (e.g., Chromium) and an attacker
   exploits a zero-day vulnerability to gain access to your online
   system, say goodbye to those Bitcoins!

Low security - Hot storage on your PC/phone
-------------------------------------------

In this mode you don't use BitKey or any hardware wallet type device.
Your wallet's private keys are stored on your phone or PC and known to
an Internet enabled device that is vulnerable (or will be sometime in
the future) to the efforts of thieves who would like nothing more than
to steal your Bitcoin.

You rely on the magical power of wishful thinking. You're not important
enough to get hacked and any opportunistic malware infection you do get
is not going to include any Bitcoin stealing functionailty. Right?
Right! Good luck!

Security model
==============

Guidelines:

- Defense in depth: increase security by forcing attackers to overcome a
  plurality of obstacles.

- Minimize trust: minimize the number of third parties that need to be
  trusted, and minimize the degree of trust that needs to be placed on
  the existing trusted parties (e.g., BitKey developers to a degree).

- Minimized complexity: attack surface grows with complexity, so
  decrease complexity by minimizing number of components, using simpler
  components (e.g., chromium with webapps)

- Minimum privilege level policy: for example, if a component doesn't
  need network access, don't give it to it. If a mode doesn't need
  network access, enforce lack of network access.

- Transparency and verifiability: only use open source components who's
  integrity can be verified in principle and in which violations of
  integrity are more likely to be detected.

- Assume and attempt to compensate for human fallibility: avoid assuming
  users are advanced Bitcoin and security experts. Do the most to
  protect them from natural mistakes and lack of awareness with more
  secure defaults, friendly reminders, health warnings, tools for
  verifying against mistakes.

Specifics:

- Disabled networking in cold-offline mode: all plan/net network packages are purged on
  boot by /usr/lib/bitkey.d/purge-packages script

- Deny network access to local webapps (e.g., warpwallet, qrcode
  generator) that don't need it.

  Security in depth that prevents even a trojaned version of the app
  from leaking information to the network, even in online mode on a non
  airgapped computer.

- All included components are open source

- Best effort to verify integrity of source components

  - do not accept any component without independent verification
  - download upstream archives from most authoritative trusted, verifiable source
  - check matching hash sums
  - verify PGP signatures when signatures are available
  - verify authenticity of PGP keys when possible (e.g., using keybase)
  - generate and inspect diff from tagged releases

- vouch for source components by signing list of signatures
  /usr/local/src SHA256SUM

How to build from source
========================

BitKey is built with `TKLDev`_, the TurnKey GNU/Linux build system.

1) Deploy TKLDev (e.g., as a local VM)
2) SSH into TKLDev and clone bitkey git repo::

	ssh tkldev
	cd products
	git-clone https://github.com/bitkey/bitkey

	cd bitkey
	make

Reporting a bug, issue or feature request
=========================================

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
===========================

BitKey, like TurnKey, is 100% free software and the code for all
components is right here on GitHub.  Developers with good ideas are
strongly encouraged to be bold and contribute code. Use the source Luke!

See the `guidelines and walk through`_.

.. _BitKey: http://bitkey.io
.. _TKLDev: http://www.turnkeylinux.org/tkldev
.. _Issue Tracker: https://github.com/bitkey/bitkey/issues/
.. _guidelines and walk through: https://github.com/turnkeylinux/tracker/blob/master/GITFLOW.rst

