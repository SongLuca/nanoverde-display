#ifndef FILECHECKER_H
#define FILECHECKER_H

#include <QString>
#include <QObject>
#include <QFileSystemWatcher>

#include <QQmlApplicationEngine>
#include <QGuiApplication>

#include <string.h>
#include <vector>

class FileChecker : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString tagUsername READ tagUsername NOTIFY newTagUsername)

public:
    explicit FileChecker(QObject *parent = nullptr);
    QString tagUsername();
    std::vector<std::string> split(std::string, char);
private:
    QFileSystemWatcher * const watcher;
    QString TAGFILE_PATH = "/home/root/test.txt";
    void setPath();

signals:
    void newTagUsername();
};


#endif // FILECHECKER_H
