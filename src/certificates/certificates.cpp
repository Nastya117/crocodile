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

QString Certificates::getPath(int type)
{
    QString location = QStandardPaths::writableLocation(QStandardPaths::ConfigLocation);
    QDir().mkpath(location + "/cert");
    if (type == 0)
        return location + "/cert/CA.json";
    else
        if (type == 1)
            return location + "/cert/public.json";
    else
            if (type == 2)
                return location + "/cert/private.json";
    else
                if (type == 3)
                    return location + "/cert/privatepass.json";

}

void Certificates::addCertificate(QString name, QString path, int type)
{

    QFile f(getPath(type));
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

QString Certificates::getPathByName(QString name, int type)
{
    QFile f(getPath(type));
    f.open(QFile::ReadOnly);
    QJsonDocument doc = QJsonDocument().fromJson(f.readAll());
    QVariantMap map = doc.toVariant().toMap();
    return map[name].toString();
}

QStringList Certificates::certList()
{
    QString location = QStandardPaths::writableLocation(QStandardPaths::ConfigLocation);
    QDir().mkpath(location + "/cert");
    QString Path = location + "/cert/CA.json";
    QFile f(Path);
    f.open(QFile::ReadOnly);
    QJsonDocument doc = QJsonDocument().fromJson(f.readAll());

    qDebug() << doc.object().keys();

    return doc.object().keys();
}

QStringList Certificates::certKeyList()
{
    QString location = QStandardPaths::writableLocation(QStandardPaths::ConfigLocation);
    QDir().mkpath(location + "/cert");
    QString Path = location + "/cert/public.json";
    QFile f(Path);
    f.open(QFile::ReadOnly);
    QJsonDocument doc = QJsonDocument().fromJson(f.readAll());

    qDebug() << doc.object().keys();

    return doc.object().keys();
}

void Certificates::removeCertificate(QString name, int type)
{
    QFile f(getPath(type));
    f.open(QFile::ReadOnly | QFile::Text);

    QJsonDocument doc = QJsonDocument::fromJson(f.readAll());

    f.close();
    f.open(QFile::WriteOnly | QFile::Text);

    QJsonObject o = doc.object();
    o.remove(name);

    doc.setObject(o);
    f.write(doc.toJson());
    f.close();
    certListChanged();
}
