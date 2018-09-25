#include "filechecker.h"

#include <fstream>
#include <iostream>
#include <string.h>

#include <QObject>
#include <QFileSystemWatcher>
#include <QDebug>

using namespace std;

FileChecker::FileChecker (QObject *parent) : QObject(parent)
{
    watcher = new QFileSystemWatcher(parent);
    watcher->addPath(TAGFILE_PATH);
    connect(watcher, &QFileSystemWatcher::fileChanged, this, &FileChecker::newTagUsername);
}

QString FileChecker::tagUsername()
{
    vector<string> lastLineUsername;
    char token_separator = ';';
    string last_line;
    ifstream fin;
    fin.open(TAGFILE_PATH.toLatin1().data());
    if(fin.is_open()) {
        string line;
        while (getline(fin, line)) {
            bool is_empty = true;
            for (int i = 0; i < line.size(); i++) {
                char ch = line[i];
                is_empty = is_empty && isspace(ch);
            }
            if (!is_empty) {
                last_line = line;
            }
        }
        fin.close();
    }

    lastLineUsername = split(last_line, token_separator);
    return QString::fromStdString(lastLineUsername[0]);
}

vector<string> FileChecker::split(string line, char delimiter) {

    vector<string> result;
    string singleString = "";

    for (int i=0; i<line.size(); i++) {
        if (line[i] == delimiter) {
            result.push_back(singleString);
            singleString = "";
        }
        else {
            singleString += line[i];
        }
    }
    result.push_back(singleString);
    return result;
}
