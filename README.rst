BitKey is a swiss army knife of handy Bitcoin tools built on top of
Debian, which we created to scratch our own itch.

Community Branch
================

As most would be aware, BitKey is a side project of @turnkeylinux. Other
than the initial development and a few updates here and there over the
years, we've done a really poor job of maintaining it! :'(

However, the BitKey community was lucky enough that @estevaocm has come
along and given the project some love! Seeing as we're doing such a poor
job and he's doing such a great one, we've asked him to take over as
community leader and maintain this community branch of the offical BitKey
repo.

The master branch remains the "offical" BitKey release branch, but for the
foreseeable future, the "community" branch will be the one you'll most
likely want to use! Community ISOs (built and published by @estevaocm)
should be avaialble from the releases area of this repo.

Backstory
=========

We're avid Bitcoin fans but after going to our first local Bitcoin
meetup we discovered the elephant in the room was that there was no easy
way to perform cold storage Bitcoin transactions where the wallet lives
on an air-gapped system physically disconnected from the Internet.

We used the TurnKey GNU/Linux build system to create a self-contained
read-only CD/USB stick to satisfy all our Bitcoin needs. Yours too we
hope, and if not we're open to suggestions for improvement.

In December 2017, the project was forked to update all software and
include webcam support for QR code scanning and additional altcoin wallets.

In March 2018, @estevaocm has graciously agreed to lead maintence of this
communtiy branch. His work to date has been merged from his fork, back into
this branch.

Apps: batteries included!
=========================

Apps that are allowed network access in online mode:

- Electrum with wrapper that stores wallet on a USB in a LUKS encrypted
  loopback filesystem. During creation, displays passphrase strength
  estimates such as entropy and crack time.
- Electrum-LTC for Litecoin (with wrapper)
- Electron-Cash for Bitcoin Cash (with wrapper)
- Electrum-DASH for DASH (with wrapper)
- Armory Wallet (with wrapper)
- QtQR: allows QR code scanning from webcam
- zbar-tools: alternative for QtQR
- Exodus: multi-coin wallet, including ShapeShift exchanging (NOT OPEN SOURCE)
- CryptoSeed: encryption for paper wallets
- KeePassXC: password manager
- Online Web apps:

  - MyEtherWallet
  - Ripple Wallet
  - Minimalistic Ripple Wallet
  - Coinb.in: swiss army knife of bitcoin tools

Offline Web apps (not allowed network access even in online mode):

- Base43 decoder: decodes the strings from Electrum QR codes
- BIP39 Mnemonic Code Converter: paper wallet seeds for 30+ cryptocurrencies (BIP39, BIP32, BIP44, BIP49, BIP84, BIP141)
- bitaddress: paper wallet generator
- bitcoinpaperwallet: paper wallet generator
- IOTA paper wallet
- IOTA seed generator
- Monero paper wallet
- qrcode generator: encodes anything as a qrcode
- warpwallet: brainwallet with strong KDF (scrypt+pbkdf2) and salt
- zxcvbn: realistic password strength estimator

Advanced tools for Bitcoin ninjas:

- bx: the Bitcoin command line tool (AKA libbitcoin-explorer)

Other:

- Chromium web browser: runs in incognito mode by default (only
  visible in online mode), updated beyond default Debian Jessie

- Network manager
- Printer manager
- File manager
- Text editor

Installing BitKey on a USB stick or CDROM
=========================================

BitKey on CDROM: use your favorite program to burn the ISO to CDROM.
Nothing special. CDROMs are naturally read-only and tamper resistant.

BitKey on USB: If you don't burn BitKey to a CDROM, writing BitKey to a
USB stick with a hardware read-write toggle (e.g., Kanguru FlashBlu) is
the next best thing. Also loads the system much faster.

On USB sticks without write protection, you can remove BitKey USB after
booting as an additional security measure. BitKey loads into RAM so
after booting you no longer need the USB.

1) Insert USB stick and detect the device path::

    $ dmesg|grep Attached | tail --lines=1
    [583494.891574] sd 19:0:0:0: [sdf] Attached SCSI removable disk

2) Write ISO to USB::

    $ sudo dd if=path/to/bitkey.iso of=/dev/sdf
    $ lsblk | grep sdf
    sdf                                8:80   1   7.4G  1 disk  
    └─sdf1                             8:81   1   444M  1 part 

Formatting your data storage flash drive
----------------------------------------

By default, BitKey stores your wallet encrypted on a USB flash drive AKA
USB stick.

It expects your flash drive to be vfat formatted. This is the standard
format for store bought drives. If this isn't the case, BitKey may have
trouble detecting your drive. In that case you can reformat the drive
from Windows, or on Linux / BitKey using the following steps:

