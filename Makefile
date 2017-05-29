
# Tools
ZIP := /usr/bin/zip

# Directories
DIST := dist

# Files
BUILDPKG := MessageUtil.zip
STATEFILES := build

# These are our phony targets
.PHONY: clean

# Our default target
.DEFAULT_GOAL := build

# Target to keep things tidy
clean:
	$(RM) -rf $(DIST)
	$(RM) -f $(STATFILES)

# Target to build our package(s)
build: $(DIST)/$(BUILDPKG)
	@touch build
