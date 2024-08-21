#!/bin/bash

# Clone the Synfig repository
git clone https://github.com/synfig/synfig.git

# Move into the Synfig directory that was cloned
cd synfig

# Download Synfig's Dependencies
./1-setup-linux-native.sh

# Build Synfig for Production
./2-build-production.sh

# Copy the directory 'build' that contains the output of building Synfig next to the generate-synfig-appimage.sh script
cp -r _production/build ../