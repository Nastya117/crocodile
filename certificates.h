#ifndef CERTIFICATES_H
#define CERTIFICATES_H
#include <QString>

#include <QObject>

class Certificates : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QStringList certList READ certList NOTIFY certListChanged)
    Q_PROPERTY(QStringList certKeyList READ certKeyList NOTIFY certListChanged)
public:
    Certificates(QObject* = nullptr);
    QString getPath(int type);

public slots:
    void addCertificate(QString name, QString path, int type);
    QString getPathByName(QString name, int type);
    QStringList certList();
    QStringList certKeyList();
    void removeCertificate(QString name, int type);
signals:
    void certListChanged();
};

#endif // CERTIFICATES_H
