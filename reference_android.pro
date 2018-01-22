QT       += core gui quick

TARGET = N_Reines

TEMPLATE = app

RESOURCES += \
    reference_android.qrc

HEADERS += \
    cpp/context.h \
    cpp/n_reines.h \
    cpp/thread.h

SOURCES += \
    cpp/main.cpp \
    cpp/context.cpp \
    cpp/n_reines.cpp

DISTFILES += \
    android-sources/AndroidManifest.xml

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android-sources
