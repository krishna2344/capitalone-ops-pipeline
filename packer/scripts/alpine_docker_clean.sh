#!/bin/sh
#
# Ops-Pipeline - Templates for automating the production and consumption of images
# and containers.
#
# Copyright 2016 Capital One Services, LLC.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

set -x


# hope to pick up proxy settings if we can
. /etc/profile


apk del python-dev fakeroot pax-utils libattr attr tar abuild binutils-libs binutils libgomp pkgconf pkgconfig libgcc gmp mpfr3 mpc1 libstdc++ gcc make patch musl-dbg libc6-compat musl-dev libc-dev fortify-headers g++ build-base expat pcre git squashfs-tools file bzip2 libbz2 libcap cdrkit acct lddtree mkinitfs mtools alpine-sdk libffi gdbm ncurses-libs readline sqlite-libs py-pip
apk -v cache clean
du -sh /*