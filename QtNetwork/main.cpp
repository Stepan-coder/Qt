#include <QCoreApplication>

#include "AuthManager.hpp"
int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);

    AuthManager auth;
    auth.registering("first_login", "first_password");
    auth.authenticate("first_login", "first_password");
    auth.registering("second_login", "second_password");
    auth.authenticate("second_login", "second_password");
    return a.exec();
}
