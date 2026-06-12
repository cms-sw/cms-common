#!/bin/bash
case $SCRAM_ARCH in
  slc5_*|slc6_*|slc7_* )
    tool="${LOCALTOP}/config/toolbox/${SCRAM_ARCH}/tools/selected/git.xml"
    [ -e "$tool" ] || exit 0
    if grep -q GIT_SSL_CAINFO "$tool" ; then
      [ -z "${SCRAM}" ] && SCRAM=scram
      old=$(${SCRAM} tool info git 2>&1 | grep 'GIT_SSL_CAINFO=' | sed 's|.*GIT_SSL_CAINFO=||')
      for new in /etc/pki/tls/certs/ca-bundle.crt ; do
        [ -e ${new} ] || continue
        echo "RUNTIME:path:replace:GIT_SSL_CAINFO=${old}=${new}"
        exit 0
      done
    fi
    ;;
esac
