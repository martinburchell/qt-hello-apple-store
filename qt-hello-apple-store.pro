# =============================================================================
# Parts of Qt
# =============================================================================

QT += network  # required to #include <QtNetwork/...>
QT += widgets  # required to #include <QApplication>

# =============================================================================
# Overall configuration
# =============================================================================

CONFIG += mobility
CONFIG += c++11
CONFIG += static

DEFINES += QT_DEPRECATED_WARNINGS


# =============================================================================
# Compiler and linker flags
# =============================================================================

gcc {
    QMAKE_CXXFLAGS += -Werror  # warnings become errors
}

if (gcc | clang):!ios:!android {
    QMAKE_CXXFLAGS += -Wno-deprecated-copy
}

gcc {
    QMAKE_CXXFLAGS += -fvisibility=hidden
}

# =============================================================================
# Build targets
# =============================================================================

TARGET = qt-hello-apple-store
TEMPLATE = app

# -----------------------------------------------------------------------------
# Architecture
# -----------------------------------------------------------------------------


ios: {
    CONFIG(iphoneos, iphoneos|iphonesimulator) {
        message("Building for iPhone OS")
        contains(QT_ARCH, arm64) {
            message("Building for iOS/ARM v8 64-bit architecture")
            ARCH_TAG = "ios_armv8_64"
        } else {
            message("Building for iOS/ARM v7 (32-bit) architecture")
            ARCH_TAG = "ios_armv7"
        }
    }

    CONFIG(iphonesimulator, iphoneos|iphonesimulator) {
        message("Building for iPhone Simulator")
        ARCH_TAG = "ios_x86_64"
    }

    disable_warning.name = "GCC_WARN_64_TO_32_BIT_CONVERSION"
    disable_warning.value = "No"
    QMAKE_MAC_XCODE_SETTINGS += disable_warning

    QMAKE_TARGET_BUNDLE_PREFIX = "uk.ac.cam.psychiatry"
    QMAKE_BUNDLE = "hello"

    QMAKE_INFO_PLIST = $${PWD}/ios/Info.plist

    app_launch_screen.files = $$files($${PWD}/ios/LaunchScreen.storyboard)
    QMAKE_BUNDLE_DATA += app_launch_screen

    QMAKE_ASSET_CATALOGS = $${PWD}/ios/Images.xcassets
    QMAKE_ASSET_CATALOGS_APP_ICON = "AppIcon"
}

# =============================================================================
# Source files
# =============================================================================

SOURCES += \
    main.cpp
