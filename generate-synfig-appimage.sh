#!/bin/bash

SYNFIG_BUILD_PATH="./build"
SYNFIG_APPDIR_NAME="Synfig.AppDir"

# Install the latest release of linuxdeploy
wget https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage
chmod +x linuxdeploy-x86_64.AppImage

# Use linuxdeploy to generate the basic AppDir structure and detect and generate in Synfig.AppDir/usr/lib/ the shared libraries that Synfig needs
./linuxdeploy-x86_64.AppImage --appdir ${SYNFIG_APPDIR_NAME} --executable ${SYNFIG_BUILD_PATH}/bin/synfigstudio --desktop-file ${SYNFIG_BUILD_PATH}/share/applications/org.synfig.SynfigStudio.desktop --icon-file ${SYNFIG_BUILD_PATH}/share/icons/hicolor/scalable/apps/org.synfig.SynfigStudio.svg

# Remove the linuxdeploy automatically generated AppRun file and replace it with Synfig's custom AppRun
rm -f ${SYNFIG_APPDIR_NAME}/AppRun
cp AppRun ${SYNFIG_APPDIR_NAME}

# Copy Synfig's share/ directory into the AppDir while excluding copying specific files that are not needed
rsync -av --exclude="mime-info/synfigstudio.keys" ${SYNFIG_BUILD_PATH}/share ${SYNFIG_APPDIR_NAME}/usr/
# -a stands for archive, which preserves permissions and everything related to the copied files
# -v stands for verbose, to show the output of the command

# Copy Synfig's etc/ directory into the AppDir
cp -rf ${SYNFIG_BUILD_PATH}/etc ${SYNFIG_APPDIR_NAME}/usr/

# Copy Synfig's extra shared libraries into the AppDir while excluding the unneeded *.la and *.pc files and not copying empty directories
rsync -av --exclude='*.la' --exclude='*.pc' --prune-empty-dirs ${SYNFIG_BUILD_PATH}/lib/ ${SYNFIG_APPDIR_NAME}/usr/lib/

# Install the latest release of the appimagetool
wget https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage
chmod +x appimagetool-x86_64.AppImage

# Use the appimagetool to generate Synfig's x86_64 AppImage using the AppDir we have constructed
ARCH="x86_64"
./appimagetool-x86_64.AppImage ${SYNFIG_APPDIR_NAME}
