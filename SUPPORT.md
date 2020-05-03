By now ACR is known to be very portable on posix shell based systems:

Supported OSs:

* GNU/FreeBSD (kFreeBSD)
* GNU/Linux
* GNU/Hurd
* Darwin
* macOS
* MacOS-X
* NetBSD
* FreeBSD
* OpenBSD
* Solaris

Supported languages:

* C
* C++
* V
* Vala
* ObjectiveC
* Go
* Java
* Bash
* Perl
* Ruby
* Python
* TCL

Known system strings:

* ppc-unknown-linux
* ppc-unknown-linux-gnu
* x86-unknown-linux

Autoconf diff:

* --quite/--silent -> no sense . You can pipe to /dev/null
* VPATH vs srcdir for crosspath builds
* some cleanup of old-not-used flags
* acr implements --report for easy to look packages
* sandbox support
* faster and smaller final script

PD: Send me mails for adding support to other OSs or bug reports to:

	pancake@nopcode.org
