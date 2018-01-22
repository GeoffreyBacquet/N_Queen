#ifndef MYAPP_H
#define MYAPP_H

#include <QObject>
#include <QQmlContext>
#include <QDebug>
#include "thread.h"


class Contexte : public QObject
{
    Q_OBJECT

public:
    explicit Contexte(QObject *parent = nullptr);

    void setContext(QQmlContext *contexte);

public slots:
    Q_INVOKABLE void doActionInCpp(QString nomAction, int i = -1);
    void resultat(const QVariantList& qsolution, const QList<int>& qstatistique, const int &time);

private :

    QQmlContext* m_context;
    Controller* m_controller;
};

#endif // MYAPP_H
