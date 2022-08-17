#
# Word Clock makefile
# assembles source code, optionally builds a disk image and mounts it
#
# original by Quinn Dunki on 2014-08-15
# One Girl, One Laptop Productions
# http://www.quinndunki.com/blondihacks
#
# adapted by 4am on 2022-08-13
#

# third-party tools required to build

# https://sourceforge.net/projects/acme-crossass/
ACME=acme

# https://github.com/mach-kernel/cadius
CADIUS=cadius

BUILDDISK=build/word.clock

dist: asm
	cp res/work.po "$(BUILDDISK)".po >>build/log
	cp res/_FileInformation.txt build/ >>build/log
	$(CADIUS) ADDFILE "${BUILDDISK}".po "/WORD.CLOCK/" "build/WRDCLOCK.SYSTEM" >>build/log
	bin/po2do.py build/ build/
	rm "$(BUILDDISK)".po

asm:
	mkdir -p build
	$(ACME) -r build/wordclock.lst src/wordclock.a 2>build/log

clean:
	rm -rf build/

mount:
	open "$(BUILDDISK)".dsk

all: clean asm dist mount

al: all
