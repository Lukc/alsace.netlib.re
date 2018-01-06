PACKAGE = 'alsace.netlib.re'
VERSION = '35'

PREFIX := /usr/local
BINDIR := $(PREFIX)/bin
LIBDIR := $(PREFIX)/lib
SHAREDIR := $(PREFIX)/share
INCLUDEDIR := $(PREFIX)/include
MANDIR := $(SHAREDIR)/man
VARSTATEDIR := /var
PUBDIR := $(VARSTATEDIR)/alsace.netlib.re

CC := cc
AR := ar
RANLIB := ranlib
CFLAGS := 
LDFLAGS := 

Q := @

all: index.xhtml alsace.netlib.re.css aius.png desclicks.png logo-ARN.png logo-Hackstub.png lug.png seeraiwer.png
	@:

index.xhtml: index.moon
	@echo '[01;33m  MOON >  [01;37mindex.xhtml[00m'
	$(Q)moon index.moon > index.xhtml


index.xhtml.install: index.xhtml
	@echo '[01;31m  IN >    [01;37m$(PUBDIR)/index.xhtml[00m'
	$(Q)mkdir -p '$(DESTDIR)$(PUBDIR)'
	$(Q)install -m0755 index.xhtml $(DESTDIR)$(PUBDIR)/index.xhtml

index.xhtml.clean:
	@echo '[01;37m  RM >    [01;37mindex.xhtml[00m'
	$(Q)rm -f index.xhtml

index.xhtml.uninstall:
	@echo '[01;37m  RM >    [01;37m$(PUBDIR)/index.xhtml[00m'
	$(Q)rm -f '$(DESTDIR)$(PUBDIR)/index.xhtml'

alsace.netlib.re.css: alsace.netlib.re.sass
	@echo '[01;34m  SASSC > [01;37malsace.netlib.re.css[00m'
	$(Q)sassc alsace.netlib.re.sass > alsace.netlib.re.css
alsace.netlib.re.css.install: alsace.netlib.re.css
	@echo '[01;31m  IN >    [01;37m$(PUBDIR)/alsace.netlib.re.css[00m'
	$(Q)mkdir -p '$(DESTDIR)$(PUBDIR)'
	$(Q)install -m0755 alsace.netlib.re.css $(DESTDIR)$(PUBDIR)/alsace.netlib.re.css

alsace.netlib.re.css.clean:
	@echo '[01;37m  RM >    [01;37malsace.netlib.re.css[00m'
	$(Q)rm -f alsace.netlib.re.css

alsace.netlib.re.css.uninstall:
	@echo '[01;37m  RM >    [01;37m$(PUBDIR)/alsace.netlib.re.css[00m'
	$(Q)rm -f '$(DESTDIR)$(PUBDIR)/alsace.netlib.re.css'

aius.png.install: aius.png
	@echo '[01;31m  IN >    [01;37m$(PUBDIR)/aius.png[00m'
	$(Q)mkdir -p '$(DESTDIR)$(PUBDIR)'
	$(Q)install -m0755 aius.png $(DESTDIR)$(PUBDIR)/aius.png

aius.png.clean:
	:


aius.png.uninstall:
	@echo '[01;37m  RM >    [01;37m$(PUBDIR)/aius.png[00m'
	$(Q)rm -f '$(DESTDIR)$(PUBDIR)/aius.png'

desclicks.png.install: desclicks.png
	@echo '[01;31m  IN >    [01;37m$(PUBDIR)/desclicks.png[00m'
	$(Q)mkdir -p '$(DESTDIR)$(PUBDIR)'
	$(Q)install -m0755 desclicks.png $(DESTDIR)$(PUBDIR)/desclicks.png

desclicks.png.clean:
	:


desclicks.png.uninstall:
	@echo '[01;37m  RM >    [01;37m$(PUBDIR)/desclicks.png[00m'
	$(Q)rm -f '$(DESTDIR)$(PUBDIR)/desclicks.png'

logo-ARN.png.install: logo-ARN.png
	@echo '[01;31m  IN >    [01;37m$(PUBDIR)/logo-ARN.png[00m'
	$(Q)mkdir -p '$(DESTDIR)$(PUBDIR)'
	$(Q)install -m0755 logo-ARN.png $(DESTDIR)$(PUBDIR)/logo-ARN.png

