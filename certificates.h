#ifndef CERTIFICATES_H
#define CERTIFICATES_H
#include <QString>

#include <QObject>

class Certificates : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QStringList certList READ certList NOTIFY certListChanged)
public:
    Certificates(QObject* = nullptr);

public slots:
    void addCertificate(QString name, QString path);
    QString getPathByName(QString name);
    QStringList certList();
signals:
    void certListChanged();
};

#endif // CERTIFICATES_H
