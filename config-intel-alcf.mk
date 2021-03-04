include $(NDCONFIG_DIR)/config-intel.mk

# use Cray programming environment compilers
FC := ftn
CXX := CC

CXXFLAGS += -ipo
FFLAGS += -ipo
F90FLAGS += -ipo

# keep binaries separate by target architecture
install_prefix := $(install_prefix)/$(CRAY_CPU_TARGET)
