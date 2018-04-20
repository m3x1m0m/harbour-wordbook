#ifdef QT_QML_DEBUG
#include <QtQuick>
#endif

#include <sailfishapp.h>
#include <QQmlEngine>
#include <QScopedPointer>
#include "dict_model.h"

int main(int argc, char *argv[])
{
    // Set up qml engine.
    QScopedPointer<QGuiApplication> app(SailfishApp::application(argc, argv));
    QScopedPointer<QQuickView> v(SailfishApp::createView());

    // If you wish to publish your app on the Jolla harbour, follow
    // https://harbour.jolla.com/faq#5.3.0 about naming own QML modules.
    qmlRegisterType<DictModel>("com.dictcc", 1, 0, "DictModel");

    // Start the application.
    v->setSource(SailfishApp::pathTo("qml/harbour-wordbook.qml"));
    v->show();
    return app->exec();
}
