BUILD_DIR = build/

all:
	mkdir -p $(BUILD_DIR)
	gcc -x objective-c -arch i386 -arch x86_64 -std=c99 -framework Foundation -dynamiclib -o $(BUILD_DIR)gdbinit_utils-simulator.dylib gdbinit_utils.m
	# TODO: iOS version must not be hardcoded
	/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/gcc -arch armv6 -arch armv7 -std=c99 -framework Foundation \
	    -isysroot /Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS4.2.sdk -dynamiclib -o $(BUILD_DIR)gdbinit_utils-device.dylib gdbinit_utils.m
	lipo -create $(BUILD_DIR)gdbinit_utils-simulator.dylib $(BUILD_DIR)gdbinit_utils-device.dylib -output $(BUILD_DIR)gdbinit_utils.dylib
	
tests:
	mkdir -p $(BUILD_DIR)
	gcc -x objective-c -arch i386 -std=c99 -framework Foundation -o $(BUILD_DIR)gdbinit_utils_tests_i386 gdbinit_utils.m gdbinit_utils_tests.m
	gcc -x objective-c -arch x86_64 -std=c99 -framework Foundation -o $(BUILD_DIR)gdbinit_utils_tests_x86_64 gdbinit_utils.m gdbinit_utils_tests.m
	$(BUILD_DIR)gdbinit_utils_tests_i386
	$(BUILD_DIR)gdbinit_utils_tests_x86_64
	
clean:
	rm -rf $(BUILD_DIR)