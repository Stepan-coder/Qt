#ifndef AUTHMANAGER_HPP
#define AUTHMANAGER_HPP

#include <QObject>
#include <QNetworkAccessManager>
#include <QString>

class AuthManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool isAuthProcessing READ isAuthProcessing WRITE setIsAuthProcessing NOTIFY authProcessingChanged)
    Q_PROPERTY(bool isRegProcessing READ isRegProcessing WRITE setIsRegProcessing NOTIFY regProcessingChanged)
public:
    explicit AuthManager(QObject *parent = nullptr);

    Q_INVOKABLE void auth(const QString &login,
                                  const QString &password);
    Q_INVOKABLE void reg(const QString &login,
                                 const QString &password);
    bool isAuthProcessing();
    void setIsAuthProcessing(bool value);
    bool isRegProcessing();
    void setIsRegProcessing(bool value);

private:
    QNetworkAccessManager _net;
    bool m_isAuthProcessing;
    bool m_isRegProcessing;

signals:
    void registerFinished();
    void authFinished(const QString& token);
    void registerFailed(const QString& error);
    void authFailed(const QString& error);
    void authProcessingChanged(bool value);
    void regProcessingChanged(bool value);
};

#endif // AUTHMANAGER_HPP
