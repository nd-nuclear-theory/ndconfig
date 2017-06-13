include config/ndconfig/config-intel.mk

# enable all extensions available on the local processor
CFLAGS += -xHOST
CXXFLAGS += -xHOST
FFLAGS += -xHOST

LDLIBS +=  -lgslcblas
