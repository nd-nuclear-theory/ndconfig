################################################################
# directory trees
################################################################

# search prefix
#
#   additional path to search for required include and lib 
#   directories
#
#   Multiple base directories may be listed, delimited by spaces.
#
#   Thus,
#
#     search_prefix := <base1> <base2>
#
#   means to search for include files in
#     
#     <base1>/include  <base2>/include
#
#   and library files n 
#
#     <base1>/lib  <base2>/lib

# Note: If you have anything to add to the search path, you may wish
# to leave this definition of the search_prefix as it is, and then
# append to it in a separate config.mk which includes this generic
# config file.
#
#   include config_gcc4.mk

search_prefix := $(EIGEN3_DIR) $(GSL_DIR) $(BOOST_ROOT) $(MKLROOT)

# directories to directly include in include path or lib path
#
#   only for use as a fallback if the traditional search prefix scheme
#   above fails for a given installation
search_dirs_include := $(EIGEN3_DIR)/include/eigen3
search_dirs_lib :=

# install prefix (only if you want to install the binaries somewhere)
#
# e.g., you would set to /usr/local to do a systemwide installation.
# This is analagous to the --prefix= option of autoconf installations.
install_prefix := $(MCSCRIPT_INSTALL_DIR)


################################################################
# C++ compiler-specific configuration
################################################################

# C++ compiler
CXX := icpc

# langage standard
CXXFLAGS += -std=c++11 -qopenmp

# optimization mode
CXXFLAGS += -O3

# MKL linking
CXXFLAGS += -DEIGEN_USE_MKL_ALL
LDLIBS += -mkl

# debugging mode
#
# Define environment variable DEBUG on make command line to enable.
ifdef DEBUG
CXXFLAGS += -g
endif

################################################################
# FORTRAN compiler-specific configuration
################################################################

# FORTRAN compiler 
# Example values:
#   for GCC 3.x: f77
#   for GCC 4.x: gfortran
#   for Intel: ifort

FC := ifort

FFLAGS += -qopenmp -frecursive

################################################################
# C++/FORTRAN linking 
#    with C++ main()
################################################################

# FORTRAN object libraries (added to LDLIBS)
# Example values, depending on the compiler you are using to compile
# the FORTRAN objects:
#   for GCC 3.x f77: -lg2c
#   for GCC 4.x gfortran: -lgfortran
#   for Intel ifort: -lifport -lifcore -limf

fortran_libs := -lifport -lifcore -limf

# FORTRAN linking flags (added to LDFLAGS)
# Not yet needed but provided as hook.

fortran_flags :=