1) Insert data storage flash drive and detect the device path::

    $ dmesg|grep Attached | tail --lines=1
    [583494.891574] sd 19:0:0:0: [sda] Attached SCSI removable disk

2) Reformat the drive::

    $ sudo mkfs.vfat /dev/sda1
    mkfs.fat 3.0.27 (2014-11-12)

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

**Attention:** cold-online mode has been disabled due to no longer being supported by
Electrum 3. So your wallet's master public key must be manually exported to a
cold-online wallet. It may be most convenient to generate the QR code for the master
public key, then scan it from the Electrum app for Android to create a watch-only
wallet. The watch-only wallet allows you to check your balance and history, prepare
and broadcast transactions, but not sign transactions. If you only ever sign your
transactions in cold-offline mode and never otherwise compromise your secret master
private key, your funds cannot be stolen by a network attack. Since this version of
Bitkey includes webcam support, you may use the cam to scan the QR code of the prepared
transaction for signing, thus never exposing Bitkey or your wallet to harmful files.
For more information, refer to http://docs.electrum.org/en/latest/coldstorage.html

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
2) Generate Warpwallet with a strong passphrase and your e-mail as salt
3) Save public Bitcoin address (e.g., scan qrcode)
4) To ensure private keys do not survive in RAM, turn off computer
   running BitKey and disconnect power source for 15 minutes. 

After generating wallet, you can send Bitcoin to this address.

Safety warning regarding salts: do not use Warpwallet without a salt.
You're not going to forget your e-mail and using a salt makes attacks
vastly more difficult.

Public Service Announcement regarding Warpwallet passphrases: 

1) Humans are poor sources of randomness and much more predictable using
   statistical models than they think. Technology is ever moving forward
   and cracking techniques always get better, never worse. You may not
   be familiar with the state of the art, so be extra careful.
   
   The ideal passphrase is 6 to 8 truly random diceware words. If you're
   going to try and come up with a random passphrase yourself, be
   paranoid. They really are out to get you. At least use zxcvbn to
   measure passphrase strength. It's not perfect, but it should give you
   a clue. You'll want at least 65 bits of entropy for a salted
   warpwallet, especially if you are going to be storing funds
   long-term.

   DO NOT USE KNOWN PHRASES, QUOTES OR SENTENCES FROM A BOOK.

2) More wallets are lost to routine forgetfulness than sophisticated
   theft. If you're not continually accessing your Warpwallet there is a
   very high likelyhood you will eventually forget your passphrase after
   a few months or a few years. You only need to forget a single
   character for your wallet to be lost forever. This risk needs to be
   balanced with the risks of making a paper backup.

   Consider making a paper backup of your passphrase and destroying it
   only when you are absolutely sure you will not forget it, then use
   spaced reptition learning to ensure it stays in memory until you want
   to access the funds. 

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

8) Scan QRCode of signed transaction with phone and broadcast
   transaction to network.

9) Turn off BitKey as soon as the QRCode has been scanned, 
   disconnect power source, wait 15 minutes to clear RAM

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
    cold-offline wallet by booting into the wrong mode.

- Disabled networking in cold-offline mode: all plan/net network
  packages are purged on boot by /usr/lib/bitkey.d/purge-packages script

- Deny network access to local webapps (e.g., warpwallet, qrcode
  generator) that don't need it.

  Security in depth that prevents even a trojaned version of the app
  from leaking information to the network, even in online mode on a non
  airgapped computer.

- Webcam enabled for QR code scanning so no physical media communication is
  required. This allows your private keys to remain perfectly secret, aside
  from a BIOS attack. You should only communicate through QR codes, no USB
  drives aside from the one containing the keys. Verify the QR codes' contents
  at every exchange to make sure no malware is acting.

- All included components are open source

- Best effort to verify integrity of source components

  - do not accept any component without independent verification
  - download upstream archives from most authoritative trusted, verifiable source
  - check matching hash sums
  - verify PGP signatures when signatures are available
  - verify authenticity of PGP keys when possible (e.g., using keybase)
  - generate and inspect diff from tagged releases

- vouch for source components by signing list of signatures::

      gpg --verify /usr/local/src/SHA256SUM.asc

How to build from source
========================

BitKey is built with `TKLDev`_, the TurnKey GNU/Linux build system.

1) Deploy TKLDev (e.g., as a local VM)
2) SSH into TKLDev and (shallow) clone bitkey git repo::

	ssh tkldev
	cd products
	git-clone --depth 1 https://github.com/bitkey/bitkey

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

.. _BitKey: https://bitkey.io
.. _TKLDev: https://www.turnkeylinux.org/tkldev
.. _Issue Tracker: https://github.com/bitkey/bitkey/issues/
.. _guidelines and walk through: https://github.com/turnkeylinux/tracker/blob/master/GITFLOW.rst
