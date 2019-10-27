# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-wordbook

CONFIG += sailfishapp

# Path to installation of CURLPP
CONFIG(debug,debug|release){ CURLPP_PATH = lib/curlpp-inst-arm }
CONFIG(release,debug|release){ CURLPP_PATH = lib/curlpp-inst-i486 }

# Add curlpp include files
INCLUDEPATH += $$CURLPP_PATH/include

# Tell linker to link libcurl first, then libcurlpp
LIBS += -lcurl\
-L$$PWD/$$CURLPP_PATH/lib\
-lcurlpp

# Install file on system
lib.files += $$CURLPP_PATH/lib/libcurlpp.so\
$$CURLPP_PATH/lib/libcurlpp.so.1\
$$CURLPP_PATH/lib/libcurlpp.so.1.0.0

lib.path = /usr/share/$$TARGET/lib
INSTALLS += lib

SOURCES += src/harbour-wordbook.cpp \
    src/dict_model.cpp \
    dictcc/dict/dict_imp.cc \
    dictcc/dict/desv.cc \
    dictcc/dict/deen.cc \
    dictcc/dict/denl.cc

DISTFILES += qml/harbour-wordbook.qml \
    qml/cover/CoverPage.qml \
    rpm/harbour-wordbook.changes.in \
    rpm/harbour-wordbook.changes.run.in \
    rpm/harbour-wordbook.spec \
    rpm/harbour-wordbook.yaml \
    translations/*.ts \
    harbour-wordbook.desktop \
    qml/pages/About.qml \
    qml/pages/FirstPage.qml \
    qml/pages/Settings.qml

SAILFISHAPP_ICONS = 86x86 108x108 128x128 172x172

# to disable building translations every time, comment out the
# following CONFIG line
# CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
# TRANSLATIONS += translations/harbour-wordbook-de.ts

HEADERS += \
    src/dict_model.h \
    dictcc/dict.h \
    dictcc/dict/types.h \
    dictcc/dict/exceptions.h \
    dictcc/dict/dict_int.h \
    dictcc/dict/desv.h \
    dictcc/dict/deen.h \
    dictcc/dict/creator.h \
    dictcc/dict/denl.h
