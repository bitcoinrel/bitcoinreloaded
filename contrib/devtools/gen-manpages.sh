#!/usr/bin/env bash
# Copyright (c) 2016-2019 The Bitcoin Core developers
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.

export LC_ALL=C
TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
BUILDDIR=${BUILDDIR:-$TOPDIR}

BINDIR=${BINDIR:-$BUILDDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

BITCOINRELOADEDD=${BITCOINRELOADEDD:-$BINDIR/bitcoinreloadedd}
BITCOINRELOADEDCLI=${BITCOINRELOADEDCLI:-$BINDIR/bitcoinreloaded-cli}
BITCOINRELOADEDTX=${BITCOINRELOADEDTX:-$BINDIR/bitcoinreloaded-tx}
WALLET_TOOL=${WALLET_TOOL:-$BINDIR/bitcoinreloaded-wallet}
BITCOINRELOADEDQT=${BITCOINRELOADEDQT:-$BINDIR/qt/bitcoinreloaded-qt}

[ ! -x $BITCOINRELOADEDD ] && echo "$BITCOINRELOADEDD not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
read -r -a BTCRVER <<< "$($BITCOINRELOADEDCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }')"

# Create a footer file with copyright content.
# This gets autodetected fine for bitcoinreloadedd if --version-string is not set,
# but has different outcomes for bitcoinreloaded-qt and bitcoinreloaded-cli.
echo "[COPYRIGHT]" > footer.h2m
$BITCOINRELOADEDD --version | sed -n '1!p' >> footer.h2m

for cmd in $BITCOINRELOADEDD $BITCOINRELOADEDCLI $BITCOINRELOADEDTX $WALLET_TOOL $BITCOINRELOADEDQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${BTCRVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${BTCRVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
