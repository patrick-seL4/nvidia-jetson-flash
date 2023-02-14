BUILD_DIR = build

.PHONY: clean
clean:
	rm -rf build/*

.PHONY: build
build:
	# Extract Jetson (e.g. Jetson_Linux_R35.1.0_aarch64.tbz2)
	tar xvf $(JETSON_PATH) --directory=$(BUILD_DIR)




