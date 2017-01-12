BitKey is a swiss army knife of handy Bitcoin tools built on top of
Debian, which we created to scratch our own itch.

Backstory
=========

We're avid Bitcoin fans but after going to our first local Bitcoin
meetup we discovered the elephant in the room was that there was no easy
way to perform cold storage Bitcoin transactions where the wallet lives
on an air-gapped system physically disconnected from the Internet.

We used the TurnKey GNU/Linux build system to create a self-contained
read-only CD/USB stick to satisfy all our Bitcoin needs. Your's too we
hope, and if not we're open to suggestions for improvement.

Apps: batteries included!
=========================

Apps that are allowed network access in online mode:

- Electrum with wrapper that stores wallet on a USB in a LUKS encrypted
  loopback filesystem. During creation, displays passphrase strength
  estimates such as entropy and crack time.

- coinbin: swiss army knife of bitcoin tools

Apps that are not allowed network access even in online mode:

- warpwallet: secure brainwallet (scrypt+pbkdf2)
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

   In this mode, the desktop background is green (mnemonic for cool and safe)

2) cold-online: watch wallet, prepare transactions

   In this mode, the desktop background is blue (mnemonic for cool and informative)

If the instructions are carefully followed, cold storage modes creates
an airgap which ensures that your wallet's private keys are never loaded
into RAM on a computer connected to the Internet.

Medium security - Hot-online boot mode (red background)
-------------------------------------------------------

In this mode the desktop background is red (mnemonic for hot and dangerous)

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

Paranoid brainwallet support - Jason Bourne mode
================================================

Hardest to use but leaves no trace of wallet keys in any storage medium.
Minimizes trust in BitKey. Your wallet keys are only stored in your head.

Inspired by how Jason Bourne stores his Bitcoin:

http://maxtaco.github.io/bitcoin/2014/01/16/how-jason-bourne-stores-his-bitcoin/ 

Generating wallet step
----------------------

1) Boot BitKey in cold-offline mode, remove BitKey USB
2) Use Warpwallet to create a secure brainwallet
3) Save public Bitcoin address (e.g., scan qrcode)
4) To ensure private keys do not survive in RAM, turn off computer
   running BitKey and disconnect power source for 15 minutes. 

After generating wallet, you can send Bitcoin to this address.

Generating unsigned transaction step
------------------------------------

This step is easiest to do from an Electrum watch-wallet on a PC, but
you can also do it from BitKey:

1) Boot BitKey in cold-online mode, remove BitKey USB
2) Restore watch-only wallet and run Electrum, from command line::

    $ electrum restore $PUBLIC_ADDRESS
    $ electrum

3) Insert USB stick for storing unsigned transaction
4) Fill in recipient under Send tab and "Save" unsigned
   transaction to USB at /media/usb/
5) Shutdown/Reboot BitKey

Signing transaction step
------------------------

1) Boot BitKey in cold-offline mode, remove BitKey USB
2) Insert USB stick where you stored unsigned transaction. Copy to RAM
   and remove from disk::

    $ cp /media/usb/unsigned.txt ~/     #  uses RAM for storage
    $ srm /media/usb/unsigned.txt       # secure delete unsigned transaction

3) Unplug USB stick
4) Use Warpwallet to restore brainwallet private key
5) Launch Electrum from command line so that it stores wallet in RAM::

    $ electrum -w /tmp/brainwallet

6) Import private key and sign transaction

   - In the Electrum Install Wizard, select 'Restore a wallet or import keys'
   - Cut and paste the private key, click Next
   - Click Next again (you don't need encryption for a wallet in RAM)
   - Tools > Load transaction > From file
   - Verify Outputs, Sign & Save signed transaction

7) Create a QRCode for the signed transaction:

   - Open Signed transaction in text editor
   - Open qrcode app: cut and paste hex of signed transaction

8) Scan qrcode of signed transaction with phone and broadcast
   transaction to network.

9) Turn off BitKey, disconnect power source, wait 15 minutes to clear
   RAM

Desktop usage tips (Keyboard and mouse shortcuts)
=================================================

Full custom keybindings in overlay/usr/share/glib-2.0/schemas/20_custom.gschema.override

Copy, Cut and Paste
-------------------

- Keyboard: Ctrl+C, CTRL+X and CTRL-V
- Mouse: 
    
  To copy, click text and drag to highlight text to be copied

  To paste, left click to focus keyboard, then middle mouse click to
  paste. If no middle mouse button exists, clicking both right and
  left buttons simultaneously also works.
    
Window management
-----------------

- Window operations: 
  
  - Right-click titlebar 
  - ALT+F3

- Split screen window positioning:
  
  Dragging window to left or right

  This makes a window neatly fill half the screen

- Maximize window by dragging to top of screen 

- Toggle window maximization:

  - double click on window titlebar
  - ALT+F10

- Minimize window: ALT+F9

- Resize window: Alt+F8

- Close window with CTRL+W or ALT-F4

- Switch between windows (including minimized): Alt+TAB

Workspaces
----------

- Switch workspaces: 
  
  - <Win> F1-F4
  - <Ctrl> <Alt> Left/Right

- Move window to a different workspace: <Win> <Shift> F1-F4



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

- Change desktop background color to indicate boot mode

  - cold-offline: green background
  - cold-online: blue background
  - hot-online: red background

- Electrum wrapper:
  
  - automatically configures default wallet based on boot mode

    In cold-offline mode: wallet is stored in an encrypted LUKS, with
    enforced passphrase complexity. Following offline wallet generation
    a watch only wallet is created containing only public keys.

    In cold-online mode: only the watch wallet is accessible, the wallet
    containing private keys is inaccessible so that the user is never
    accidentally prompted for the passphrase and can't open the wallet
    online by mistake. 

    In hot-online mode: separate wallet file, so that even if you store
    the wallets on the same USB key, you can't accidentally open the
    cold-offline wallet by booting into the wron boot.

- Disabled networking in cold-offline mode: all plan/net network
  packages are purged on boot by /usr/lib/bitkey.d/purge-packages script

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

