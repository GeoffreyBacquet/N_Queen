#ifndef N_REINES_H
#define N_REINES_H

#include <QVector>
#include <vector>
#include <QObject>
#include <QVariant>
#include <QDebug>

class N_Reines : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVariantList qSolutions READ qSolutions WRITE setqSolutions NOTIFY qSolutionsChanged)
    Q_PROPERTY(QList<int> qStatistique READ qStatistique WRITE setqStatistique NOTIFY qStatistiqueChanged)
    Q_PROPERTY(int time READ time WRITE setTime NOTIFY timeChanged)

public:

    N_Reines(size_t tailleEchiquier);

    ~N_Reines()
    {
    }

    bool bonnePlace(const std::vector<size_t> &solution, size_t numeroReine, size_t numeroLigne );

    void trouverSolutions( std::vector<size_t> &solution, size_t numeroReine );

    std::vector<std::vector<size_t>> lesSolutions();

    void QListFromstdVectorVector();

    void QListFromstdVector();

    void setstatistique(std::vector<size_t> &solution);

    QVariantList qSolutions() const
    {
        return m_qSolutions;
    }

    QList<int> qStatistique() const;

    int time() const;

    void ajouterSolution(std::vector<size_t> &solution);

public slots:

    void setqSolutions(QVariantList qSolutions)
    {
        if (m_qSolutions == qSolutions)
            return;

        m_qSolutions = qSolutions;
        emit qSolutionsChanged(m_qSolutions);
    }

    void setqStatistique(QList<int> qStatistique)
    {
        if (m_qStatistique == qStatistique)
            return;

        m_qStatistique = qStatistique;
        emit qStatistiqueChanged(m_qStatistique);
    }


    void setTime(int time)
    {
        if (m_time == time)
            return;

        m_time = time;
        emit timeChanged(m_time);
    }

signals:
    void qSolutionsChanged(QVariantList qSolutions);

    void qStatistiqueChanged(QList<int> qStatistique);

    void timeChanged(int time);

private :
    size_t m_tailleEchiquier;
    std::vector<size_t> m_solution;
    bool continuer;

    std::vector<std::vector<size_t>> m_lesSolutions;
    QVariantList m_qSolutions;

    QVector<int> m_statistique;
    QList<int> m_qStatistique;

    int m_time;
};

#endif // N_REINES_H
