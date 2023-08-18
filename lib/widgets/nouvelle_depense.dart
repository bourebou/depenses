// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import 'package:recette/models/depense.dart';

final formetteur = DateFormat.yMd();

class NouvelleDepense extends StatefulWidget {
  final Function onAjouter;
  const NouvelleDepense({
    Key? key,
    required this.onAjouter,
  }) : super(key: key);

  @override
  State<NouvelleDepense> createState() => _NouvelleDepenseState();
}

class _NouvelleDepenseState extends State<NouvelleDepense> {
  final libellecontroller = TextEditingController();
  final montantController = TextEditingController();
  DateTime? date;
  var categorieChoisie = Categorie.loyer;

  @override
  void dispose() {
    libellecontroller.dispose();
    montantController.dispose();
    super.dispose();
  }
  void messageErreur(){
showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("une erreur est survenue"),
          content: const Text(
              'Assurez-vous que le libelle,le montant et date sont correctes'),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                textStyle: TextStyle(
                  color: Colors.deepPurple[900],
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(ctx).pop();// navigator permet de supprimer les ecrans afficher.ici en partculier le dernier
              },
              child: const Text('ok'),
            ),
          ],
        ),
      );
  }
  void enregistrer() {
    final libelleText = libellecontroller.text
        .trim(); //recuperation du texte saisie dans le champ libelle
    //trim permet de supprimer les double espaces ou triples etc...pour laisser un espace simple
    final libelleValide = libelleText.isNotEmpty &&
        libelleText.length >
            2; //les string ont la propriete isnotempty pour verifier si c est vide ou c est pas vide
    //&&=et,||=ou
    final montant = double.tryParse(montantController.text);
    var montantValide = false;
    if (montant != null) {
      montantValide = montant > 0 && montant < 1000000000;
    }
    final dateValide = date != null;
    print('$libelleText:$libelleValide');
    print('$montant:$montantValide');
    print('$date:$dateValide');

    if (libelleValide && montantValide && dateValide) {//enregistrer
    final aEnregistrer=Depense(
      libelle: libelleText, 
      montant:montant !, date: date!,
       categorie: categorieChoisie);
      widget. onAjouter(aEnregistrer);
      Navigator.of(context).pop();
    } else {
      messageErreur();
    }
  }

  void afficherCalendrier() async {
    // async permet d attendre ce qui va s executer en arriere plan avant de continuer
    final dateChoisie = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(
        const Duration(
          days: 365,
        ),
      ),
      lastDate: DateTime.now(),
    );
    if (dateChoisie != null) {
      setState(() {
        date = dateChoisie;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        //le column n a pas de limite inferieur il peut etre limite par le sizedbox
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'nouvelle depense',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(16 * 2),
          TextField(
            maxLength: 20,
            decoration: const InputDecoration(
              label: Text('libelle'),
            ),
            controller: libellecontroller,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  maxLength: 20,
                  decoration: const InputDecoration(
                    label: Text('montant'),
                    prefix: Text('\$'),
                  ),
                  keyboardType: TextInputType.number,
                  controller: montantController,
                  //pour convertir un string en double
                  //montant=double.tryParse(value)??0
                  //??si et seulement si la valeur nul ca va renvoyer 0
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(date != null
                        ? formetteur.format(date!)
                        : 'CHOISIR DATE'), //on met point d interrogation parce que la valeur ne doit pas etre null
                    const Gap(16),
                    IconButton(
                      onPressed: afficherCalendrier,
                      icon: const Icon(Icons.date_range),
                    ),
                  ],
                ),
              )
            ],
          ),
          const Gap(16),
          Row(
            children: [
              DropdownButton<Categorie>(
                  value: categorieChoisie,
                  items: Categorie.values
                      .map(
                        (e) => DropdownMenuItem(
                          key: ValueKey(e),
                          value: e,
                          child: Text(e.name.toUpperCase()),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        categorieChoisie = value;
                      });
                    }
                    print(value);
                  }),
              //e represente chaque categorie
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.deepPurple,
                ),
                child: const Text('ANNULER'),
              ),
              ElevatedButton(
                onPressed: enregistrer,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.deepPurple[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('AJOUTER'),
              ),
            ],
          ),
        ],
      ),
    ); //context du modalbottomsheet;
  }
}
