#include "AuthManager.hpp"
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QUrl>
#include <QJsonObject>
#include <QJsonDocument>
#include <QDebug>

AuthManager::AuthManager(QObject *parent) : QObject(parent)
{

}

void AuthManager::auth(const QString &login, const QString &password)
{
    setIsAuthProcessing(true);
    QUrl url ("http://127.0.0.1:64862/auth");
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader,
                      "application/json");
    QJsonObject body;
    body["login"] = login;
    body["password"] = password;

    QByteArray bodyData = QJsonDocument(body).toJson();
    QNetworkReply *reply = _net.post(request, bodyData);

    connect(reply, &QNetworkReply::finished,
            [this, reply]()
    {
        if(reply->error()!=QNetworkReply::NoError)
            emit authFailed(reply->errorString());
        else
        {
            QJsonObject obj = QJsonDocument::fromJson(reply->readAll()).object();
            emit authFinished(obj.value("token").toString());
        }
        reply -> deleteLater();
        setIsAuthProcessing(false);
    });
}

void AuthManager::reg(const QString &login, const QString &password)
{
    setIsRegProcessing(true);
    QUrl url ("http://127.0.0.1:64862/register");
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader,
                      "application/json");
    QJsonObject body;
    body["login"] = login;
    body["password"] = password;
    QByteArray bodyData = QJsonDocument(body).toJson();
    QNetworkReply *reply = _net.post(request, bodyData);
    connect(reply, &QNetworkReply::finished, [this, reply]()
    {
        if(reply->error()!=QNetworkReply::NoError)
            emit registerFailed(reply->errorString());
        else
            emit registerFinished();
        reply->deleteLater();
        setIsRegProcessing(false);
    });
}

bool AuthManager::isAuthProcessing()
{
    return m_isAuthProcessing;
}

bool AuthManager::isRegProcessing()
{
    return m_isRegProcessing;
}

void AuthManager::setIsRegProcessing(bool value)
{
    if(m_isRegProcessing==value)
        return;
    m_isRegProcessing = value;
    emit regProcessingChanged(value);
}

void AuthManager::setIsAuthProcessing(bool value)
{
    if(m_isAuthProcessing==value)
        return;
    m_isAuthProcessing = value;
    emit authProcessingChanged(value);
}
