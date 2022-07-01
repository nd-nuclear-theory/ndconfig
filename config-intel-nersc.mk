include $(NDCONFIG_DIR)/config-intel.mk

# use Cray programming environment compilers
FC := ftn
CXX := CC

CXXFLAGS += -ip
FFLAGS += -ip
F90FLAGS += -ip

# icpc is only compatible with older libstdc++ headers, and it is tricked into
# finding them by setting an older GCC compiler path... (mac 220317)
#
# https://bitbucket.org/berkeleylab/upcxx/wiki/docs/alt-compilers#markdown-header-intel (mac 03/17/22)
CXXFLAGS += -gxx-name=/opt/gcc/8.3.0/bin/g++
CXXFLAGS += -gcc-name=/opt/gcc/8.3.0/bin/gcc
CXXFLAGS += -Wl,-rpath=/opt/gcc/8.3.0/snos/lib64/

# keep binaries separate by target architecture
install_prefix := $(install_prefix)/$(CRAY_CPU_TARGET)
