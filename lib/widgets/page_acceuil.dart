import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recette/widgets/graphique.dart';

import 'package:recette/widgets/historique.dart';
import 'package:recette/models/depense.dart';
import 'package:recette/widgets/nouvelle_depense.dart';

class PageAcceuil extends StatefulWidget {
  const PageAcceuil({super.key});

  @override
  State<PageAcceuil> createState() => _PageAcceuilState();
}

class _PageAcceuilState extends State<PageAcceuil> {
  //  l etat ce sont les donnees qui changent pour mettre a jour notre interface
  double dollars = 215.99;
   final List<Depense> depenses = [];
  void ajouterDepense(Depense depenseAAjouter) {
    setState(() {
      depenses.add(
          depenseAAjouter); //POUR INSERER A la toute premiere position mettre depenses.insert(0,depenseAAjouter)
    });
  }
  

  void supprimerDepense(String id) {
    final aSupprimer = depenses.firstWhere(
      (chaqueDepense) => chaqueDepense.id == id,
    );
    final index = depenses.indexOf(aSupprimer);//indexof inserer a sa position initiale
    setState(() {
      
      depenses.remove(aSupprimer);
    });
    //vous avez supprime
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('vous avez supprime cette depense'),
        action: SnackBarAction(
          label: 'ANNULER',
          onPressed: () {
            setState(() {
              depenses.insert(index, aSupprimer);
            });
          },
        ),
      ),
    );
  }

  void afficherFormulaire() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => NouvelleDepense(
          onAjouter:
              ajouterDepense), //on met quand c est une fonction qui doit etre appele quand on appui sur un bouton
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[900],
        title: const Text('suivi des depenses'),
        actions: [
          IconButton(
            onPressed: afficherFormulaire,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:depenses.isEmpty? const Center(
child: Text('aucune depense enregistree'),
        ):
         Column(
          children: [
             Graphique(depenses: depenses),
            const Gap(20),
            Historique(
              listDepense: depenses,
              onDissmiss: supprimerDepense,
            ),
          ],
        ),
      ),
    );
  }
}
