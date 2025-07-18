#!/bin/ksh
#
# SPDX-License-Identifier: CDDL-1.0
#
# {{{ CDDL HEADER
#
# This file and its contents are supplied under the terms of the
# Common Development and Distribution License ("CDDL"), version 1.0.
# You may only use this file in accordance with the terms of version
# 1.0 of the CDDL.
#
# A full copy of the text of the CDDL should have accompanied this
# source. A copy of the CDDL is also available via the Internet at
# http://www.illumos.org/license/CDDL.
#
# }}}
#
# Copyright 2025 Peter Tribble
#

#
# convert ISO to a hybrid image which can be written to a USB drive
# This is taken from:
#   https://github.com/tsoome/slim_source/commit/a8cdb4a40b57fddaa152ef
#
# as implemented in Kayak
#
echo "Converting ISO to hybrid image"

case $# in
    2)
	DST_ISO="$1"
	DIST_AREA="$2"
	;;
    *)
	echo "Usage: $0 iso_file dist_area"
	exit 2
	;;
esac
if [ ! -f "$DST_ISO" ]; then
    echo "ERROR: Cannot find ISO $DST_ISO"
    exit 1
fi
if [ ! -d "$DIST_AREA" ]; then
    echo "ERROR: Cannot find distribution area $DIST_AREA"
    exit 1
fi
if [ ! -f "${DIST_AREA}/boot/pmbr" ]; then
    echo "ERROR: Cannot find pmbr in $DIST_AREA"
    exit 1
fi
if [ ! -f "${DIST_AREA}/boot/isoboot" ]; then
    echo "ERROR: Cannot find isoboot in $DIST_AREA"
    exit 1
fi

LOFI_ISO=$(lofiadm -la "$DST_ISO")
[ -n "$LOFI_ISO" ] || exit 1

RLOFI_ISO=${LOFI_ISO/dsk/rdsk}
P2LOFI_ISO=${RLOFI_ISO/p0/p2}

#
# Look for the ESP in the ISO image
#
# the etdump output looks like
#
# et_platform=default;et_system=i386;et_lba=167;et_sectors=4
# et_platform=efi;et_system=i386;et_lba=168;et_sectors=8192
#
# the eval then causes the et_ variables to be set
#
for entry in $(etdump --format shell "$DST_ISO"); do
    echo "--> $entry"
    eval $entry
    [ "$et_platform" = "efi" ] || continue
    ((et_lba = et_lba * 2048 / 512))
    espparam="239:0:0:0:0:0:0:0:$et_lba:$et_sectors"
    break
done

if [ -n "$espparam" ]; then
    # The system area will start at sector 64
    /usr/sbin/fdisk -A 190:0:0:0:0:0:0:0:3:60 "$RLOFI_ISO"
    /usr/sbin/fdisk -A "$espparam" "$RLOFI_ISO"
    /usr/sbin/installboot -fm "${DIST_AREA}/boot/pmbr" "${DIST_AREA}/boot/isoboot" "$P2LOFI_ISO"

    echo
    echo "Partition table after"
    /usr/sbin/fdisk -W - "$RLOFI_ISO" | tail -5 | head -3
fi
lofiadm -d "$LOFI_ISO"