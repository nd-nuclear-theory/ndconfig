include config/ndconfig/config-intel.mk

# use Cray programming environment compilers
FC := ftn
CXX := CC

# keep binaries separate by target architecture
install_prefix := $(MCSCRIPT_INSTALL_DIR)/$(CRAY_CPU_TARGET)
