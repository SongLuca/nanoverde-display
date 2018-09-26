#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>

#include "filechecker.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    qmlRegisterType<FileChecker>("nanodisplay", 1, 0, "FileChecker");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
