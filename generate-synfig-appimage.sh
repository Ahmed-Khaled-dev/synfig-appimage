#!/bin/bash

SYNFIG_BUILD_PATH="./build"
SYNFIG_APPDIR_NAME="Synfig.AppDir"
ARCH=$(uname -m)

if [ "$ARCH" == "x86_64" ]; then
    # 64-bit architecture
    LINUXDEPLOY_URL="https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage"
    APPIMAGETOOL_URL="https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage"
elif [ "$ARCH" == "i686" ] || [ "$ARCH" == "i386" ]; then
    # 32-bit architecture
    LINUXDEPLOY_URL="https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-i386.AppImage"
    APPIMAGETOOL_URL="https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-i686.AppImage"
else
    echo "Unsupported architecture: $ARCH"
    exit 1
fi

# Install the latest release of linuxdeploy and the linuxdeploy gtk plugin
wget $LINUXDEPLOY_URL -O linuxdeploy.AppImage
wget "https://raw.githubusercontent.com/linuxdeploy/linuxdeploy-plugin-gtk/master/linuxdeploy-plugin-gtk.sh"
chmod +x linuxdeploy.AppImage linuxdeploy-plugin-gtk.sh

# Use linuxdeploy to generate the basic AppDir structure, bundle in Synfig.AppDir/usr/lib/ 
# the shared libraries that Synfig needs, and bundle additional resources that GTK needs using the linuxdeploy gtk plugin
./linuxdeploy.AppImage --appdir ${SYNFIG_APPDIR_NAME} --plugin gtk --executable ${SYNFIG_BUILD_PATH}/bin/synfigstudio --desktop-file ${SYNFIG_BUILD_PATH}/share/applications/org.synfig.SynfigStudio.desktop --icon-file ${SYNFIG_BUILD_PATH}/share/icons/hicolor/scalable/apps/org.synfig.SynfigStudio.svg

# Remove the linuxdeploy automatically generated AppRun file and replace it with Synfig's custom AppRun
rm -f ${SYNFIG_APPDIR_NAME}/AppRun
cp AppRun ${SYNFIG_APPDIR_NAME}

# Make sure rsync is installed on Debian (Since Debian 10 is what's currently used for packaging Synfig in an AppImage)
sudo apt install rsync

# Copy Synfig's share/ directory into the AppDir while excluding copying specific files that are not needed
rsync -av --exclude="mime-info/synfigstudio.keys" ${SYNFIG_BUILD_PATH}/share ${SYNFIG_APPDIR_NAME}/usr/
# -a stands for archive, which preserves permissions and everything related to the copied files
# -v stands for verbose, to show the output of the command

# Copy Synfig's etc/ directory into the AppDir
cp -rf ${SYNFIG_BUILD_PATH}/etc ${SYNFIG_APPDIR_NAME}/usr/

# Copy Synfig's extra shared libraries into the AppDir while excluding the unneeded *.la and *.pc files and not copying empty directories
rsync -av --exclude='*.la' --exclude='*.pc' --prune-empty-dirs ${SYNFIG_BUILD_PATH}/lib/ ${SYNFIG_APPDIR_NAME}/usr/lib/

# Copy pk-gtk-module into the AppDir, this fixes the error "Failed to load module pk-gtk-module" on Fedora 40
cp libpk-gtk-module.so ${SYNFIG_APPDIR_NAME}/usr/lib/gtk-3.0/modules/

# Install the latest release of the appimagetool
wget $APPIMAGETOOL_URL -O appimagetool.AppImage
chmod +x appimagetool.AppImage

# Use the appimagetool to generate Synfig's AppImage using the AppDir we have constructed
./appimagetool.AppImage ${SYNFIG_APPDIR_NAME}
