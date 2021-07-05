#!/bin/sh
cd "$(dirname $0)"
# rm -rf ../crloader.gz
# find . | sed '/nayu/d' | sed 's/^\.//g' | cpio -H newc -o | gzip -9 > ../crloader.gz
find . | cpio -H newc -o | gzip -9 > /tmp/crloader.gz
