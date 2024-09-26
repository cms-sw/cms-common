#! /bin/bash

# Tab completion for cmsrel
function _cmsrel() {
  local RELEASES=$(scramv1 list -c CMSSW | awk '{ print $2 }' | sort)
  COMPREPLY=($(compgen -W "$RELEASES" "${COMP_WORDS[$COMP_CWORD]}"))
}

complete -F _cmsrel cmsrel
