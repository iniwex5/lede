#!/usr/bin/env bash
set -euo pipefail

./scripts/feeds update -a
./scripts/feeds install -a

qmodem_makefile="feeds/qmodem/application/qmodem/Makefile"
if [ "$(grep -Ec 'kmod-mhi-wwan[[:space:]]*\\$' "$qmodem_makefile")" -ne 1 ]; then
	echo "Unexpected QModem MHI dependency layout" >&2
	exit 1
fi

# LEDE exposes the generic MHI data driver as kmod-mhi-net.
sed -i '/kmod-mhi-wwan[[:space:]]*\\$/s/kmod-mhi-wwan/kmod-mhi-net/' "$qmodem_makefile"

cp profiles/fzs-5gcpe-p3-512m.config .config
make defconfig
