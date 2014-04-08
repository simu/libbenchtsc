#
# libbenchtsc is a simple benchmarking library that uses the rdtsc
# x86 instruction.
# Copyright (c) 2014, Simon Gerber <gesimu@gmail.com>
# 
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
# 
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
# 
# You should have received a copy of the GNU Lesser General Public
# License along with this library; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
#

CFLAGS=-Wall -O2 -std=gnu11
PREFIX=/usr/local
VERSION=1
MINOR=0
LIBFNAME=libbenchtsc.so.$(VERSION).$(MINOR)
LIBSONAME=libbenchtsc.so.$(VERSION)

$(LIBFNAME): bench_rdtsc.o
	gcc $(CFLAGS) -shared -Wl,-soname,$(LIBSONAME) -o $(LIBFNAME) bench_rdtsc.o -lm

bench_rdtsc.o: bench_rdtsc.c
	gcc $(CFLAGS) -fpic -fPIC -c bench_rdtsc.c

install: $(LIBFNAME) bench_rdtsc.h
	install -m 644 -C $(LIBFNAME) -D $(PREFIX)/lib/$(LIBFNAME)
	ldconfig -l $(PREFIX)/lib/$(LIBFNAME)
	# also need plain .so link
	ln -s $(PREFIX)/lib/$(LIBFNAME) $(PREFIX)/lib/libbenchtsc.so
	mkdir -p $(PREFIX)/include
	install -m 644 -C bench_rdtsc.h $(PREFIX)/include

