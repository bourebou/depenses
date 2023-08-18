import 'package:flutter/material.dart';
import 'package:recette/widgets/graphique_item.dart';

import '../models/depense.dart';

class Graphique extends StatelessWidget {
  final List<Depense> depenses;
  const Graphique({super.key, required this.depenses});
  double sommeDepenses() {
    var somme = 0.0;
    for (var chaquedepense in depenses) {
      somme = somme + chaquedepense.montant;
    }
    return somme;
  }

  double sommeCategorie(Categorie cat) {
    final depenseCat = depenses.where(
      (element) => element.categorie == cat,
    );
    var somme = 0.0;
    for (var depense in depenseCat) {
      somme = somme + depense.montant;
    }
    return somme;
  }

  @override
  Widget build(BuildContext context) {
    final depensesTotal = sommeDepenses();
    return Container(
      height: 250,
      width: double.infinity,
      color: Colors.grey[300],
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...Categorie.values.map(
            (Categorie) => GraphiqueItem(
              icone: categoryIcons[Categorie]!,
              pourcentage: sommeCategorie(Categorie) / depensesTotal,
            ),
          ), //enumeration
        ],
      ),
    );
  }
}
