#!/bin/sh

# Build dependancies
# sudo apt install cmake build-essential extra-cmake-modules qt6-base-dev libkf6kio-dev kf6-kdbusaddons-dev libkf6i18n-dev kf6-kiconthemes-dev kf6-kxmlgui-dev libxapian-dev libapt-pkg-dev libpolkit-qt6-1-dev debhelper

# Runtime dependancies
# apt-xapian-index software-properties-qt

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Ask for sudo password upfront (needed for libqapt and muon install)
sudo -v || exit 1

# Build and install libqapt (Qt6/KF6) if not already installed
if ! pkg-config --exists qapt 2>/dev/null; then
    echo "=== Building libqapt (Qt6/KF6) ==="
    LIBQAPT_DIR="$SCRIPT_DIR/../libqapt"
    if [ ! -d "$LIBQAPT_DIR" ]; then
        echo "Error: libqapt sources not found at $LIBQAPT_DIR"
        echo "Download from: https://invent.kde.org/api/v4/projects/19666/repository/archive.tar.gz?sha=kf-6"
        exit 1
    fi
    rm -rf "$LIBQAPT_DIR/build"
    mkdir -p "$LIBQAPT_DIR/build" && cd "$LIBQAPT_DIR/build"
    cmake -DCMAKE_BUILD_TYPE=Release -DQT_MAJOR_VERSION=6 -DCMAKE_INSTALL_PREFIX=/usr -DKDE_INSTALL_INCLUDEDIR=/usr/include .. || exit 1
    make -j"$(nproc)" || exit 1
    sudo make install || exit 1
    echo "=== libqapt installed ==="
fi

# Build muon .deb package
cd "$SCRIPT_DIR"
rm -rf build
dpkg-buildpackage -us -uc -b -j"$(nproc)" || exit 1
echo "=== .deb package built ==="
ls -lh "$SCRIPT_DIR"/../muon_*.deb