logo-ARN.png.clean:
	:


logo-ARN.png.uninstall:
	@echo '[01;37m  RM >    [01;37m$(PUBDIR)/logo-ARN.png[00m'
	$(Q)rm -f '$(DESTDIR)$(PUBDIR)/logo-ARN.png'

logo-Hackstub.png.install: logo-Hackstub.png
	@echo '[01;31m  IN >    [01;37m$(PUBDIR)/logo-Hackstub.png[00m'
	$(Q)mkdir -p '$(DESTDIR)$(PUBDIR)'
	$(Q)install -m0755 logo-Hackstub.png $(DESTDIR)$(PUBDIR)/logo-Hackstub.png

logo-Hackstub.png.clean:
	:


logo-Hackstub.png.uninstall:
	@echo '[01;37m  RM >    [01;37m$(PUBDIR)/logo-Hackstub.png[00m'
	$(Q)rm -f '$(DESTDIR)$(PUBDIR)/logo-Hackstub.png'

lug.png.install: lug.png
	@echo '[01;31m  IN >    [01;37m$(PUBDIR)/lug.png[00m'
	$(Q)mkdir -p '$(DESTDIR)$(PUBDIR)'
	$(Q)install -m0755 lug.png $(DESTDIR)$(PUBDIR)/lug.png

lug.png.clean:
	:


lug.png.uninstall:
	@echo '[01;37m  RM >    [01;37m$(PUBDIR)/lug.png[00m'
	$(Q)rm -f '$(DESTDIR)$(PUBDIR)/lug.png'

seeraiwer.png.install: seeraiwer.png
	@echo '[01;31m  IN >    [01;37m$(PUBDIR)/seeraiwer.png[00m'
	$(Q)mkdir -p '$(DESTDIR)$(PUBDIR)'
	$(Q)install -m0755 seeraiwer.png $(DESTDIR)$(PUBDIR)/seeraiwer.png

seeraiwer.png.clean:
	:


seeraiwer.png.uninstall:
	@echo '[01;37m  RM >    [01;37m$(PUBDIR)/seeraiwer.png[00m'
	$(Q)rm -f '$(DESTDIR)$(PUBDIR)/seeraiwer.png'

$(DESTDIR)$(PREFIX):
	@echo '[01;35m  DIR >   [01;37m$(PREFIX)[00m'
	$(Q)mkdir -p $(DESTDIR)$(PREFIX)
$(DESTDIR)$(BINDIR):
	@echo '[01;35m  DIR >   [01;37m$(BINDIR)[00m'
	$(Q)mkdir -p $(DESTDIR)$(BINDIR)
$(DESTDIR)$(LIBDIR):
	@echo '[01;35m  DIR >   [01;37m$(LIBDIR)[00m'
	$(Q)mkdir -p $(DESTDIR)$(LIBDIR)
$(DESTDIR)$(SHAREDIR):
	@echo '[01;35m  DIR >   [01;37m$(SHAREDIR)[00m'
	$(Q)mkdir -p $(DESTDIR)$(SHAREDIR)
$(DESTDIR)$(INCLUDEDIR):
	@echo '[01;35m  DIR >   [01;37m$(INCLUDEDIR)[00m'
	$(Q)mkdir -p $(DESTDIR)$(INCLUDEDIR)
$(DESTDIR)$(MANDIR):
	@echo '[01;35m  DIR >   [01;37m$(MANDIR)[00m'
	$(Q)mkdir -p $(DESTDIR)$(MANDIR)
install: subdirs.install index.xhtml.install alsace.netlib.re.css.install aius.png.install desclicks.png.install logo-ARN.png.install logo-Hackstub.png.install lug.png.install seeraiwer.png.install
	@:

subdirs.install:

uninstall: subdirs.uninstall index.xhtml.uninstall alsace.netlib.re.css.uninstall aius.png.uninstall desclicks.png.uninstall logo-ARN.png.uninstall logo-Hackstub.png.uninstall lug.png.uninstall seeraiwer.png.uninstall
	@:

subdirs.uninstall:

test: all subdirs subdirs.test
	@:

subdirs.test:

clean: index.xhtml.clean alsace.netlib.re.css.clean aius.png.clean desclicks.png.clean logo-ARN.png.clean logo-Hackstub.png.clean lug.png.clean seeraiwer.png.clean

