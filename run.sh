#!/bin/bash

# shell script to do some of the steps the Makefile included with https://github.com/cliffordcarnmo/c64-devkit does.

# bin/acme -r build/buildreport --vicelabels build/symbols --msvc --color --format cbm -v3 --outfile build/c64-devkit.prg project/main.asm
# bin/pucrunch -x0x0801 -c64 -g55 -fshort build/c64-devkit.prg build/c64-devkit.prg
# bin/x64 -autostartprgmode 0 build/c64-devkit.prg

if [ "" == "$1" ]; then
    echo -e "\nPlease specify source file."
    echo -e "Usage:\n\t$0 <source>\n"
    echo -e
    exit
fi

ACME=~/c64-linux-devkit/bin/acme
PUCRUNCH=~/c64-linux-devkit/bin/pucrunch
VICE=/usr/bin/x64

TEMPFILE=/tmp/out.prg
SYMBOLS=/tmp/symbols
REPORT=/tmp/report

ACME_ARGS="-r ${REPORT} --vicelabels ${SYMBOLS} --msvc --color --format cbm -v3 -o ${TEMPFILE} $1"
PUCRUNCH_ARGS="-x0x0801 -c64 -g55 -fshort ${TEMPFILE} ${TEMPFILE}"

${ACME} ${ACME_ARGS}
${PUCRUNCH} ${PUCRUNCH_ARGS}
${VICE} -autostartprgmode 0 ${TEMPFILE}
