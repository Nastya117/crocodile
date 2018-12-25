#include "certificates.h"
#include <QStandardPaths>
#include <QFile>
#include <QDir>
#include <QJsonDocument>
#include <QVariantMap>
#include <QJsonObject>
#include <QVariantList>
#include <QDebug>

Certificates::Certificates(QObject *)
{

}

void Certificates::addCertificate(QString name, QString path)
{
    QString location = QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation);
    QDir().mkpath(location + "/cert");
    QString Path = location + "/cert/file.json";
    QFile f(Path);
    f.open(QFile::ReadOnly | QFile::Text);

    QJsonDocument doc = QJsonDocument::fromJson(f.readAll());

    f.close();
    f.open(QFile::WriteOnly | QFile::Text);

    QJsonObject o = doc.object();
    o.insert(name, path);

    doc.setObject(o);
    f.write(doc.toJson());
    f.close();
    certListChanged();
}

QString Certificates::getPathByName(QString name)
{
    QString location = QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation);
    QDir().mkpath(location + "/cert");
    QString Path = location + "/cert/file.json";
    QFile f(Path);
    f.open(QFile::ReadOnly);
    QJsonDocument doc = QJsonDocument().fromJson(f.readAll());
    QVariantMap map = doc.toVariant().toMap();
    return map[name].toString();
}

QStringList Certificates::certList()
{
    QString location = QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation);
    QDir().mkpath(location + "/cert");
    QString Path = location + "/cert/file.json";
    QFile f(Path);
    f.open(QFile::ReadOnly);
    QJsonDocument doc = QJsonDocument().fromJson(f.readAll());

    qDebug() << doc.object().keys();

    return doc.object().keys();
}
