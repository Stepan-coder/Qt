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

void AuthManager::authenticate(const QString &login,
                                  const QString &password)
{
    QUrl url ("http://127.0.0.1:51572/auth");
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
        QString errorMsg = reply->errorString();
        QJsonObject obj = QJsonDocument::fromJson(reply->readAll()).object();
        QString token = obj.value("token").toString();
        authOkCompleted(reply -> errorString(), token);
        reply -> deleteLater();
    });
}

void AuthManager::registering(const QString &login,
                               const QString &password)
{
    QUrl url ("http://127.0.0.1:51572/register");
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader,
                      "application/json");
    QJsonObject body;
    body["login"] = login;
    body["password"] = password;
    QByteArray bodyData = QJsonDocument(body).toJson();
    QNetworkReply *reply = _net.post(request, bodyData);
    connect(reply, &QNetworkReply::finished, [this, reply](){
        emit registerCompleted(reply -> errorString());
        reply -> deleteLater();
    });
}
