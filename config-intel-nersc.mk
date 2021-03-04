include ../ndconfig/config-intel.mk

# use Cray programming environment compilers
FC := ftn
CXX := CC

CXXFLAGS += -ip
FFLAGS += -ip
F90FLAGS += -ip

# keep binaries separate by target architecture
install_prefix := $(install_prefix)/$(CRAY_CPU_TARGET)
