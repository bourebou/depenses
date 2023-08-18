// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:recette/widgets/historique_item.dart';

import '../models/depense.dart';

class Historique extends StatelessWidget {
  final List<Depense> listDepense;
  final Function onDissmiss;
  const Historique({
    Key? key,
    required this.listDepense,
    required this.onDissmiss,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(//expanded permet de prendre tout l espace disponible 
      child: ListView.builder(//le listvieuw garde juste en memoire ce que loeil humain peut voir
        itemCount: listDepense.length,
        itemBuilder: (context, index) => Dismissible(
          key: ValueKey(listDepense[index].id),
           onDismissed: (direction) => onDissmiss(listDepense[index].id),// cest pour dire 
          child: Historiqueitem(//A chaque fois qu on cree un listview ou gridview le widget qui se repete doit se terminer par le mot idem.
            montant: listDepense[index].montant,
            libelle: listDepense[index].libelle,
            texteData: listDepense[index].dateFormatee,
            icone: categoryIcons[listDepense[index].categorie]!,
          ),
        ),
      ),
    );
  }
}
