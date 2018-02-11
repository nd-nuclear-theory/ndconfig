# bashify.sed -- convert csh script to bash
#
# Patrick J. Fasano
# University of Notre Dame
#
# Usage:
#   sed bashify.sed script.csh > script.sh
#
# 01/27/17 (pjf): Created.

# convert conditionals
s/if \( */if [[ /g
s/ *\) then/ ]]; then/g
s/else if/elif/g
s/endif/fi/g

# convert environment variables
/unset/!s/set ([^ =]+) *= */export \1=/g
s/setenv ([^ .]+) /export \1=/g
s/setenv ([^ .]+)/export \1/g
s/setenv/export/g
s/\$user/$USER/g
s/\$\{?HOST\}?/$HOSTNAME/g

# convert aliases
s/alias ([^ .]+) /alias \1=/g

# convert comments and references to other scripts
/\$\?/!s/tcsh/bash/g
/tcsh/!s/(\.?)cshrc/\1bashrc/g
/tcsh/!s/(\.?)Cshrc/\1Bashrc/g
s/\.csh/.sh/g
/tcsh/!s/csh/bash/g

# convert csh $?VAR to -n ${VAR+x}
s/\$\?([^ ]+)/-n ${\1+x}/g

# limit -> ulimit
s/limit coredumpsize/ulimit -c/g