include $(NDCONFIG_DIR)/config-clang.mk

# use Cray programming environment compilers
FC := ftn
CC := cc
CXX := CC

# keep binaries separate by target architecture
install_prefix := $(install_prefix)/$(CRAY_CPU_TARGET)
