#!/bin/bash
set -e

KERNEL="kernel/bzImage"
INITRD="initramfs.cpio.gz"

if [ ! -f "$KERNEL" ]; then
  echo "❌ Kernel not found: $KERNEL"
  exit 1
fi

if [ ! -f "$INITRD" ]; then
  echo "❌ initramfs not found: $INITRD"
  exit 1
fi

echo "🚀 Booting Mini Linux OS..."

qemu-system-x86_64 \
  -kernel "$KERNEL" \
  -initrd "$INITRD" \
  -append "console=ttyS0 root=/dev/ram rw init=/init rdinit=/init noapic loglevel=3 quiet" \
  -netdev user,id=net0 \
  -device e1000,netdev=net0 \
  -nographic

