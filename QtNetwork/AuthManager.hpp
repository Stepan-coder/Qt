#ifndef AUTHMANAGER_HPP
#define AUTHMANAGER_HPP

#include <QObject>
#include <QNetworkAccessManager>
#include <QString>

class AuthManager : public QObject
{
    Q_OBJECT
public:
    explicit AuthManager(QObject *parent = nullptr);

    void authenticate(const QString &login,
                      const QString &password);
    void registering(const QString &login,
                     const QString &password);


private:
    QNetworkAccessManager _net;

signals:
    void registerOk(QString);
    void authOk(QString, QString);
};

#endif // AUTHMANAGER_HPP