distclean: clean

dist: dist-gz dist-xz dist-bz2
	$(Q)rm -- $(PACKAGE)-$(VERSION)

distdir:
	$(Q)rm -rf -- $(PACKAGE)-$(VERSION)
	$(Q)ln -s -- . $(PACKAGE)-$(VERSION)

dist-gz: $(PACKAGE)-$(VERSION).tar.gz
$(PACKAGE)-$(VERSION).tar.gz: distdir
	@echo '[01;33m  TAR >   [01;37m$(PACKAGE)-$(VERSION).tar.gz[00m'
	$(Q)tar czf $(PACKAGE)-$(VERSION).tar.gz \


dist-xz: $(PACKAGE)-$(VERSION).tar.xz
$(PACKAGE)-$(VERSION).tar.xz: distdir
	@echo '[01;33m  TAR >   [01;37m$(PACKAGE)-$(VERSION).tar.xz[00m'
	$(Q)tar cJf $(PACKAGE)-$(VERSION).tar.xz \


dist-bz2: $(PACKAGE)-$(VERSION).tar.bz2
$(PACKAGE)-$(VERSION).tar.bz2: distdir
	@echo '[01;33m  TAR >   [01;37m$(PACKAGE)-$(VERSION).tar.bz2[00m'
	$(Q)tar cjf $(PACKAGE)-$(VERSION).tar.bz2 \


help:
	@echo '[01;37m :: alsace.netlib.re-35[00m'
	@echo ''
	@echo '[01;37mGeneric targets:[00m'
	@echo '[00m    - [01;32mhelp          [37m Prints this help message.[00m'
	@echo '[00m    - [01;32mall           [37m Builds all targets.[00m'
	@echo '[00m    - [01;32mdist          [37m Creates tarballs of the files of the project.[00m'
	@echo '[00m    - [01;32minstall       [37m Installs the project.[00m'
	@echo '[00m    - [01;32mclean         [37m Removes compiled files.[00m'
	@echo '[00m    - [01;32muninstall     [37m Deinstalls the project.[00m'
	@echo ''
	@echo '[01;37mCLI-modifiable variables:[00m'
	@echo '    - [01;34mCC            [37m ${CC}[00m'
	@echo '    - [01;34mCFLAGS        [37m ${CFLAGS}[00m'
	@echo '    - [01;34mLDFLAGS       [37m ${LDFLAGS}[00m'
	@echo '    - [01;34mDESTDIR       [37m ${DESTDIR}[00m'
	@echo '    - [01;34mPREFIX        [37m ${PREFIX}[00m'
	@echo '    - [01;34mBINDIR        [37m ${BINDIR}[00m'
	@echo '    - [01;34mLIBDIR        [37m ${LIBDIR}[00m'
	@echo '    - [01;34mSHAREDIR      [37m ${SHAREDIR}[00m'
	@echo '    - [01;34mINCLUDEDIR    [37m ${INCLUDEDIR}[00m'
	@echo '    - [01;34mMANDIR        [37m ${MANDIR}[00m'
	@echo '    - [01;34mVARSTATEDIR   [37m ${VARSTATEDIR}[00m'
	@echo '    - [01;34mPUBDIR        [37m ${PUBDIR}[00m'
	@echo ''
	@echo '[01;37mProject targets: [00m'
	@echo '    - [01;33mindex.xhtml   [37m moon-xhtml[00m'
	@echo '    - [01;33malsace.netlib.re.css[37m sass[00m'
	@echo '    - [01;33maius.png      [37m asset[00m'
	@echo '    - [01;33mdesclicks.png [37m asset[00m'
	@echo '    - [01;33mlogo-ARN.png  [37m asset[00m'
	@echo '    - [01;33mlogo-Hackstub.png[37m asset[00m'
	@echo '    - [01;33mlug.png       [37m asset[00m'
	@echo '    - [01;33mseeraiwer.png [37m asset[00m'
	@echo ''
	@echo '[01;37mMakefile options:[00m'
	@echo '    - gnu:           false'
	@echo '    - colors:        true'
	@echo ''
	@echo '[01;37mRebuild the Makefile with:[00m'
	@echo '    zsh ./build.zsh -c'
.PHONY: all subdirs clean distclean dist install uninstall help

