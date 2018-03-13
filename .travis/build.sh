#!/bin/bash
set -uexv

if [[ "$SATYSFI_TARGET" = "windows32" ]]; then
  ARCH="i686-w64-mingw32"
elif [[ "$SATYSFI_TARGET" = "windows64" ]]; then
  ARCH="x86_64-w64-mingw32"
else
  echo "Error: unknown \$SATYSFI_TARGET = $SATYSFI_TARGET" >&2
fi

# export LDFLAGS="-L$HOME/$ARCH/lib"
# export CPPFLAGS="-I$HOME/$ARCH/include"
export LDFLAGS=""
export CPPFLAGS=""

cd SATySFi
patch -p1 < ../files/patches/otfm-dev-null-windows.patch
patch -p1 < ../files/patches/win32-userprofile.patch
cd ..

opam repository -y add windows ./opam-cross-windows
opam repository -y add satysfi-aux ./opam-aux
opam pin -y add satysfi-windows .
