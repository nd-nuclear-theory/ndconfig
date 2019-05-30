#!/bin/csh
#
# Convert all csh "environment" scripts in directory to sh scripts.
#
# Uses: bashify.sed
#
# Mark A. Caprio
# University of Notre Dame
#
# 05/30/19 (mac): Created.

# Note: If you change the following glob pattern to "*.csh", bashify_all.csh
# will try to convert itself!  Which it cannot successfully do...

foreach source (env-*.csh)
  set target = ${source:r}.sh
  echo "Converting ${source} -> ${target}..."
  sed -E -f bashify.sed ${source} > ${target}
end

