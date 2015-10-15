#!/bin/sh

set -x

apk del python-dev fakeroot pax-utils libattr attr tar abuild binutils-libs binutils libgomp pkgconf pkgconfig libgcc gmp mpfr3 mpc1 libstdc++ gcc make patch musl-dbg libc6-compat musl-dev libc-dev fortify-headers g++ build-base expat pcre git squashfs-tools file bzip2 libbz2 libcap cdrkit acct lddtree mkinitfs mtools alpine-sdk libffi gdbm ncurses-libs readline sqlite-libs py-pip
apk -v cache clean
du -sh /*

