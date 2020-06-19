TEMPLATE = lib

TARGET = TaoQuick

QT += qml quick

CONFIG += plugin c++11 qtquickcompiler
CONFIG += file_copies

versionAtLeast(QT_VERSION, 5.15.0) {
    # 5.15 use new feature: qmltypes,QML_IMPORT_NAME
    CONFIG += qmltypes
    QML_IMPORT_NAME = $$TARGET
    QML_IMPORT_MAJOR_VERSION = 1
}

uri = $$TARGET
#load(taoVersion)
load(taoBundle)
load(taoBuildPath)
BundlePath = $$getBundlePath("TaoQuickApp")
#include(../TaoBundle.pri)
include(TaoQuick.pri)
include(TaoQuick/TaoQuickDesigner.pri)

CONFIG(debug, debug|release){
    DESTDIR = $${TaoQuick_RUN_TREE}/debug/$${BundlePath}$${uri}
} else {
    DESTDIR = $${TaoQuick_RUN_TREE}/release/$${BundlePath}$${uri}
}
setBuildPath($${TaoQuick_BUILD_TREE}/$${TARGET})

#copy_qmldir
!android {
#    copy_qmldir.target = $$DESTDIR/qmldir
#    copy_qmldir.depends = $$_PRO_FILE_PWD_/qmldir
#    win32 {
#        copy_qmldir.target ~= s,/,\\\\,g
#        copy_qmldir.depends ~= s,/,\\\\,g
#    }
#    copy_qmldir.commands = $${QMAKE_COPY_FILE} $${copy_qmldir.depends} $${copy_qmldir.target}
#    QMAKE_EXTRA_TARGETS += copy_qmldir
#    PRE_TARGETDEPS += $$copy_qmldir.target
    copy_qmldir.files = $$_PRO_FILE_PWD_/qmldir
    copy_qmldir.path = $$DESTDIR
    COPIES += copy_qmldir
}

#install_qmldir
!android {
    installPath = $$[QT_INSTALL_QML]/$${uri}
#    win32 {
#        installPath ~= s,/,\\,g
#    }
    install_qmldir.files = $$_PRO_FILE_PWD_/qmldir
    install_qmldir.path = $$installPath
    INSTALLS += install_qmldir

    target.path = $$installPath
    INSTALLS += target
}
