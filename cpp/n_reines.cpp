#include <iostream>
#include <iomanip>
#include <QDebug>
#include "n_reines.h"
#include <chrono>

using namespace std;

N_Reines::N_Reines(  size_t tailleEchiquier )
    : m_tailleEchiquier( tailleEchiquier ), m_solution( tailleEchiquier ), continuer(true), m_statistique(tailleEchiquier * tailleEchiquier), m_time(0)
{
    std::chrono::time_point<std::chrono::system_clock> start, end;
    start = std::chrono::system_clock::now();
    trouverSolutions(m_solution,0);
    QListFromstdVectorVector();
    QListFromstdVector();
    end = std::chrono::system_clock::now();
    m_time = std::chrono::duration_cast<std::chrono::milliseconds>(end-start).count();
}
bool N_Reines::bonnePlace( const vector<size_t> &solution, size_t numeroReine, size_t numeroLigne )
{
    // Après avoir mis une reine, on la compare à celles déjà en place
    for (size_t i = 0; i < numeroReine; i++)
    {
        // La CONDITION ... multiple
        if ( solution[i] == numeroLigne || // même colonne
             solution[i] == numeroLigne - ( numeroReine - i) ||
             // même diagonale vers la gauche
             solution[i] == numeroLigne + ( numeroReine - i ))
            // et vers la droite ou c'est l'inverse ...

            return false;

    }
    return true;
}
void N_Reines::ajouterSolution(vector<size_t> &solution)
{
    m_lesSolutions.push_back( solution );
    setstatistique(solution);
}
void N_Reines::trouverSolutions( vector<size_t> &solution, size_t numeroReine )
{

    if ( numeroReine == solution.size())
        // Si on a autant de reine que la taille du vector, on est arrivé au bout
        // Ce qui met une fin à la récursion !!
    {
        if(continuer && ((m_lesSolutions.size() == 0) || (m_lesSolutions[m_lesSolutions.size()-1] != solution)))
        {
            ajouterSolution(solution);
        }
        else
        {
            continuer = false;
        }

    }
    else
    {
        // Effectue toutes les combinaisons possibles 8^8 ....
        // Et affiche que les bonnes, voir à la fin au-dessus
        for ( size_t i = 0; i < solution.size(); i++ )
        {
            // dès qu'il y a une reine posée,
            //on vérifie sa position par rapport au reste de l'échiquier
            if ( bonnePlace( solution, numeroReine, i))
            {
                solution[ numeroReine ] = i;

                // Enfin la reine est à sa place on place la suivante
                trouverSolutions( solution, numeroReine + size_t(1) );
            }
        }
    }
}
void N_Reines::QListFromstdVectorVector()
{
    for(auto solution : m_lesSolutions)
    {
        QList<int> temp;
        for(auto valeurs : solution)
        {
            temp.append(valeurs);
        }
        m_qSolutions  << QVariant::fromValue(temp);
    }
}
void N_Reines::QListFromstdVector()
{
    for(auto valeurs : m_statistique)
    {
        m_qStatistique.append(valeurs);
    }
}
void N_Reines::setstatistique(std::vector<size_t> &solution)
{
    for(size_t i =0; i < solution.size(); i++)
    {
        m_statistique[(i*solution.size() + solution[i])] += 1;
    }
}
QList<int> N_Reines::qStatistique() const
{
    return m_qStatistique;
}
int N_Reines::time() const
{
    return m_time;
}
