#!/bin/bash
GSL_tool="${LOCALTOP}/config/toolbox/${SCRAM_ARCH}/tools/selected/gsl.xml"
[ -e "${GSL_tool}" ] || exit 0
! grep -q 'name="PATH"' "${GSL_tool}" || exit 0
[ -z "${SCRAM}" ] && SCRAM=scram
GSL_BASE=$(${SCRAM} tool tag gsl GSL_BASE)
[ -e "${GSL_BASE}/bin/gsl-config" ] || exit 0
if [ $(grep gslcblas ${GSL_BASE}/bin/gsl-config | wc -l) -gt 0 ] ; then
  echo "RUNTIME:variable:GSL_CBLAS_LIB=-L$(${SCRAM} tool tag openblas LIBDIR) -l$(${SCRAM} tool tag openblas LIB)"
fi
echo "RUNTIME:path:append:PATH=${GSL_BASE}/bin"
