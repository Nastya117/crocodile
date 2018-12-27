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
    void addCertificate(QString name, QString path, int type);
    QString getPathByName(QString name, int type);
    QStringList certList();
    void removeCertificate(QString name, int type);
signals:
    void certListChanged();
};

#endif // CERTIFICATES_H
