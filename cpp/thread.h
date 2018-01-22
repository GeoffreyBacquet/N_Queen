#ifndef THREAD_H
#define THREAD_H

#include "n_reines.h"
#include <QThread>
#include <QObject>
#include <QDebug>

class Worker : public QObject
{
    Q_OBJECT

public slots:
    void doWork(const int &tailleEchequier)
    {
        N_Reines reine(tailleEchequier);
        emit resultReady( reine.qSolutions(), reine.qStatistique(), reine.time() );
    }

signals:
    void resultReady(const QVariantList& qSolutions, const QList<int>& qStatistique, const int& time);

};

class Controller : public QObject
{
    Q_OBJECT
    QThread workerThread;

public:
    Controller()
    {
        Worker *worker = new Worker;

        connect(&workerThread, &QThread::finished, worker, &QObject::deleteLater);
        connect(this, &Controller::operate, worker, &Worker::doWork, static_cast<Qt::ConnectionType>(Qt::UniqueConnection));
        connect(worker, &Worker::resultReady, this, &Controller::handleResults);

        worker->moveToThread(&workerThread);

        workerThread.start();
    }

    ~Controller() {
        workerThread.quit();
        workerThread.requestInterruption();
        workerThread.wait();
    }

    QVariantList solutionstock() const
    {
        return m_solutionstock;
    }

public slots:
    void handleResults(const QVariantList& qSolutions, const QList<int>& qStatistique, const int& time)
    {
        emit fini(qSolutions, qStatistique, time);
        m_solutionstock = qSolutions;
    }

signals:
    void operate(const int &tailleEchequier);
    void fini(const QVariantList& qSolutions, const QList<int>& qStatistique, const int& time);

private:
    QVariantList m_solutionstock;
};

#endif // THREAD_H
