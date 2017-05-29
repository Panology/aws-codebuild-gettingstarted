# Enable us to call ourselves robustly
# - See http://stackoverflow.com/a/27132934
THIS_FILE := $(lastword $(MAKEFILE_LIST))

# Tools
RM := /bin/rm
MVN = /usr/bin/mvn
ZIP := /usr/bin/zip

# Directories
DIST := dist

# Files
STATEFILES := build
BUILDPKG := MessageUtil.zip
SRCFILES := buildspec.yml pom.xml src/

# These are our phony targets
.PHONY: clean test

# Our default target
.DEFAULT_GOAL := build

# Target to keep things tidy
clean:
	$(RM) -rf $(DIST)
	$(RM) -f $(STATEFILES)
	$(MVN) clean

# Target to build our package(s)
build: $(DIST)/$(BUILDPKG)
	@touch build

# Our CodeBuild Input Articact
$(DIST)/$(BUILDPKG): $(SRCFILES)
ifeq ($(filter clean,$(MAKECMDGOALS)),)
	@$(MAKE) -f $(THIS_FILE) clean # Start by cleaning things out
endif
	mkdir $(DIST)
	$(ZIP) -r $(DIST)/$(BUILDPKG) $(SRCFILES)

# Target to test the code
test: clean
	$(MVN) test
