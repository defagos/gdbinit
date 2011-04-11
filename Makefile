BUILD_DIR = build/

all:
	mkdir -p $(BUILD_DIR)
	gcc -arch i386 -arch x86_64 -std=c99 gdbinit_utils.c -dynamiclib -o $(BUILD_DIR)gdbinit_utils-simulator.dylib
	# TODO: iOS version must not be hardcoded
	/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/gcc -arch armv6 -arch armv7 -std=c99 -isysroot /Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS4.2.sdk -dynamiclib -o $(BUILD_DIR)gdbinit_utils-device.dylib gdbinit_utils.c
	lipo -create $(BUILD_DIR)gdbinit_utils-simulator.dylib $(BUILD_DIR)gdbinit_utils-device.dylib -output $(BUILD_DIR)gdbinit_utils.dylib
	
clean:
	rm -rf $(BUILD_DIR)