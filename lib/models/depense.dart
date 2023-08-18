import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid=Uuid();
final formatDeDate=DateFormat.yMd();
const categoryIcons={
Categorie.loyer:Icons.house,
Categorie.nourriture:Icons.restaurant,
Categorie.vehicule:Icons.car_repair,
Categorie.vetement:Icons.shopping_bag_outlined,
Categorie.scolarite:Icons.book,
Categorie.maison:Icons.house_siding_sharp,
};
enum Categorie {
  nourriture,
  vetement,
  vehicule,
  loyer,
  maison,
  scolarite,
}

class Depense {
  final String id;
  final String libelle;
  final double montant;
  final DateTime date;
  final Categorie categorie;
  Depense({
    required this.libelle,
    required this.montant,
    required this.date,
    required this.categorie,
  }):id=uuid.v4();//UUID permet de generer unidenfiant unique ans le monde 
  //getter permet de recuperer une valeur de maniere securiser
String get dateFormatee{
return formatDeDate.format(date);
}

}
