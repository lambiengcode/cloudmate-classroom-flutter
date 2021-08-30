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

if [ -e ./build ]; then
    rm -rf ./build
fi

flutter format modules lib test
flutter clean
flutter pub get
clear

# Analyze before build
flutter analyze
if [ ! $? -eq 0 ]; then
    exit 1
fi

# Generate app icons & splash screen
flutter pub run flutter_launcher_icons:main

# Remove ununsed icons
rm -f ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-50x50@1x.png
rm -f ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-50x50@2x.png
rm -f ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-57x57@1x.png
rm -f ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-57x57@2x.png
rm -f ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-72x72@1x.png
rm -f ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-72x72@2x.png

if [ "$1" == "run" ]; then
  # Run on all devices
  flutter run -d all
else
  # Android App Bundle
  # Support app bundles with 32-bit and 64-bit binaries
  # https://github.com/flutter/flutter/issues/3192＃
  # brew cask install java
  # brew install gradle
  flutter build appbundle --release --shrink --split-debug-info=build/debug_info $@

  if [ "$mac" == "1" ]; then
      # Short pause
      sleep 3

      # iOS Build
      flutter build ios --release --obfuscate --split-debug-info=build/debug_info $@
      if [ $? -eq 0 ]; then
          du -sh build/ios/iphoneos/Runner.app
          rm -Rf build/ios/iphoneos/Runner.app
      fi
  fi
fi
