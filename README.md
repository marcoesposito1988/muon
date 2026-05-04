<p align="center">
  <img src="https://github.com/evgeniy-harchenko/muon/blob/master/assets/logo.png" width=150 />
  <h1 align="center">Muon Qt6</h1>
  <p align="center">Manage applications and libraries installed on your system at the package level. Search, install and remove packages, and inspect their versions and dependencies.</p>
</p>

<p align="center">
  <img src="https://github.com/evgeniy-harchenko/muon/blob/master/assets/image.png"/>
</p>

## Install from .deb

Download the latest `.deb` from the [Releases](https://github.com/obook/muon/releases) page, then run:

```bash
sudo apt install ./muon_6.0.0-1_amd64.deb
```

The package bundles libqapt (Qt6/KF6), so no separate installation is required.

## Build from source

The build script handles everything automatically: installing dependencies, downloading and compiling libqapt (Qt6/KF6), building muon, and packaging a `.deb`.

```bash
git clone https://github.com/obook/muon.git
cd muon
bash build.sh
sudo apt install ./muon_6.0.0-1_amd64.deb
```

### Build dependencies

```bash
sudo apt install cmake build-essential extra-cmake-modules qt6-base-dev libkf6kio-dev libkf6dbusaddons-dev libkf6i18n-dev libkf6iconthemes-dev libkf6xmlgui-dev libxapian-dev libapt-pkg-dev libpolkit-qt6-1-dev debhelper curl
```

### Runtime dependencies

```bash
sudo apt install apt-xapian-index software-properties-qt
```

## Development

On Kubuntu 26.04, a different QApt library is needed than the one in the system APT repositories.

The build.sh script automatically downloads and compiles the expected version of libqapt. It is possible to 
use it for development in a convenient way:

1. Clone the repository.
2. Run `bash build.sh` to build and install muon.
3. Pass `-DQApt_DIR=<repository path>/build/libqapt-stage/usr/lib/x86_64-linux-gnu/cmake/QApt/` to CMake when building your project.

## Notes

- Requires KDE Neon or Ubuntu 24.04+ with KF6 packages.
- Conflicts with the system `libqapt3` package (Qt5 version), which is removed automatically during install.
