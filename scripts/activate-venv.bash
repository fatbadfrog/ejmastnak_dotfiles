#!/bin/bash
# Literally just a one-liner to call from VIFM, because for whatever reason I
# can get the source command to run from VIFM's :! command mode directly, but
# indirectly calling a shell script that does the same thing seems to work.
#
# I.e. 
# Works: nnoremap EE :!activate-venv.bash<CR>
# Doesn't work: nnoremap EE :!source ./venv/bin/activate && vifm ./ ./<CR>

if [[ -e "./venv/bin/activate" ]]; then
  source ./venv/bin/activate && vifm -c "goto ${VIFM_FILE_UNDER_CURSOR}" ./ ./
fi
