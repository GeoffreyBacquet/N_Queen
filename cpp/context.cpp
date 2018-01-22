#include <iostream>
#include "context.h"
#include <time.h>

using namespace std;

Contexte::Contexte( QObject *parent ) : QObject( parent ), m_context( nullptr )
{
    m_controller = nullptr;
}
void Contexte::setContext(QQmlContext *context)
{
    m_context = context;
    m_context->setContextProperty( "Context", this );
    doActionInCpp("entrezTaille",4);
}
void Contexte::doActionInCpp( QString nomAction, int i )
{
    if( nomAction == "entrezTaille" && i >= 4 )
    {
        if(m_controller != nullptr)
        {
            m_controller->disconnect();
            delete m_controller;
        }
        m_controller = new Controller();
        m_controller->operate(i);
        m_context->setContextProperty("chargement", "start" );
        connect(m_controller, &Controller::fini, this, &Contexte::resultat);

    }

    else if(nomAction == "navigation")
    {
         m_context->setContextProperty( "solution", QVariant::fromValue( m_controller->solutionstock().at(i)));
    }
}
void Contexte::resultat(const QVariantList &qsolution, const QList<int> &qstatistique, const int &time)
{
    if( m_context!= nullptr)
    {
        m_context->setContextProperty( "solution", QVariant::fromValue( qsolution.at(0)));
        m_context->setContextProperty( "nombresolution", QVariant::fromValue(qsolution.size()));
        m_context->setContextProperty( "statistique", QVariant::fromValue( qstatistique));
        m_context->setContextProperty( "tempsdecalcul", QVariant::fromValue( time));
        m_context->setContextProperty("chargement", "stop" );
    }
}
