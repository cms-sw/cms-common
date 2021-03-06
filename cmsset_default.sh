cms_basedir=@CMS_PREFIX@
here=${cms_basedir}
export PATH=${cms_basedir}/common:$PATH

if [ "$VO_CMS_SW_DIR" != ""  ]
then
    here=$VO_CMS_SW_DIR
else
    if [ ! "X$OSG_APP" = "X" ] && [ -d "$OSG_APP/cmssoft/cms" ]; then
        here="$OSG_APP/cmssoft/cms"
    fi
fi

if [ ! $SCRAM_ARCH ]
then
    SCRAM_ARCH=$(${cms_basedir}/common/cmsarch)
    if [ ! -d ${here}/${SCRAM_ARCH}/etc/profile.d ]
    then
      SCRAM_ARCH=@SCRAM_ARCH@
    fi
    export SCRAM_ARCH
fi

for arch in share ${SCRAM_ARCH} ; do
  if [ -d $here/${arch}/etc/profile.d ]
  then
    for pkg in $(/bin/ls $here/${arch}/etc/profile.d/ | grep 'S.*[.]sh')
    do
          source $here/${arch}/etc/profile.d/$pkg
    done
    unset pkg
  fi
done

if [ ! $CMS_PATH ]
then
    export CMS_PATH=$here
fi

# decouple SITECONF location form CMS_PATH to allow sub-sites:
if [ ! $SITECONFIG_PATH ]
then
    export SITECONFIG_PATH=${CMS_PATH}/SITECONF/local
fi

# aliases
alias cmsenv='eval `scramv1 runtime -sh`'
alias cmsrel='scramv1 project CMSSW'

if [ -f $SITECONFIG_PATH/JobConfig/cmsset_local.sh ]; then
        . $SITECONFIG_PATH/JobConfig/cmsset_local.sh
fi

if [ ! $CVSROOT ]
then
    CVSROOT=:gserver:cmssw.cvs.cern.ch:/local/reps/CMSSW
    export CVSROOT
fi

MANPATH=${CMS_PATH}/share/man:${MANPATH}
export MANPATH
unset here cms_basedir arch
