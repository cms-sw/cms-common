#!/bin/bash
GSL_tool="${LOCALTOP}/config/toolbox/${SCRAM_ARCH}/tools/selected/gsl.xml"
[ -e "${GSL_tool}" ] || exit 0
[ -z "${SCRAM}" ] && SCRAM=scram
GSL_BASE=$(${SCRAM} tool tag gsl GSL_BASE)
[ -e "${GSL_BASE}/bin/gsl-config" ] || exit 0
if [ $(grep gslcblas ${GSL_BASE}/bin/gsl-config | wc -l) -gt 0 ] ; then
  OpenBLAS_tool="${LOCALTOP}/config/toolbox/${SCRAM_ARCH}/tools/selected/openblas.xml"
  if [ -e "${OpenBLAS_tool}" ] ; then
    echo "RUNTIME:variable:GSL_CBLAS_LIB=-L$(${SCRAM} tool tag openblas LIBDIR) -l$(${SCRAM} tool tag openblas LIB)"
  fi
fi
! grep -q 'name="PATH"' "${GSL_tool}" || exit 0
echo "RUNTIME:path:append:PATH=${GSL_BASE}/bin"
