include config/ndconfig/config-gnu.mk

# use Cray programming environment compilers
FC := ftn
CXX := CC

# keep binaries separate by target architecture
install_prefix := $(install_prefix)/$(CRAY_CPU_TARGET)
