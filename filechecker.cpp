#include "filechecker.h"

#include <fstream>
#include <iostream>
#include <string.h>

#include <QObject>
#include <QFileSystemWatcher>
#include <QTimer>
#include <QDebug>

using namespace std;

FileChecker::FileChecker (QObject *parent) : QObject(parent),
    watcher(new QFileSystemWatcher(this))
{
    connect(watcher, &QFileSystemWatcher::fileChanged, this, &FileChecker::newTagUsername);
    QTimer::singleShot(100, this, &FileChecker::setPath);
}

vector<string> FileChecker::getLastLine(QString file)
{
    char token_separator = ';';
    string last_line;
    ifstream fin;
    fin.open(file.toLatin1().data());

    if(fin.is_open()) {
        string line;
        while (getline(fin, line)) {
            bool is_empty = true;
            for (unsigned int i = 0; i < line.size(); i++) {
                char ch = line[i];
                is_empty = is_empty && isspace(ch);
            }
            if (!is_empty) {
                last_line = line;
            }
        }
        fin.close();
    }

    return split(last_line, token_separator);

}

QString FileChecker::tagUsername()
{
    vector<string> line = getLastLine(TAGFILE_PATH);

    if (line.size() == 4) {
        return QString::fromStdString(line[0]);
    }
    else {
        return "NULL";
    }

}

QString FileChecker::tagResult()
{
    vector<string> line = getLastLine(TAGFILE_PATH);

    if (line.size() == 4) {
        return QString::fromStdString(line[1]);
    }
    else {
        return "NULL";
    }

}

vector<string> FileChecker::split(string line, char delimiter) {

    vector<string> result;
    string singleString = "";

    for (unsigned int i=0; i<line.size(); i++) {
        if (line[i] == delimiter) {
            result.push_back(singleString);
            singleString = "";
        }
        else {
            singleString += line[i];
        }
    }

    if (singleString != "") {
        result.push_back(singleString);
    }
    cout << result.size();
    return result;
}

void FileChecker::setPath() {
    watcher->addPath(TAGFILE_PATH);
}
