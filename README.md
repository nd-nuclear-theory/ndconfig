# ndconfig

Cluster-specific makefile configuration files

Coding protocol for maintaining the env files: The csh environment definition
files (env*.csh) files are the "master" files.  Any edits you make should be to
these.  Then, you should automatically generate the bash environment definition
files (env*.sh) from these by running bashify_all.csh.  Then commit all updated
files (both csh and bash).