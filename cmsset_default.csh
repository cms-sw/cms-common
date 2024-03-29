set cms_basedir=@CMS_PREFIX@
if (${?PATH}) then
    setenv PATH ${cms_basedir}/common:$PATH
else
    setenv PATH ${cms_basedir}/common
endif

set here=${cms_basedir}

if ( ${?VO_CMS_SW_DIR} ) then
    set here=$VO_CMS_SW_DIR
else
    if ( ${?OSG_APP} ) then
        set here=$OSG_APP/cmssoft/cms
    endif
endif

if ( ! ${?SCRAM_ARCH}) then
    setenv SCRAM_ARCH `sh -c ${cms_basedir}/common/cmsarch`
    if ( ! -d $here/${SCRAM_ARCH}/etc/profile.d ) then
      setenv SCRAM_ARCH `echo ${SCRAM_ARCH} | cut -d_ -f1 | sed -E 's/^(cs|cc|alma|rocky|rhel)/el/'`_`echo ${SCRAM_ARCH} | cut -d_ -f2-`
    endif
endif

foreach arch (share ${SCRAM_ARCH})
  if ( -d $here/${arch}/etc/profile.d ) then
    foreach pkg ( `/bin/ls ${here}/${arch}/etc/profile.d/ | grep 'S.*[.]csh'` )
          source ${here}/${arch}/etc/profile.d/$pkg
    end
  endif
  unset pkg
end

if ( ! ${?CMS_PATH} ) then
    setenv CMS_PATH $here
endif

# decouple SITECONF location form CMS_PATH to allow sub-sites:
if ( ! ${?SITECONFIG_PATH} ) then
    setenv SITECONFIG_PATH ${CMS_PATH}/SITECONF/local
endif

# aliases
alias cmsenv 'eval `scramv1 runtime -csh`'
alias cmsrel 'scramv1 project CMSSW'

if( -e $SITECONFIG_PATH/JobConfig/cmsset_local.csh ) then
        source $SITECONFIG_PATH/JobConfig/cmsset_local.csh
endif

if ( ! ${?CVSROOT}) then
  setenv CVSROOT :gserver:cmssw.cvs.cern.ch:/local/reps/CMSSW
endif

if (${?MANPATH}) then
  setenv MANPATH $CMS_PATH/share/man:$MANPATH
else
  setenv MANPATH $CMS_PATH/share/man
endif

unset here cms_basedir arch
