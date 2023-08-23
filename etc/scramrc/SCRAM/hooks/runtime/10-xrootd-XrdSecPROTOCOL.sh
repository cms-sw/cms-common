#!/bin/bash
[ -z "${XrdSecPROTOCOL}" ] || exit 0
[ ! -z "${GLIDEIN_Factory}" ] || exit 0
[ ! -z "${SCRAM}" ] || SCRAM="scram"
ver=$(${SCRAM} tool info xrootd 2>&1 | grep '^Version *: ' | sed 's|^Version *: *||;s| *$||' | cut -d. -f1,2)
if [[ "${ver}" =~ ^(4.[6-9]|5.0)$ ]] ; then
  klist -s >/dev/null 2>&1 || echo "RUNTIME:variable:XrdSecPROTOCOL=gsi,ztn,unix"
fi
