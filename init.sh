#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
echo "Use path: $SCRIPTPATH/"
cd $SCRIPTPATH

case "$(uname -s)" in
    Linux*)  windows=0;mac=0;;
    Darwin*) windows=0;mac=1;;
    CYGWIN*) windows=1;mac=0;;
    MINGW*)  windows=1;mac=0;;
    *)       windows=0;mac=0
esac

# Remove all pub caches
if [ "$windows" != "1" ]; then
    rm -Rf ~/.pub-cache/

    if [ "$mac" == "1" ]; then
        rm -Rf ~/Library/Developer/Xcode/DerivedData
        rm -Rf ~/.cocoapods/
    fi
else
    rm -Rf ~/AppData/Local/Pub/Cache
    rm -Rf ~/AppData/Roaming/Pub/Cache
fi

# Remove all logs and temp files
rm -Rf .dart_tool/
rm -Rf .flutter-plugins
rm -Rf .flutter-plugins-dependencies
rm -Rf *.iml
rm -Rf *.lock
rm -Rf *.log
rm -Rf android/.gradle/
rm -Rf android/.idea/
rm -Rf build/

if [ "$mac" == "1" ]; then
    rm -Rf ios/.symlinks/
    rm -Rf ios/Flutter/Flutter.framework
    rm -Rf ios/Flutter/Flutter.podspec
    rm -Rf ios/Pods/
    rm -Rf ios/Runner.xcworkspace
fi

# Upgrade the framework (only works on mac) bash configbash
if [ "$windows" != "1" ]; then
    flutter channel stable
    flutter upgrade --force
fi

# Get pub packages
if [ ! -e .packages ]; then
    flutter pub get
else
    flutter clean
    flutter pub cache repair
    flutter pub upgrade
fi

# Install ios packages (only works on mac)
if [ "$mac" == "1" ]; then
    cd ios
    pod deintegrate
    pod install --clean-install
    cd ..
fi

# Get packages for sub modules
get_modules() {
    local root=$(pwd)
    local path="$1"
    cd $path
    flutter packages get
    cd $root
}
for folder in modules/*; do
    if [ -d "$folder" ]; then get_modules "$folder"; fi
done

# Get the flutter packages
flutter config --no-analytics
flutter doctor --android-licenses
flutter packages get

# Run flutter doctor
clear ; flutter doctor -v
