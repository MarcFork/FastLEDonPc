SKETCH_ROOT := $(shell pwd)
BUILD_ROOT ?= build
SKETCH ?= $(shell find $(SKETCH_ROOT) -maxdepth 1 -name "*.ino")

TARGET := $(shell basename -s .ino $(SKETCH))

$(shell mkdir -p $(BUILD_ROOT))

CFLAGS += -Wall -Wextra
CFLAGS += -DARDUINO=101 -DSKETCH_FILE=\"$(SKETCH)\"
CFLAGS += -DFASTLED_SDL $(shell sdl2-config --cflags)

LDFLAGS += $(shell sdl2-config --libs)
LDFLAGS += -Wl,--gc-sections

DEPDIR := $(BUILD_ROOT)
DEPFLAGS = -MT $@ -MMD -MP -MF $(DEPDIR)/$*.Td
POSTCOMPILE = @mv -f $(DEPDIR)/$*.Td $(DEPDIR)/$*.d && touch $@

define add_lib
SRC_C    += $(shell find $1 -name '*.c')
SRC_CXX  += $(shell find $1 -name '*.cpp')

INCLUDES += -I$1
endef

INCLUDES += -Isrc/cores/arduino -Isrc/system
$(eval $(call add_lib,src))

$(foreach lib, $(ARDUINO_LIBS), $(eval $(call add_lib,libraries/$(lib))))

OBJECTS += $(SRC_C:%.c=$(BUILD_ROOT)/%.o)
OBJECTS += $(SRC_CXX:%.cpp=$(BUILD_ROOT)/%.o)

INCLUDES += $(foreach d, $(INC_DIR), -I$d)

SRCS += $(SRC_C)
SRCS += $(SRC_CXX)

$(TARGET): $(OBJECTS)
	$(CXX) $(OBJECTS) $(LDFLAGS) -o $@

clean:
	rm -r $(BUILD_ROOT)
	rm $(TARGET)

print:
	@echo "BUILD_ROOT:\t $(BUILD_ROOT)"
	@echo "INCLUDES:\t $(INCLUDES)"
	@echo "OBJECTS:\t $(OBJECTS)"
	@echo "SRCS:\t $(SRCS)"
	@echo "SKETCH:\t $(SKETCH)"

$(BUILD_ROOT)/%.o : %.c $(DEPDIR)/%.d
	mkdir -p `dirname $@`
	$(CC) $(DEPFLAGS) $(CFLAGS) $(INCLUDES) -c $< -o $@
	$(POSTCOMPILE)

$(BUILD_ROOT)/%.o : %.cpp $(DEPDIR)/%.d
	mkdir -p `dirname $@`
	$(CXX) $(DEPFLAGS) $(CFLAGS) $(INCLUDES) -c $< -o $@
	$(POSTCOMPILE)

$(DEPDIR)/%.d: ;
.PRECIOUS: $(DEPDIR)/%.d

include $(wildcard $(patsubst %,$(DEPDIR)/%.d,$(basename $(SRCS))))
