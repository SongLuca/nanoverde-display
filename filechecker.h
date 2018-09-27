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
    Q_PROPERTY(QString tagResult READ tagResult NOTIFY newTagResult)

public:
    explicit FileChecker(QObject *parent = nullptr);
    QString tagUsername();
    QString tagResult();
    std::vector<std::string> split(std::string, char);
private:
    QFileSystemWatcher * const watcher;
    QString TAGFILE_PATH = "D:/Program Files/Git Projects/test.txt";
    std::vector<std::string> getLastLine(QString);
    void setPath();


signals:
    void newTagUsername();
    void newTagResult();
};


#endif // FILECHECKER_H
