TARGET = glacier-settings

CONFIG += c++11 link_pkgconfig
PKGCONFIG += glacierapp
LIBS += -lglacierapp

SOURCES += \
    src/main.cpp \
    src/models/settingsmodel.cpp \
    src/models/imagesmodel.cpp \
    src/models/settingsproxymodel.cpp

HEADERS += \
    src/models/settingsmodel.h \
    src/models/imagesmodel.h \
    src/models/settingsproxymodel.h

QT += qml quick

OTHER_FILES +=rpm/glacier-settings.spec \
    translations/*.ts \
    glacier-settings.desktop \
    privileges

TRANSLATIONS += translations/glacier-settings_en.ts\
                translations/glacier-settings_ru.ts

i18n_files.files = translations
i18n_files.path = /usr/share/$$TARGET
INSTALLS += i18n_files

target.path = /usr/bin

icon.files = glacier-settings.png
icon.path = /usr/share/glacier-settings/

desktop.files = glacier-settings.desktop
desktop.path = /usr/share/applications

privileges.files = glacier-settings.privileges
privileges.path = /usr/share/mapplauncherd/privileges.d/

qml.files = qml/glacier-settings.qml \
            qml/components/ \
            qml/img

qml.path = /usr/share/glacier-settings/qml

exampleplugin.files = qml/plugins/example/example.qml\
                      qml/plugins/example/example.svg
exampleplugin.path = /usr/share/glacier-settings/qml/plugins/example

bluez4plugin.files = qml/plugins/bluez4/bluez4.qml\
                        qml/plugins/bluez4/bluez4.svg
bluez4plugin.path = /usr/share/glacier-settings/qml/plugins/bluez4

developermodeplugin.files = qml/plugins/developermode/developermode.qml\
                            qml/plugins/developermode/developermode.svg
developermodeplugin.path = /usr/share/glacier-settings/qml/plugins/developermode

displayplugin.files = qml/plugins/display/display.qml\
                      qml/plugins/display/display.svg
displayplugin.path = /usr/share/glacier-settings/qml/plugins/display

wifiplugin.files = qml/plugins/wifi/wifi.qml\
                   qml/plugins/wifi/WifiSettings.qml\
                   qml/plugins/wifi/WifiStatus.qml\
                   qml/plugins/wifi/wifi.svg\
                   qml/plugins/wifi/SavedServices.qml\
                   qml/plugins/wifi/SavedStatus.qml\
                   qml/plugins/wifi/NetworkDelegate.qml

wifiplugin.path = /usr/share/glacier-settings/qml/plugins/wifi

gpsplugin.files =  qml/plugins/gps/gps.qml \
                   qml/plugins/gps/gps.svg

gpsplugin.path = /usr/share/glacier-settings/qml/plugins/gps

languageplugin.files =  qml/plugins/language/language.qml \
                   qml/plugins/language/language.svg

languageplugin.path = /usr/share/glacier-settings/qml/plugins/language

aboutplugin.files =  qml/plugins/about/*.qml \
                    qml/plugins/about/*.svg \
                    qml/plugins/about/icon-glacier-icon.png
aboutplugin.path = /usr/share/glacier-settings/qml/plugins/about

keyboardplugin.files =  qml/plugins/keyboard/keyboard.qml \
                   qml/plugins/keyboard/keyboard.svg

keyboardplugin.path = /usr/share/glacier-settings/qml/plugins/keyboard

languageconfigs.files = configs/supported-languages/*
languageconfigs.path = /usr/share/jolla-supported-languages/

pluginconfigs.files = qml/plugins/example/example.json \
                      qml/plugins/bluez4/bluez4.json \
                      qml/plugins/developermode/developermode.json \
                      qml/plugins/display/display.json \
                      qml/plugins/wifi/wifi.json \
                      qml/plugins/gps/gps.json\
                      qml/plugins/language/language.json\
                      qml/plugins/about/about.json\
                      qml/plugins/keyboard/keyboard.json

pluginconfigs.path = /usr/share/glacier-settings/plugins

INSTALLS += target \
            desktop \
            qml \
            privileges \
            pluginconfigs \
            exampleplugin \
            bluez4plugin \
            developermodeplugin \
            displayplugin \
            wifiplugin \
            gpsplugin\
            languageplugin \
            aboutplugin \
            languageconfigs\
            icon \
            keyboardplugin

DISTFILES += \
    qml/plugins/example/example.qml \
    qml/plugins/example/example.json \
    qml/plugins/bluez4/bluez4.json \
    qml/plugins/bluez4/bluez4.qml \
    qml/plugins/developermode/developermode.qml \
    qml/plugins/developermode/developermode.json \
    qml/plugins/display/display.qml \
    qml/plugins/display/display.json \
    qml/plugins/wifi/wifi.qml \
    qml/plugins/wifi/wifi.json \
    qml/plugins/wifi/WifiSettings.qml \
    qml/plugins/wifi/WifiStatus.qml \
    qml/plugins/gps/gps.json \
    qml/plugins/gps/gps.svg \
    qml/plugins/gps/gps.qml \
    qml/components/SettingsColumn.qml \
    qml/plugins/language/language.qml \
    qml/plugins/language/language.json \
    qml/plugins/language/language.svg \
    translations/glacier-settings_en.ts \
    translations/glacier-settings_ru.ts \
    qml/plugins/about/about.qml \
    qml/plugins/about/about.json \
    qml/plugins/about/about.svg \
    qml/plugins/about/icon-glacier-icon.png \
    qml/plugins/about/magic.qml \
    qml/plugins/keyboard/keyboard.qml \
    qml/plugins/wifi/SavedServices.qml \
    qml/plugins/wifi/SavedStatus.qml \
    qml/plugins/wifi/NetworkDelegate.qml
