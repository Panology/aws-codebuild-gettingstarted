# Enable us to call ourselves robustly
# - See http://stackoverflow.com/a/27132934
THIS_FILE := $(lastword $(MAKEFILE_LIST))

# Tools
RM := /bin/rm
MVN = /usr/bin/mvn
ZIP := /usr/bin/zip
CAT := $(if $(filter $(OS),Windows_NT), type, cat)
AWS := /usr/local/bin/aws

# Directories
DIST := dist

# Files
STATEFILES := build upload
BUILDPKG := MessageUtil.zip
SRCFILES := buildspec.yml pom.xml src/
CBINPUT := codebuild/input

# AWS Configs
REGION := $(shell $(CAT) config 2>/dev/null)
AWSOPTS := --region $(REGION)
BUCKET := ourpts-common-ohio-454844014023

# Make sure we have been configured first
config:
	$(error You must run ./configure first.)

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

# Target to upload the input package to S3
upload: config $(DIST)/$(BUILDPKG)
	$(AWS) $(AWSOPTS) s3 cp $(DIST)/$(BUILDPKG) s3://$(BUCKET)/$(CBINPUT)/
	@touch upload

#
# End
