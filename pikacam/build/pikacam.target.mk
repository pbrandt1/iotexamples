# This file is generated by gyp; do not edit.

TOOLSET := target
TARGET := pikacam
DEFS_Debug := \
	'-DNODE_GYP_MODULE_NAME=pikacam' \
	'-D_LARGEFILE_SOURCE' \
	'-D_FILE_OFFSET_BITS=64' \
	'-DBUILDING_NODE_EXTENSION' \
	'-DDEBUG' \
	'-D_DEBUG'

# Flags passed to all source files.
CFLAGS_Debug := \
	-fPIC \
	-pthread \
	-Wall \
	-Wextra \
	-Wno-unused-parameter \
	-m64 \
	-g \
	-std=c++11 \
	-Wall \
	-g \
	-O0

# Flags passed to only C files.
CFLAGS_C_Debug :=

# Flags passed to only C++ files.
CFLAGS_CC_Debug :=

INCS_Debug := \
	-I/home/peter/.node-gyp/0.12.7/src \
	-I/home/peter/.node-gyp/0.12.7/deps/uv/include \
	-I/home/peter/.node-gyp/0.12.7/deps/v8/include \
	-I/usr/local/include \
	-I$(srcdir)/node_modules/nan

DEFS_Release := \
	'-DNODE_GYP_MODULE_NAME=pikacam' \
	'-D_LARGEFILE_SOURCE' \
	'-D_FILE_OFFSET_BITS=64' \
	'-DBUILDING_NODE_EXTENSION'

# Flags passed to all source files.
CFLAGS_Release := \
	-fPIC \
	-pthread \
	-Wall \
	-Wextra \
	-Wno-unused-parameter \
	-m64 \
	-g \
	-std=c++11 \
	-Wall \
	-O3 \
	-ffunction-sections \
	-fdata-sections \
	-fno-tree-vrp \
	-fno-omit-frame-pointer

# Flags passed to only C files.
CFLAGS_C_Release :=

# Flags passed to only C++ files.
CFLAGS_CC_Release :=

INCS_Release := \
	-I/home/peter/.node-gyp/0.12.7/src \
	-I/home/peter/.node-gyp/0.12.7/deps/uv/include \
	-I/home/peter/.node-gyp/0.12.7/deps/v8/include \
	-I/usr/local/include \
	-I$(srcdir)/node_modules/nan

OBJS := \
	$(obj).target/$(TARGET)/pikacam.o

# Add to the list of files we specially track dependencies for.
all_deps += $(OBJS)

# CFLAGS et al overrides must be target-local.
# See "Target-specific Variable Values" in the GNU Make manual.
$(OBJS): TOOLSET := $(TOOLSET)
$(OBJS): GYP_CFLAGS := $(DEFS_$(BUILDTYPE)) $(INCS_$(BUILDTYPE))  $(CFLAGS_$(BUILDTYPE)) $(CFLAGS_C_$(BUILDTYPE))
$(OBJS): GYP_CXXFLAGS := $(DEFS_$(BUILDTYPE)) $(INCS_$(BUILDTYPE))  $(CFLAGS_$(BUILDTYPE)) $(CFLAGS_CC_$(BUILDTYPE))

# Suffix rules, putting all outputs into $(obj).

$(obj).$(TOOLSET)/$(TARGET)/%.o: $(srcdir)/%.cc FORCE_DO_CMD
	@$(call do_cmd,cxx,1)

# Try building from generated source, too.

$(obj).$(TOOLSET)/$(TARGET)/%.o: $(obj).$(TOOLSET)/%.cc FORCE_DO_CMD
	@$(call do_cmd,cxx,1)

$(obj).$(TOOLSET)/$(TARGET)/%.o: $(obj)/%.cc FORCE_DO_CMD
	@$(call do_cmd,cxx,1)

# End of this set of suffix rules
### Rules for final target.
LDFLAGS_Debug := \
	-pthread \
	-rdynamic \
	-m64 \
	-L/usr/local/lib

LDFLAGS_Release := \
	-pthread \
	-rdynamic \
	-m64 \
	-L/usr/local/lib

LIBS := \
	-lopencv_shape \
	-lopencv_stitching \
	-lopencv_objdetect \
	-lopencv_superres \
	-lopencv_videostab \
	-lopencv_calib3d \
	-lopencv_features2d \
	-lopencv_highgui \
	-lopencv_videoio \
	-lopencv_imgcodecs \
	-lopencv_video \
	-lopencv_photo \
	-lopencv_ml \
	-lopencv_imgproc \
	-lopencv_flann \
	-lopencv_core \
	-lopencv_hal

$(obj).target/pikacam.node: GYP_LDFLAGS := $(LDFLAGS_$(BUILDTYPE))
$(obj).target/pikacam.node: LIBS := $(LIBS)
$(obj).target/pikacam.node: TOOLSET := $(TOOLSET)
$(obj).target/pikacam.node: $(OBJS) FORCE_DO_CMD
	$(call do_cmd,solink_module)

all_deps += $(obj).target/pikacam.node
# Add target alias
.PHONY: pikacam
pikacam: $(builddir)/pikacam.node

# Copy this to the executable output path.
$(builddir)/pikacam.node: TOOLSET := $(TOOLSET)
$(builddir)/pikacam.node: $(obj).target/pikacam.node FORCE_DO_CMD
	$(call do_cmd,copy)

all_deps += $(builddir)/pikacam.node
# Short alias for building this executable.
.PHONY: pikacam.node
pikacam.node: $(obj).target/pikacam.node $(builddir)/pikacam.node

# Add executable to "all" target.
.PHONY: all
all: $(builddir)/pikacam.node
